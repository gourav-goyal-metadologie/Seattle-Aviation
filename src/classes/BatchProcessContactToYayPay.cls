global class BatchProcessContactToYayPay implements Database.Batchable<sObject>,Database.AllowsCallouts,Database.Stateful {
    
    Public Set<Id> contactIds;
    Public DateTime TokenGenerateTime;
    Public DateTime TokenExpiaryTime;
    Public String accessToken;
    Public Integer tokenGenerateCount =0 ;
    Public String transactionId;
    Public List<Contact> contactsToUpdate;
    global BatchProcessContactToYayPay(){
        contactIds = new Set<Id>();
        contactsToUpdate = new list<Contact>();
    }
    global BatchProcessContactToYayPay(Set<Id> Ids ){
        contactIds = Ids;
        contactsToUpdate = new list<Contact>();
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = ' SELECT Id, Name, Email, MobilePhone, Phone, Title, IsDeleted, ' +
            			' Account.YayPay_Last_Sync_Date__c, inscor__Contact_Options__c, '+
            			' FirstName, LastName, AccountId FROM Contact '+
                        ' WHERE Id != null';
        
        if(contactIds.size() > 0){
            query += ' AND Id IN: contactIds';
        }else{
            query += ' AND Is_Processed__c = FALSE ';
        }
        query +=' AND AccountId != null LIMIT 10 ALL ROWS';
        
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Contact> contactList){
        
        if( !YayPayUtility.sendYayPayCallout() ){
            return;
        }
        List<Contact> contactsToSync = new List<Contact>();
        try{            
            if( TokenExpiaryTime == null || TokenExpiaryTime < System.now() ){
                
                //get Access Token for Request API.
                accessToken = YayPayAuthentication.getAccessToken(); 
                TokenExpiaryTime = System.now().addMinutes(50);
                
                //starting transaction.
                transactionId = YayPayTransactionAPIService.startTransaction( accessToken );
            }
            
            List<Contact> deletedContacts = new List<Contact>();
            List<String> contactIds = new List<String>();
            List<String> accountIds = new List<String>();
            for( Contact con : contactList ){
                if( con.IsDeleted ){
                    deletedContacts.add( con );
                    ContactIds.add( con.Id );
                }else{
                    contactsToSync.add( con );
                    if( con.Account.YayPay_Last_Sync_Date__c == null ){
                        accountIds.add( con.AccountId );
                    }
                }
            }
            if( deletedContacts.size() > 0 ){
                YayPayAPIService.deleteRecordsFromYayPay( ContactIds, 'contacts', accessToken, transactionId );
            }
            
            //Process Customer.
            if( accountIds.size() > 0 ){
                
                List<Account> accounts = [  SELECT Id, Name, Site, ShippingCity, ShippingState, ParentId,
                                          ShippingPostalCode, ShippingStreet, ShippingCountry,Phone,
                                          Website, inscor__Account_Terms__c, inscor__Account_Terms__r.Name,
                                          AcctSeed__Taxpayer_Identification_Number__c, DNBI__DnB_DUNS_NO__c,
                                          inscor__Billing_Contact__r.Email, inscor__Credit_Limit__c, 
                                          DNBI__DnB_Payment_Terms__c, inscor__Account_Region__c
                                          FROM Account  WHERE Id IN : accountIds ];
                Integer responseCodeCustomer = YayPayAPIService.sendCustomerToYayPay( accounts, accessToken, transactionId );
            }
            
            //Process Contact.
            Integer responseCodeContact = YayPayAPIService.sendContactToYayPay( contactsToSync, accessToken, transactionId );
            //System.assert( false, responseCodeContact );
             
             for( Contact con : contactsToSync ){
                con.Is_Processed__c = TRUE;
                con.YayPay_Last_Sync_Date__c = System.now();
                if( ! contactsToUpdate.contains( con ) ){
                    contactsToUpdate.add( con  );
                }
            }
            
        }catch( exception error ){
            for( Contact con : contactsToSync ){
                con.Is_Processed__c = TRUE;
                if( ! contactsToUpdate.contains( con ) ){
                    contactsToUpdate.add( con  );
                }
            }
            
            LogService.createErrorLog('BatchProcessContactToYayPay.execute', NULL, error, NULL);
            //System.assert( false, error );
        }
    }
    
    global void finish(Database.BatchableContext bc){
        try{
            //Finish transaction.
            Integer transactionFinishCode = YayPayTransactionAPIService.finishTransaction( accessToken, transactionId );
            if( contactsToUpdate.size() > 0 ){
                update contactsToUpdate;
            }
            
        }catch( exception error ){
            LogService.createErrorLog('BatchProcessContactToYayPay.finish', NULL, error, NULL);
        }
    }
    
}