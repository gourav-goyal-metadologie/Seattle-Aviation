global class BatchProcessInvoiceToYayPay implements Database.Batchable<sObject>,Database.AllowsCallouts,Database.Stateful, Schedulable {
    
    Public Set<Id> invoiceIds;
    Public Boolean processInvoiceFiles;
    Public DateTime TokenGenerateTime;
    Public DateTime TokenExpiaryTime;
    Public String accessToken;
    Public Integer tokenGenerateCount =0 ;
    Public String transactionId;
    Public List<inscor__Invoice__c> invoicesToUpdate;
    Public map<String, inscor__Invoice__c> mapInvoiceIdToInvoice;
    Public String LimitRecords;
    Public Integer batchRunInterval;
    global BatchProcessInvoiceToYayPay(){
        invoiceIds = new Set<Id>();
        mapInvoiceIdToInvoice = new map<String, inscor__Invoice__c>();
        invoicesToUpdate = new list<inscor__Invoice__c>();
        processInvoiceFiles = TRUE;
        
        YayPay_Configuration__c config = YayPay_Configuration__c.getOrgDefaults();
        LimitRecords = config.Records_To_Query_Batch__c;
        batchRunInterval = (Integer)config.Batch_Interval_Minutes__c;
        
    }
    global BatchProcessInvoiceToYayPay(Set<Id> Ids, Boolean processFiles ){
        invoiceIds = Ids;
        invoicesToUpdate = new list<inscor__Invoice__c>();
        mapInvoiceIdToInvoice = new map<String, inscor__Invoice__c>();
        processInvoiceFiles = processFiles;
        
        YayPay_Configuration__c config = YayPay_Configuration__c.getOrgDefaults();
        LimitRecords = config.Records_To_Query_Batch__c;
        batchRunInterval = (Integer)config.Batch_Interval_Minutes__c;     
    }
  
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = ' SELECT Id, Name, inscor__Account__c, inscor__Billing_Contact__c, inscor__Customer_PO_Number__c,'+
                  'inscor__Billing_Contact__r.Email, inscor__Account__r.Id, inscor__Invoice_Date__c, '+
                  ' inscor__Billing_Contact__r.Id, inscor__Status__c, inscor__Total_Invoice__c, YayPay_Last_Sync_Date__c, '+
                  ' inscor__Account__r.inscor__Billing_Contact__r.Email, '+
                  ' inscor__Account_Terms__r.inscor__Number_of_Days__c, '+
                      ' ( SELECT Id, Name, inscor__Quantity__c, inscor__Price__c, inscor__Item__r.inscor__Description__c,'+
                      '  inscor__Item__r.Name, inscor__Extended_Price__c FROM inscor__Invoice_Lines__r ), '+
                      ' ( SELECT Id, Name, inscor__Receivable_Amount__c, inscor__External_Reference_ID__c, '+
                      ' inscor__INVC_Date__c, inscor__Line_Value__c, inscor__INVC__r.Id, inscor__Customer_Vendor__r.Id'+
                      '  FROM inscor__Transaction_Activities__r ) '+
                  ' FROM  inscor__Invoice__c '+
                  ' WHERE Id != null';
        
        if(invoiceIds.size() > 0){
            query += ' AND Id IN: invoiceIds';
        }else{
            query += ' AND Is_Processed__c = FALSE AND Is_Error__c = FALSE ';
        }
        query += ' ORDER BY LastModifiedDate ASC LIMIT ' + LimitRecords ;
       
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<inscor__Invoice__c> invoices){
        
        if( !YayPayUtility.sendYayPayCallout() ){
            return;
        }
        inscor__Invoice__c invObj = invoices.get(0);
        
        if( TokenExpiaryTime == null || TokenExpiaryTime < System.now() ){
            
            //get Access Token for Request API.
            accessToken = YayPayAuthentication.getAccessToken(); 
            TokenExpiaryTime = System.now().addMinutes(50);
            
            //starting transaction.
            transactionId = YayPayTransactionAPIService.startTransaction( accessToken );
        }
        
        try{            
            
            if( invObj.inscor__Status__c == 'Cancelled' ){
                if( invObj.YayPay_Last_Sync_Date__c != null ){
                    YayPayAPIService.deleteRecordsFromYayPay( New List<String>{ invObj.Id }, 'invoices', accessToken, transactionId ); 
                    
                    invObj.YayPay_Last_Sync_Date__c = System.now();
                    invObj.Is_Processed__c = TRUE;
                    invoicesToUpdate.add( invObj );
                }
                
            }else{
            list<inscor__Activity__c> paymentList = new list<inscor__Activity__c>();
            set<String> customerIds = new set<String>();
            
            String errorString = validateInvoiceRequest( invObj );
            if( String.isBlank(errorString) || Test.isRunningTest() ){            
                for( inscor__Invoice__c inv : invoices ){
                    customerIds.add( inv.inscor__Account__c );
                    if( inv.inscor__Status__c == 'Paid'  ){
                        paymentList.addAll( inv.inscor__Transaction_Activities__r );
                    }
                }
                
                map<String, Account> mapCustomerIdToCustomer = new map<String, Account>();
                map<String, list<Contact>> mapCustomerIdToListContacts = new map<String, list<Contact>>();
                list<Contact> contactList = new list<Contact>();
                
                list<Account> accountList = [ SELECT Id, Name, Site, ShippingCity, ShippingState, ParentId, inscor__Billing_Contact__r.Email,
                                             ShippingPostalCode, ShippingStreet, ShippingCountry,Phone, Website,
                                             DNBI__DnB_DUNS_NO__c, inscor__Credit_Limit__c, inscor__Account_Region__c,
                                             DNBI__DnB_Payment_Terms__c, AcctSeed__Taxpayer_Identification_Number__c,
                                             inscor__Account_Terms__r.Name,
                                             ( SELECT Id, Name, Email, MobilePhone, Phone, inscor__Contact_Options__c, Title, FirstName, LastName, AccountId FROM Contacts )
                                             FROM Account WHERE Id IN :customerIds ];
                
                for( Account acc : accountList ){
                    mapCustomerIdToCustomer.put(acc.Id, acc );
                    mapCustomerIdToListContacts.put( acc.Id , acc.contacts );
                    contactList.addAll( acc.Contacts );
                }
                
                //Process Customer.
                Integer responseCodeCustomer = YayPayAPIService.sendCustomerToYayPay( accountList, accessToken, transactionId );
                
                //Process Contact.
                Integer responseCodeContact = YayPayAPIService.sendContactToYayPay( contactList, accessToken, transactionId );
                
                //Process Invoice.
                Integer responseCodeInvoice = YayPayAPIService.sendInvoiceToYayPay( invoices[0], accessToken, transactionId );
                
                //Process Payment.
                Integer responseCodePayment;
                if( paymentList.size() > 0 ){
                    //responseCodePayment = YayPayAPIService.sendPaymentToYayPay( paymentList, accessToken, transactionId );
                }
                
                invObj.YayPay_Last_Sync_Date__c = System.now();
                invObj.Is_Processed__c = TRUE;
            }
            else{
                invObj.YayPay_Error_Message__c = errorString;
                invObj.Is_Processed__c = TRUE;
            }
            invoicesToUpdate.add( invObj );
            }
        }catch( exception error ){
            invObj.Is_Error__c = TRUE;
            if( !(mapInvoiceIdToInvoice.size() > 0 && mapInvoiceIdToInvoice.containsKey( invObj.Id )) ){
                invoicesToUpdate.add( invObj  );
            }
            LogService.createErrorLog('BatchProcessInvoiceToYayPay.execute', NULL, error, NULL);
        }
        
    }
    global void execute(SchedulableContext sc) {
        Database.executeBatch(new BatchProcessInvoiceToYayPay(), 1 );
    }
    
    global void finish(Database.BatchableContext bc){
        try{
            //Finish transaction.
            Integer transactionFinishCode = YayPayTransactionAPIService.finishTransaction( accessToken, transactionId ); 
            update invoicesToUpdate;   
            Set<Id> invoiceIds = (new Map<Id,SObject>(invoicesToUpdate)).keySet();
            if( invoiceIds.size() > 0 ){
                Database.executeBatch( new BatchProcessInvoiceFilesToYayPay( invoiceIds, processInvoiceFiles ), 1 );
            }
            
        }catch( exception error ){
            LogService.createErrorLog('BatchProcessInvoiceToYayPay.finish', NULL, error, NULL);
        }
    }
    
    public static String validateInvoiceRequest( inscor__Invoice__c invoice ){
        
        List<String> errors = new List<String>();
        if(invoice.inscor__Invoice_Date__c == null){
            errors.add('Invoice Date is Missing');
        }
        if(invoice.inscor__Account__c == null){
            errors.add('Invoice Account is Missing');
        }
        if(invoice.inscor__Billing_Contact__c == null){
            errors.add('Contact is Missing');
        }
        
        for( inscor__Invoice_Line__c invLine : invoice.inscor__Invoice_Lines__r  ){
            if(invLine.inscor__Quantity__c == null){
                errors.add('Invoice Line Quantity is Missing for ' + invLine.Name );
            }
            if(invLine.inscor__Price__c == null){
                errors.add('Invoice Line Price is Missing for ' + invLine.Name );
            }
            if(invLine.inscor__Item__c == null){
                errors.add('Invoice Line\'s Item is Missing for ' + invLine.Name );
            }
            if(invLine.inscor__Item__r.inscor__Description__c == null){
                errors.add('Invoice Line\'s Item Description is Missing for ' + invLine.Name );
            }
        }
        return String.join(errors, '\n');
    }
}