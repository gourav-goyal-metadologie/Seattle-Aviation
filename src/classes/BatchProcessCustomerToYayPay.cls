global class BatchProcessCustomerToYayPay implements Database.Batchable<sObject>,Database.AllowsCallouts,Database.Stateful {
    
    Public Set<Id> customerIds;
    Public DateTime TokenGenerateTime;
    Public DateTime TokenExpiaryTime;
    Public String accessToken;
    Public Integer tokenGenerateCount =0 ;
    Public String transactionId;
    Public List<Account> accountsToUpdate;
    global BatchProcessCustomerToYayPay(){
        customerIds = new Set<Id>();
        accountsToUpdate = new list<Account>();
    }
    global BatchProcessCustomerToYayPay(Set<Id> Ids ){
        customerIds = Ids;
        accountsToUpdate = new list<Account>();
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = ' SELECT Id, Name, Site, ShippingCity, ShippingState, ParentId, '+
            ' ShippingPostalCode, ShippingStreet, ShippingCountry,Phone, Website, inscor__Account_Terms__c, inscor__Account_Terms__r.Name,'+
            ' AcctSeed__Taxpayer_Identification_Number__c, DNBI__DnB_DUNS_NO__c, inscor__Billing_Contact__r.Email, ' +
            ' inscor__Credit_Limit__c, DNBI__DnB_Payment_Terms__c, inscor__Account_Region__c, '+
            ' ( SELECT Id, Name, Email, MobilePhone, Phone, Title, FirstName, LastName, AccountId, inscor__Contact_Options__c FROM Contacts ) '+
            ' FROM Account '+
            ' WHERE Id != null';
        
        if(customerIds.size() > 0){
            query += ' AND Id IN: customerIds';
        }else{
            query += ' AND Is_Processed__c = FALSE ';
        }
        query +=' LIMIT 15';
        
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Account> accounts){
        
    
        try{            
            if( TokenExpiaryTime == null || TokenExpiaryTime < System.now() ){
                
                //get Access Token for Request API.
                accessToken = YayPayAuthentication.getAccessToken(); 
                TokenExpiaryTime = System.now().addMinutes(50);
                
                //starting transaction.
                transactionId = YayPayTransactionAPIService.startTransaction( accessToken );
            }
            
            list<Contact> contactList = new list<Contact>();
            
            for( Account acc : accounts ){
                if( acc.Contacts.size()>0 ){
                    contactList.addAll( acc.Contacts );
                }
            }
        
            //Process Customer.
            Integer responseCodeCustomer = YayPayAPIService.sendCustomerToYayPay( accounts, accessToken, transactionId );
            //System.assert( false, responseCodeCustomer );
            
            //Process Contact.
            Integer responseCodeContact = YayPayAPIService.sendContactToYayPay( contactList, accessToken, transactionId );
            //System.assert( false, responseCodeContact );
            
            for( Account acc : accounts ){
                acc.YayPay_Last_Sync_Date__c = System.now();
                acc.Is_Processed__c = TRUE;
                accountsToUpdate.add( acc );
            }
            
            //update inv;
            
        }catch( exception error ){
            for( Account acc : accounts ){
                acc.Is_Processed__c = TRUE;
                if( ! accountsToUpdate.contains( acc ) ){
                    accountsToUpdate.add( acc  );
                }
            }
            
            LogService.createErrorLog('BatchProcessInvoiceToYayPay.execute', NULL, error, NULL);
            //System.assert( false, error );
        }
    }
    
    global void finish(Database.BatchableContext bc){
        try{
            //Finish transaction.
            Integer transactionFinishCode = YayPayTransactionAPIService.finishTransaction( accessToken, transactionId ); 
            if( accountsToUpdate.size() > 0 ){
                update accountsToUpdate;
            }
            
        }catch( exception error ){
            LogService.createErrorLog('BatchProcessInvoiceToYayPay.finish', NULL, error, NULL);
        }
    }
    
}