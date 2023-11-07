@IsTest
private class PartMasterIdentifyDuplicateBatchTest {
    @TestSetup
    static void createTestData() {List<Product2> products = new List<Product2>();
        for(Integer i = 1; i <= 100; i++) {
            products.add(new Product2(
                    Name = 'Laptop X200' + i,
                    Family = 'Hardware',
                    inscor__Keyword__c = 'test'
            ));
        }

        Test.setMock(HttpCalloutMock.class, new ComplianceMockResponseGenerator());
        insert products;
    }

    @IsTest
    static void testBatchClass() {
        ProductTriggerHelper.skipDuplicatePartNumberCheck = true;

        List<Product2> products = new List<Product2>();
        for(Integer i = 50; i <= 100; i++) {
            products.add(new Product2(
                    Name = 'Laptop X200 - ' + i,
                    Family = 'Hardware',
                    inscor__Keyword__c = 'test'
            ));
        }
        Test.setMock(HttpCalloutMock.class, new ComplianceMockResponseGenerator());
        insert products;

        Map<Id, Product2> product2Map = new Map<Id, Product2>([SELECT Id FROM Product2 LIMIT 2000]);

        Test.startTest();
        Database.executeBatch(new PartMasterIdentifyDuplicateBatch(product2Map.keySet()));
        Test.stopTest();
    }

    @IsTest
    static void testCheckDuplicates() {
        List<Product2> products = new List<Product2>();
        for(Integer i = 50; i <= 100; i++) {
            products.add(new Product2(
                    Name = 'Laptop X200 - ' + i,
                    Family = 'Hardware',
                    inscor__Keyword__c = 'test'
            ));
        }
        Test.setMock(HttpCalloutMock.class, new ComplianceMockResponseGenerator());

        Test.startTest();
        Database.insert(products, false);
        Test.stopTest();
    }
}