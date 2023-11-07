@IsTest
public class BatchConditionCodeToPartMasterTest {
    @TestSetup
    static void setupTestData(){
        List<Product2> products = new List<Product2>();
        for (Integer index = 0; index < 5; index++) {
            Product2 product = new Product2(Name = 'Laptop X200 ' + index, 
                                        Family = 'Hardware', 
                                        inscor__Keyword__c ='test ' + index);
            products.add(product);
        }
        insert products;
    }


    @IsTest
    static void testBatch(){
        
        Test.startTest();
        Database.executeBatch(new BatchConditionCodeToPartMaster());
        Test.stopTest();
        
    }
}