global without sharing class UpdateContactEmailsToInvalidBatch implements Database.Batchable<SObject> {
    global String query = 'SELECT Id, Email FROM Contact WHERE NOT(Email LIKE \'%invalid\')';

    global UpdateContactEmailsToInvalidBatch(String query) {
        if(query == null || String.isBlank(query)) {
            this.query = query;
        }
    }

    global Database.QueryLocator start(Database.BatchableContext bc){
        Trigger_Configuration__c configSetting = Trigger_Configuration__c.getInstance();
        configSetting.Contact_Trigger_Disable__c = true;
        upsert configSetting;

        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Contact> scope){
        for(Contact contact : scope) {
            contact.Email = contact.Email + '.invalid';
        }
        update scope;
    }

    global void finish(Database.BatchableContext BC){
        Trigger_Configuration__c configSetting = Trigger_Configuration__c.getInstance();
        configSetting.Contact_Trigger_Disable__c = false;
        upsert configSetting;
    }
}