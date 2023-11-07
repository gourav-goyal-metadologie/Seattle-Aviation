@isTest
public class ApnProductTest {
 	@isTest 
    static void apnProductTriggerTest() {
        try {
            Product2 product = new Product2(Name='Test Product', inscor__Keyword__c='Test Product');
            insert product;
            
            Test.setMock(HttpCalloutMock.class, new ApnMockHttpResponseGenerator());
            // Perform test
            Test.startTest();
            Database.DeleteResult result = Database.delete(product, false);
            Test.stopTest();
        }
        catch (Exception  e){
    	    System.debug('The following exception has occurred in Webhook.jsonContent' + e);
      	}
    }
}