public without sharing class ProductUtility {
    public static void checkForExistingPartNumber(Map<Id, Product2> newProductsMap) {
        // Set for Unique_Part_Number__c field values from new records
        Set<String> uniquePartNumbersFromNewRecords = new Set<String>();
        for(Product2 product : newProductsMap.values()) {
            uniquePartNumbersFromNewRecords.add(product.Unique_Part_Number__c);
        }

        // Check for existing records matching with new records Unique_Part_Number__c values
        List<Product2> existingMatchingProducts = [SELECT Id, Unique_Part_Number__c
                                                        FROM Product2
                                                        WHERE Unique_Part_Number__c IN: uniquePartNumbersFromNewRecords
                                                    ];

        // Map for Unique_Part_Number__c to matching Product Ids set for existing + new records
        Map<String, Set<Id>> uidPartNumberToMatchingProductsMap = new Map<String, Set<Id>>();
        for(Product2 product : existingMatchingProducts) {
            Set<Id> productIds = (uidPartNumberToMatchingProductsMap.containsKey(product.Unique_Part_Number__c))
                    ? uidPartNumberToMatchingProductsMap.get(product.Unique_Part_Number__c)
                    : new Set<Id>();
            productIds.add(product.Id);
            uidPartNumberToMatchingProductsMap.put(product.Unique_Part_Number__c, productIds);
        }

        // Check for the duplicate Unique_Part_Number__c from existing records map
        // Check for current record Id as well, since the query contains new records as well (after insert operation)
        for(Product2 product : newProductsMap.values()) {
            if(uidPartNumberToMatchingProductsMap.containsKey(product.Unique_Part_Number__c)) {
                Set<Id> existingProductIds = uidPartNumberToMatchingProductsMap.get(product.Unique_Part_Number__c);

                if(existingProductIds.contains(product.Id)) {
                    existingProductIds.remove(product.Id);
                }

                if(!existingProductIds.isEmpty()) {
                    product.addError('Duplicate Part Number found in: ' + existingProductIds);
                }

            }
        }
    }

    public static List<String> getProductQueriesForMerge(String uniquePartNumber) {
        Map<Integer, Map<String, String>> childObjectNameToQStringMap = Utility.getChildObjectQueryMap('Product2');

        List<String> queries = new List<String>();
        for(Integer index : childObjectNameToQStringMap.keySet()) {
            Map<String, String> relNameToQueryMap = childObjectNameToQStringMap.get(index);
            if(relNameToQueryMap.isEmpty()) continue;

            String query = 'SELECT Id, ' + Utility.createSingleQueryFromRelationshipNames(relNameToQueryMap);
            query += ' FROM Product2 WHERE Unique_Part_Number__c = \'' + uniquePartNumber + '\'';
            queries.add(query);
        }

        return queries;
    }

    public static Product2 getMasterProductForMerge(String uniquePartNumber) {
        if(uniquePartNumber == null || String.isBlank(uniquePartNumber)) return null;

        List<Product2> products = [SELECT Id, Name
                                        FROM Product2
                                        WHERE Unique_Part_Number__c =: uniquePartNumber
                                        ORDER BY CreatedDate ASC
                                    ];
        Product2 masterProduct = products[0];
        for(Product2 product : products) {

        }

        return masterProduct;
    }

    public static Map<String, List<SObject>> mergeProductsIntoMasterProduct(Product2 masterProduct,
                                                        List<Product2> productsToMerge,
                                                        Map<String, String> relationshipNameToRelationFieldAPINameMap
    ) {
        Map<String, List<SObject>> mapForRelatedChildRecordsToUpdate = new Map<String, List<SObject>>();

        for(Product2 product : productsToMerge) {
            for(String relationshipName : relationshipNameToRelationFieldAPINameMap.keySet()) {
                //SObject row was retrieved via SOQL without querying the requested field: Product2.ProductVariantAttributes, so Try-Catch
                try {
                    if (product.getSObjects(relationshipName) != null && !product.getSObjects(relationshipName).isEmpty()) {
                        for (SObject childRecord : product.getSObjects(relationshipName)) {
                            childRecord.put(relationshipNameToRelationFieldAPINameMap.get(relationshipName), masterProduct.Id);
                        }

                        List<SObject> records = (mapForRelatedChildRecordsToUpdate.containsKey(relationshipName)) ? mapForRelatedChildRecordsToUpdate.get(relationshipName) : new List<SObject>();
                        records.addAll(product.getSObjects(relationshipName));
                        mapForRelatedChildRecordsToUpdate.put(relationshipName, records);
                    }
                } catch(Exception e){}
            }
        }

        System.debug('mapForRelatedChildRecordsToUpdate:\n' + mapForRelatedChildRecordsToUpdate);
        return mapForRelatedChildRecordsToUpdate;
    }
}