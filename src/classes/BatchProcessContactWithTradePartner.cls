global class BatchProcessContactWithTradePartner implements Database.Batchable<sObject>,Database.AllowsCallouts,Database.Stateful {

    
    Public Set<Id> contactIds;
    global BatchProcessContactWithTradePartner(){
        contactIds = new Set<Id>();
    }
    global BatchProcessContactWithTradePartner(Set<Id> Ids){
        contactIds = Ids;
    }
  
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id, Name, LastModifiedBy.Name, '+
            			'Phone, Email, Title, '+
            			'Account.Name, Account.ShippingStreet, '+
            			'Account.ShippingCity, Account.ShippingCountry, '+
            			'Account.ShippingState, Account.ShippingPostalCode, '+
            			'Account.Phone, Account.inscor__Active__c '+
            			'FROM  Contact '+
            			'WHERE AccountId != null';
        
        if(contactIds.size() > 0){
            query += ' AND Id IN: contactIds';
        }
        //system.assert(false,query);
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Contact> contacts){
        ContactWithTradePartnerAPIService.sendContactToCompliance(contacts);
    }
    
    global void finish(Database.BatchableContext bc){
        //Database.executeBatch(new BatchUpdateShipmentStatus(contactIds), 20);
    }
}