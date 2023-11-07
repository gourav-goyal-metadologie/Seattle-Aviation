global without sharing class PartMasterRecordsUpdateBatch implements Database.Batchable<SObject> {
    private String query;
    private Set<Id> productIds;
    private Map<String, Object> fieldValuesMap;
    private Set<String> uniquePartNumbersToProcess;

    global PartMasterRecordsUpdateBatch(Set<Id> productIds, Map<String, Object> fieldValuesMap) {
        init(productIds, fieldValuesMap, new Set<String>());
    }

    global PartMasterRecordsUpdateBatch(Set<Id> productIds, Map<String, Object> fieldValuesMap, Set<String> uniquePartNumbersToProcess) {
        init(productIds, fieldValuesMap, uniquePartNumbersToProcess);
    }

    private void init(Set<Id> productIds, Map<String, Object> fieldValuesMap, Set<String> uniquePartNumbersToProcess) {
        this.productIds = new Set<Id>();
        if(productIds != null) {
            this.productIds.addAll(productIds);
        }
        this.fieldValuesMap = fieldValuesMap;
        this.uniquePartNumbersToProcess = uniquePartNumbersToProcess;

        query = 'SELECT Id FROM Product2';
        if(productIds != null && !productIds.isEmpty()) {
            query += ' WHERE Id IN: productIds';
        }
    }

    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<SObject> products){
        if(fieldValuesMap == null || fieldValuesMap.isEmpty()) return;

        for(SObject product : products) {
            for(String fieldName : fieldValuesMap.keySet()) {
                product.put(fieldName, fieldValuesMap.get(fieldName));
            }
        }

        if(!products.isEmpty()) {
            update products;
        }
    }

    global void finish(Database.BatchableContext BC){
        if(uniquePartNumbersToProcess != null && !uniquePartNumbersToProcess.isEmpty()) {
            Database.executeBatch(new PartMasterMergeDuplicateBatch(uniquePartNumbersToProcess), 1);
        }
    }
}