global without sharing class PartMasterMergeDuplicateBatch implements Database.Batchable<AggregateResult>{
    // Batch is required to be run with Batch size = 1
    // Reason being, Products merge will initiate a lot of child data merge

    /*
    // To Run the class:
    Set<String> uPNSet = new Set<String>{'0107KLM1', '016E158900'};
    Database.executeBatch(new PartMasterMergeDuplicateBatch(uPNSet));

    Issues with objects:
    1. Product Category Product: DUPLICATE_VALUE, duplicate value found: CatalogId
    */

    private String query;
    private Set<String> uniquePartNumbersToProcess;

    global PartMasterMergeDuplicateBatch(Set<String> uniquePartNumbersToProcess) {
        this.uniquePartNumbersToProcess = new Set<String>();
        if(uniquePartNumbersToProcess != null) {
            this.uniquePartNumbersToProcess.addAll(uniquePartNumbersToProcess);
        }

        query = 'SELECT Unique_Part_Number__c, Count(Id) FROM Product2';
        if(this.uniquePartNumbersToProcess != null && !this.uniquePartNumbersToProcess.isEmpty()) {
            query += ' WHERE Unique_Part_Number__c IN: uniquePartNumbersToProcess';
        }
        query += ' GROUP BY Unique_Part_Number__c';
    }

    global Iterable<AggregateResult> start(Database.BatchableContext BC){
        return new PartMasterAggregateResultIterable(query, uniquePartNumbersToProcess);
    }

    global void execute(Database.BatchableContext BC, List<AggregateResult> productAggregateResults){
        System.debug('productAggregateResults:\n' + productAggregateResults);

        AggregateResult productAgr = productAggregateResults[0];
        if((Integer)productAgr.get('expr0') <= 1) return;

        String uniquePartNumber = (String)productAgr.get('Unique_Part_Number__c');
        List<String> productQueries = ProductUtility.getProductQueriesForMerge(uniquePartNumber);
        Product2 masterProduct = ProductUtility.getMasterProductForMerge(uniquePartNumber);
        if(masterProduct == null) return;

        // Following is the code to update the SObject records after merging into a SObject list for 10 type of objects at a time
        // This is failing since same record is appearing for multiple time in the list to update since multiple lookup product fields on an object
        /*
        Map<String, List<SObject>> relatedRecordsToUpdate = new Map<String, List<SObject>>();
        for(String productQuery : productQueries) {
            productQuery += ' AND Id != \'' + masterProduct.Id + '\'';
            System.debug('productQuery:\n' + productQuery);
            List<Product2> productsToMerge = (List<Product2>)Database.query(productQuery);

            Map<String, List<SObject>> relatedRecordsToUpdateForSingleQuery = ProductUtility.mergeProductsIntoMasterProduct(masterProduct,
                                                                                                                            productsToMerge,
                                                                                                                            Utility.relationshipNameToFieldNameMap
                                                                                                                    );
            Utility.mergeSObjectMaps(relatedRecordsToUpdate, relatedRecordsToUpdateForSingleQuery);
        }

        // NOW Need to update the related records here
        Integer objectTypesCount = 0;
        List<SObject> recordsToUpdate = new List<SObject>();
        for(String relationshipName : relatedRecordsToUpdate.keySet()) {
            objectTypesCount++;
            recordsToUpdate.addAll(relatedRecordsToUpdate.get(relationshipName));

            if(objectTypesCount == 10) {
                update recordsToUpdate;
                objectTypesCount = 0;
                recordsToUpdate.clear();
            }
        }

        if(!recordsToUpdate.isEmpty()) {
            update recordsToUpdate;
        }
        */

        // This is the code to update the list in loop without considering the DML limit.
        // Observation is, this will not fail
        Map<String, List<SObject>> relatedRecordsToUpdate = new Map<String, List<SObject>>();
        for(String productQuery : productQueries) {
            productQuery += ' AND Id != \'' + masterProduct.Id + '\'';
            System.debug('productQuery:\n' + productQuery);
            List<Product2> productsToMerge = (List<Product2>)Database.query(productQuery);

            Map<String, List<SObject>> relatedRecordsToUpdateForSingleQuery = ProductUtility.mergeProductsIntoMasterProduct(masterProduct,
                                                                                                                            productsToMerge,
                                                                                                                            Utility.relationshipNameToFieldNameMap
                                                                                                                    );

            // NOW Need to update the related records here
            Integer objectTypesCount = 0;
            List<SObject> recordsToUpdate = new List<SObject>();
            for(String relationshipName : relatedRecordsToUpdateForSingleQuery.keySet()) {
                objectTypesCount++;
                recordsToUpdate.addAll(relatedRecordsToUpdateForSingleQuery.get(relationshipName));

                if(objectTypesCount == 10) {
                    update recordsToUpdate;
                    objectTypesCount = 0;
                    recordsToUpdate.clear();
                }
            }

            if(!recordsToUpdate.isEmpty()) {
                update recordsToUpdate;
            }
        }
    }

    global void finish(Database.BatchableContext BC){

    }
}