@isTest
public class ApnAccountTest {
	@isTest 
    static void apnProductTriggerTest() {
        try {
            Account account = new Account(Name='Test Product');
            insert account;
            
            Test.setMock(HttpCalloutMock.class, new ApnMockHttpResponseGenerator());
            // Perform test
            Test.startTest();
            Database.DeleteResult result = Database.delete(account, false);
            Test.stopTest();
        }
        catch (Exception  e){
    	    System.debug('The following exception has occurred in Webhook.jsonContent' + e);
      	}
    }
}