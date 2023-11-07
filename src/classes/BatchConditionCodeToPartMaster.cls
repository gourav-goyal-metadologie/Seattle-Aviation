global class BatchConditionCodeToPartMaster implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id, NE__c, OH__c, ' +
            		   'RD__c, SV__c FROM Product2';
        return Database.getQueryLocator(query);
    }
        
    global void execute(Database.BatchableContext BC, List<Product2> products) {
        Map<Id, Product2> productMap = new Map<Id, Product2>();
        for (Product2 product : products) {
            productMap.put(product.Id, product);
        }
        ProductTriggerHelper.createConditionCodesOnInsert(productMap);
    }

    global void finish(Database.BatchableContext BC) {
        // execute any post-processing operations
    }
}