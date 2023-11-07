global class BatchProcessBillingToYayPay implements Database.Batchable<sObject>,Database.AllowsCallouts,Database.Stateful, Schedulable {
    
    Public Set<Id> billingIds;
    Public DateTime tokenGenerateTime;
    Public DateTime tokenExpiaryTime;
    Public String accessToken;
    Public Integer tokenGenerateCount =0 ;
    Public String transactionId;
    Public List<AcctSeed__Billing__c> billingsToUpdate;
    
    global BatchProcessBillingToYayPay(){
        billingIds = new Set<Id>();
        billingsToUpdate = new list<AcctSeed__Billing__c>();
    }
    global BatchProcessBillingToYayPay(Set<Id> Ids){
        billingIds = Ids;
        billingsToUpdate = new list<AcctSeed__Billing__c>();
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = ' SELECT Id, Name, AcctSeed__Customer__c, IsDeleted, Internal__c, YayPay_Last_Sync_Date__c, '+
                        ' AcctSeed__Date__c, AcctSeed__Total__c, AcctSeed__Credit_Memo_Applied_Amount__c, ' +
                        ' ( SELECT Id, Name, AcctSeed__Amount__c, AcctSeed__Applied_Date__c, ' +
                        ' AcctSeed__Billing_Credit_Memo__c, AcctSeed__Billing_Invoice__c, '+
                        ' AcctSeed__Billing_Invoice__r.inscoras__Invoice__c, ' +
                        ' AcctSeed__Billing_Invoice__r.inscoras__Invoice__r.Yaypay_Last_Sync_date__c, ' +
                        ' AcctSeed__Billing_Invoice__r.AcctSeed__Received_Amount__c, ' +
            			' AcctSeed__Billing_Invoice__r.AcctSeed__Billing_Comment__c ' +
                        ' FROM AcctSeed__Billing_Credit_Memos__r ) '+
                        ' FROM  AcctSeed__Billing__c '+
                        ' WHERE Id != null';
        
        if(billingIds.size() > 0){
            query += ' AND Id IN: billingIds';
        }else{
            query += ' AND Is_Processed__c = FALSE '
           		  + ' AND AcctSeed__Total__c != 0 AND AcctSeed__Customer__c != null AND AcctSeed__Status__c = \'Posted\' ' +
                  +	' AND AcctSeed__Type__c = \'Credit Memo\' ';
                  //+ ' AND Internal__c = FALSE ';
        }
        query += '  ORDER By Is_Error__c ASC,LastModifiedDate DESC LIMIT 10';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<AcctSeed__Billing__c> billings ){
        
        List<YayPay_Other_Charges_Configuration__mdt> YayPayOtherCharges = [ SELECT Id, DeveloperName, MasterLabel 
                                                                            FROM YayPay_Other_Charges_Configuration__mdt ];
        Map<String, YayPay_Other_Charges_Configuration__mdt> mapYayPayOtherCharges = new Map<String, YayPay_Other_Charges_Configuration__mdt>();
        
        for( YayPay_Other_Charges_Configuration__mdt meta : YayPayOtherCharges ){
            mapYayPayOtherCharges.put( meta.MasterLabel, meta );
        }
        if( !YayPayUtility.sendYayPayCallout() ){
            return;
        }
        if( billings.size() > 0 ){
            AcctSeed__Billing__c billObj = billings.get(0);
            if( TokenExpiaryTime == null || TokenExpiaryTime < System.now() ){
                        //get Access Token for Request API.
                        accessToken = YayPayAuthentication.getAccessToken(); 
                        TokenExpiaryTime = System.now().addMinutes(50);
                        //starting transaction.
                        transactionId = YayPayTransactionAPIService.startTransaction( accessToken );
                    }
            if( billObj.Internal__c && billObj.YayPay_Last_Sync_Date__c != null ){
                YayPayAPIService.deleteRecordsFromYayPay( New List<String>{ billObj.Id }, 'payments', accessToken, transactionId );
                billObj.YayPay_Last_Sync_Date__c = System.now();
                billObj.Is_Processed__c = TRUE;
                billingsToUpdate.add( billObj );
            }else if( !billObj.Internal__c ){
                try{      
                    
                    set<String> invoiceNumbers = new set<String>();
                    Boolean notHasInvoiceAndSynced = false;
                    for( AcctSeed__Billing_Credit_Memo__c cm : billObj.AcctSeed__Billing_Credit_Memos__r ){
                     
                        notHasInvoiceAndSynced = cm.AcctSeed__Billing_Invoice__r.inscoras__Invoice__r.Yaypay_Last_Sync_date__c == null ? TRUE : FALSE;
                        if( notHasInvoiceAndSynced ){
                            if( !mapYayPayOtherCharges.containsKey( cm.AcctSeed__Billing_Invoice__r.AcctSeed__Billing_Comment__c ) ){
                                billObj.Is_Error__c = TRUE;
                                billObj.YayPay_Error_Message__c = 'invoice on related billing not found';
                                billingsToUpdate.add( billObj );
                                return;
                            }
                        }
                        if( cm.AcctSeed__Billing_Invoice__c != null ){
                            invoiceNumbers.add( cm.AcctSeed__Billing_Invoice__r.inscoras__Invoice__c );
                        }
                    }
                    
                    String errorString;
                    
                    if( String.isBlank(errorString) ){                    
                        
                        set<String> customerIds = new set<String>();
                        
                        list<AcctSeed__Billing__c> billingList = new list<AcctSeed__Billing__c>(); 
                        billingList.add( billObj );
                        
                        for( AcctSeed__Billing__c bill : billingList ){
                            customerIds.add( bill.AcctSeed__Customer__c );
                        }                    
                        
                        list<Account> accountList = [ SELECT Id, Name, Site, ShippingCity, ShippingState, ParentId,
                                                     inscor__Billing_Contact__r.Email, inscor__Account_Terms__r.Name,
                                                     DNBI__DnB_DUNS_NO__c, inscor__Credit_Limit__c, inscor__Account_Region__c,
                                                     DNBI__DnB_Payment_Terms__c, AcctSeed__Taxpayer_Identification_Number__c,
                                                     ShippingPostalCode, ShippingStreet, ShippingCountry,Phone, Website
                                                     FROM Account WHERE Id IN :customerIds ];
                        
                        //Process Customer.
                        Integer responseCodeCustomer = YayPayAPIService.sendCustomerToYayPay( accountList, accessToken, transactionId );
                        
                        //Process Billing.
                        Integer responseCodeBilling;
                        if( billingList.size() > 0 ){
                            responseCodeBilling = YayPayAPIService.sendBillingToYayPay( billingList, accessToken, transactionId );
                        }     
                        
                        billObj.YayPay_Last_Sync_Date__c = System.now();
                        billObj.Is_Processed__c = TRUE;
                    }
                    else{
                        billObj.YayPay_Error_Message__c = errorString;
                        billObj.Is_Processed__c = TRUE;
                    }
                    billingsToUpdate.add( billObj );
                    
                    
                    String invoiceQuery = ' SELECT Id, Name, inscor__Account__c, inscor__Billing_Contact__c, inscor__Customer_PO_Number__c,'+
                        'inscor__Billing_Contact__r.Email, inscor__Account__r.Id, inscor__Invoice_Date__c, '+
                        ' inscor__Billing_Contact__r.Id, inscor__Status__c, inscor__Total_Invoice__c, '+
                        ' ( SELECT Id, Name, inscor__Quantity__c, inscor__Price__c, inscor__Item__r.inscor__Description__c,'+
                        '  inscor__Item__r.Name, inscor__Extended_Price__c FROM inscor__Invoice_Lines__r ), '+
                        ' ( SELECT Id, Name, inscor__Receivable_Amount__c, inscor__External_Reference_ID__c, '+
                        ' inscor__INVC_Date__c, inscor__Line_Value__c, inscor__INVC__r.Id, inscor__Customer_Vendor__r.Id'+
                        '  FROM inscor__Transaction_Activities__r ) '+
                        ' FROM  inscor__Invoice__c '+
                        ' WHERE Id IN :invoiceNumbers';
                    list<inscor__Invoice__c> relatedInvoices = Database.query(invoiceQuery);
                    
                    List<inscor__Invoice__c> invoicesToUpdate = new List<inscor__Invoice__c>();
                    for( inscor__Invoice__c invObj : relatedInvoices ){
                        try{
                            String errorStringInvoice = BatchProcessInvoiceToYayPay.validateInvoiceRequest( invObj );
                            if( String.isBlank(errorString) ){
                                Integer responseCodeInvoice = YayPayAPIService.sendInvoiceToYayPay( invObj, accessToken, transactionId );
                                invObj.YayPay_Last_Sync_Date__c = System.now();
                                invObj.Is_Processed__c = TRUE;
                            }else{
                                invObj.YayPay_Error_Message__c = errorStringInvoice;
                                invObj.Is_Processed__c = TRUE;
                            }
                            invoicesToUpdate.add( invObj );
                        }catch( exception e ){
                            invObj.Is_Processed__c = TRUE;
                            if( ! invoicesToUpdate.contains( invObj ) ){
                                invoicesToUpdate.add( invObj  );
                            }
                        }
                        
                    }
                    update invoicesToUpdate;
                }
                catch( exception error ){
                    billObj.Is_Processed__c = TRUE;
                    if( ! billingsToUpdate.contains( billObj ) ){
                        billingsToUpdate.add( billObj  );
                    }
                    LogService.createErrorLog('BatchProcessBillingToYayPay.execute', NULL, error, NULL);
 }
            }
        }            
    }
    
    global void execute(SchedulableContext sc) {
        Database.executeBatch(new BatchProcessBillingToYayPay(), 1 );
    }
    
    global void finish(Database.BatchableContext bc){
        try{
            //Finish transaction.
            Integer transactionFinishCode = YayPayTransactionAPIService.finishTransaction( accessToken, transactionId ); 
            update billingsToUpdate;
        }catch( exception error ){
            LogService.createErrorLog('BatchProcessBillingToYayPay.finish', NULL, error, NULL);
        }
    }
}