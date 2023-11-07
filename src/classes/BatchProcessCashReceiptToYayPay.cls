global class BatchProcessCashReceiptToYayPay implements Database.Batchable<sObject>,Database.AllowsCallouts,Database.Stateful, Schedulable {
    
    Public Set<Id> receiptIds;
    Public DateTime TokenGenerateTime;
    Public DateTime TokenExpiaryTime;
    Public String accessToken;
    Public Integer tokenGenerateCount =0 ;
    Public String transactionId;
    Public List<AcctSeed__Cash_Receipt__c> receiptsToUpdate;
    global BatchProcessCashReceiptToYayPay(){
        receiptIds = new Set<Id>();
        receiptsToUpdate = new list<AcctSeed__Cash_Receipt__c>();
    }
    global BatchProcessCashReceiptToYayPay(Set<Id> Ids){
        receiptIds = Ids;
        receiptsToUpdate = new list<AcctSeed__Cash_Receipt__c>();
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id, Name, AcctSeed__Amount__c,  Internal__c, YayPay_Last_Sync_Date__c,  '+
            ' AcctSeed__Account__c, AcctSeed__Applied_Amount__c, AcctSeed__Status__c, ' +
            ' AcctSeed__Receipt_Date__c, IsDeleted, ' +
            ' ( SELECT Id, Name, AcctSeed__Billing__c, AcctSeed__Applied_Amount__c, ' +
            ' AcctSeed__Applied_Date__c, AcctSeed__Billing__r.inscoras__Invoice__c, ' +
            ' AcctSeed__Billing__r.inscoras__Invoice__r.Yaypay_Last_Sync_date__c, ' +
            ' AcctSeed__Billing__r.AcctSeed__Billing_Comment__c, ' +
            ' AcctSeed__Billing__r.AcctSeed__Received_Amount__c ' +
           ' FROM AcctSeed__Billing_Cash_Receipts__r ) ' +
            ' FROM  AcctSeed__Cash_Receipt__c '+
            ' WHERE Id != null';
        
        if(receiptIds.size() > 0){
            query += ' AND Id IN: receiptIds';
        }else{
            query += ' AND Is_Processed__c = FALSE '
                + ' AND AcctSeed__Amount__c != 0 '+
                + ' AND AcctSeed__Account__c != null AND AcctSeed__Status__c = \'Posted\' ';
                //+ ' AND Internal__c = FALSE ';
        }
        
        query += ' ORDER By Is_Error__c ASC,LastModifiedDate DESC LIMIT 10 ';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<AcctSeed__Cash_Receipt__c> receipts ){
        List<YayPay_Other_Charges_Configuration__mdt> YayPayOtherCharges = [ SELECT Id, DeveloperName, MasterLabel 
                                                                                      FROM YayPay_Other_Charges_Configuration__mdt ];
        Map<String, YayPay_Other_Charges_Configuration__mdt> mapYayPayOtherCharges = new Map<String, YayPay_Other_Charges_Configuration__mdt>();
        
        for( YayPay_Other_Charges_Configuration__mdt meta : YayPayOtherCharges ){
            mapYayPayOtherCharges.put( meta.MasterLabel, meta );
        }
        
        if( !YayPayUtility.sendYayPayCallout() ){
            return;
        }
        AcctSeed__Cash_Receipt__c receiptObj = receipts.get(0);

        list<AcctSeed__Cash_Receipt__c> receiptList = new list<AcctSeed__Cash_Receipt__c>(); 
        receiptList.add( receiptObj );        
        if( TokenExpiaryTime == null || TokenExpiaryTime < System.now() ){
            //get Access Token for Request API.
            accessToken = YayPayAuthentication.getAccessToken(); 
            TokenExpiaryTime = System.now().addMinutes(50);
            //starting transaction.
            transactionId = YayPayTransactionAPIService.startTransaction( accessToken );
        }
        
        if( ( receiptObj.Internal__c && receiptObj.YayPay_Last_Sync_Date__c != null ) ){
            YayPayAPIService.deleteRecordsFromYayPay( New List<String>{ receiptObj.Id }, 'payments', accessToken, transactionId );
            receiptObj.YayPay_Last_Sync_Date__c = System.now();
            receiptObj.Is_Processed__c = TRUE;
            receiptsToUpdate.add( receiptObj );
        }else if( !receiptObj.Internal__c ){            
            try{    
                set<String> invoiceNumbers = new set<String>();
                Boolean notHasInvoiceAndSynced = false;
                for( AcctSeed__Billing_Cash_Receipt__c bcrpt : receiptObj.AcctSeed__Billing_Cash_Receipts__r ){
                    
                    notHasInvoiceAndSynced = bcrpt.AcctSeed__Billing__r.inscoras__Invoice__r.Yaypay_Last_Sync_date__c == null ? TRUE : FALSE;
                    if( notHasInvoiceAndSynced ){
                        if( !mapYayPayOtherCharges.containsKey( bcrpt.AcctSeed__Billing__r.AcctSeed__Billing_Comment__c ) ){
                           receiptObj.Is_Error__c = TRUE;
                            receiptObj.YayPay_Error_Message__c = 'invoice on related billing not found';
                            receiptsToUpdate.add( receiptObj );
                            return;  
                        }
                   }
                    if( bcrpt.AcctSeed__Billing__c != null ){
                        invoiceNumbers.add( bcrpt.AcctSeed__Billing__r.inscoras__Invoice__c );
                    }
                }
                if( receipts.size() > 0 ){
                    
                    String errorString;    
                    if( String.isBlank(errorString) ){
                        
                        System.debug( errorString );
                        set<String> customerIds = new set<String>();
                        for( AcctSeed__Cash_Receipt__c rpt : receiptList ){
                            customerIds.add( rpt.AcctSeed__Account__c );
                        }                    
                        
                        list<Account> accountList = [ SELECT Id, Name, Site, ShippingCity, ShippingState, ParentId, 
                                                     inscor__Billing_Contact__r.Email, DNBI__DnB_DUNS_NO__c, inscor__Credit_Limit__c,
                                                     DNBI__DnB_Payment_Terms__c, AcctSeed__Taxpayer_Identification_Number__c,
                                                     inscor__Account_Region__c, inscor__Account_Terms__r.Name,
                                                     ShippingPostalCode, ShippingStreet, ShippingCountry,Phone, Website
                                                     FROM Account WHERE Id IN :customerIds ];
                        
                        //Process Customer.
                        Integer responseCodeCustomer = YayPayAPIService.sendCustomerToYayPay( accountList, accessToken, transactionId );
                        System.debug( responseCodeCustomer );
                        //Process Receipt.
                        Integer responseCodeReceipt;
                        if( receiptList.size() > 0 ){
                            responseCodeReceipt = YayPayAPIService.sendReceiptToYayPay( receiptList, accessToken, transactionId );
                        }     
                        System.debug( responseCodeReceipt );
                        receiptObj.YayPay_Last_Sync_Date__c = System.now();
                        receiptObj.Is_Processed__c = TRUE;
                    }
                    else{
                        receiptObj.YayPay_Error_Message__c = errorString;
                        receiptObj.Is_Processed__c = TRUE;
                    }
                    receiptsToUpdate.add( receiptObj );
                                        
                    String invoiceQuery = ' SELECT Id, Name, inscor__Account__c, inscor__Billing_Contact__c, inscor__Customer_PO_Number__c,'+
                        ' inscor__Account_Terms__r.inscor__Number_of_Days__c, '+
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
                        inscor__Invoice__c invoice = new inscor__Invoice__c( Id = invObj.Id );
                        try{
                            String errorStringInvoice = BatchProcessInvoiceToYayPay.validateInvoiceRequest( invObj );
                            if( String.isBlank(errorString) ){
                                Integer responseCodeInvoice = YayPayAPIService.sendInvoiceToYayPay( invObj, accessToken, transactionId );
                                invoice.YayPay_Last_Sync_Date__c = System.now();
                                invoice.Is_Processed__c = TRUE;
                            }else{
                                invoice.YayPay_Error_Message__c = errorStringInvoice;
                                invoice.Is_Processed__c = TRUE;
                            }
                            invoicesToUpdate.add( invoice );
                        }catch( exception e ){
                            LogService.createErrorLog('BatchProcessInvoiceToYayPay.apxc', NULL, e, NULL);
                            invoice.Is_Processed__c = TRUE;
                            if( ! invoicesToUpdate.contains( invoice ) ){
                                invoicesToUpdate.add( invoice  );
                            }
                        }
                        
                    }
                    if( invoicesToUpdate.size() > 0 ){
                        update invoicesToUpdate;
                    }
                }     
            }
            catch( exception error ){
                receiptObj.Is_Processed__c = TRUE;
                if( ! receiptsToUpdate.contains( receiptObj ) ){
                    receiptsToUpdate.add( receiptObj  );
                }
                LogService.createErrorLog('BatchProcessCashReceiptToYayPay.execute', NULL, error, NULL);
            }
        }
    }
    global void execute(SchedulableContext sc) {
        Database.executeBatch(new BatchProcessCashReceiptToYayPay(), 1 );
    }
    
    global void finish(Database.BatchableContext bc){
        try{
            //Finish transaction.
            Integer transactionFinishCode = YayPayTransactionAPIService.finishTransaction( accessToken, transactionId ); 
            update receiptsToUpdate;
        }catch( exception error ){
            LogService.createErrorLog('BatchProcessCashReceiptToYayPay.finish', NULL, error, NULL);
        }
    }
}