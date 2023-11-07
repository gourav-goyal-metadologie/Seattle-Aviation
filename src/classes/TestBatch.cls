/**
 * @description : This batch created for testing purpose 
 */
global class TestBatch implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        Set<Id> orderIds = new Set<Id>{'a0e8F0000005VRrQAM', 'a0e5Y00000b3gPIQAY'};
        System.debug('orderIds');
        String query = 'select id, inscor__Billing_City__c from inscor__Sales_Order__c WHERE Id IN :orderIds';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<inscor__Sales_Order__c> scope) {
        try {
            for (inscor__Sales_Order__c salesOrder : scope) {
                salesOrder.inscor__Billing_City__c = 'test city';
            }
            update scope;
        } catch(Exception e) {
            System.debug('Mera error: '+e.getMessage());
        }
        
    }   
    
    global void finish(Database.BatchableContext BC) {
        // execute any post-processing operations
    }
}