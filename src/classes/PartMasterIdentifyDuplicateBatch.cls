global without sharing class PartMasterIdentifyDuplicateBatch implements Database.Batchable<SObject>, Database.Stateful {
    global String query;
    global Set<Id> productIds;
    global Map<String, Set<Id>> uniquePartNumberToProductIdsMap;

    global PartMasterIdentifyDuplicateBatch(Set<Id> productIds) {
        uniquePartNumberToProductIdsMap = new Map<String, Set<Id>>();
        this.productIds = new Set<Id>();
        if(productIds != null) {
            this.productIds.addAll(productIds);
        }

        query = 'SELECT Id, Unique_Part_Number__c, Is_Duplicate__c FROM Product2 WHERE Unique_Part_Number__c != null';
        if(productIds != null && !productIds.isEmpty()) {
            query += ' AND Id IN: productIds';
        }
    }

    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Product2> products){
        List<Product2> productsToUpdate = new List<Product2>();

        for(Product2 product : products) {
            Set<Id> productIds = (uniquePartNumberToProductIdsMap.containsKey(product.Unique_Part_Number__c))
                                    ? uniquePartNumberToProductIdsMap.get(product.Unique_Part_Number__c)
                                    : new Set<Id>();
            productIds.add(product.Id);
            uniquePartNumberToProductIdsMap.put(product.Unique_Part_Number__c, productIds);

            if(product.Is_Duplicate__c) {
                product.Is_Duplicate__c = false;
                productsToUpdate.add(product);
            }
        }

        if(!productsToUpdate.isEmpty()) {
            update productsToUpdate;
        }
    }

    global void finish(Database.BatchableContext BC){
        Map<String, Set<Id>> duplicateUniquePartNumberToProductIdsMap = new Map<String, Set<Id>>();
        System.debug('uniquePartNumberToProductIdsMap\n' + uniquePartNumberToProductIdsMap);
        for(String uPN : uniquePartNumberToProductIdsMap.keySet()) {
            if(uniquePartNumberToProductIdsMap.get(uPN).size() > 1) {
                duplicateUniquePartNumberToProductIdsMap.put(uPN, uniquePartNumberToProductIdsMap.get(uPN));
            }
        }

        Set<Id> productIdsToUpdate = new Set<Id>();
        for(String uPN : duplicateUniquePartNumberToProductIdsMap.keySet()) {
            productIdsToUpdate.addAll(duplicateUniquePartNumberToProductIdsMap.get(uPN));
        }

        Map<String, Object> fieldValuesMap = new Map<String, Object>{
                'Is_Duplicate__c'   =>  true
        };

        if(!productIdsToUpdate.isEmpty()) {
            Database.executeBatch(new PartMasterRecordsUpdateBatch(productIdsToUpdate, fieldValuesMap, duplicateUniquePartNumberToProductIdsMap.keySet()), 500);
        }
    }
}