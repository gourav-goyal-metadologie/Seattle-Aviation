@isTest
public class ApnContactTest {
   @isTest 
    static void apnContactTriggerTest() {
        try {
            System.debug('contact');
            Account account = new Account(Name='Test Account');
            insert account;
            System.debug(account);
            
            Contact contact = new Contact(Phone='test', AccountId=account.Id, LastName='last name', Email='abc@yopmail.com');
            insert contact;
            System.debug(contact);
            
            Test.setMock(HttpCalloutMock.class, new ApnMockHttpResponseGenerator());
            
            Test.startTest();
			Database.DeleteResult result = Database.delete(account, false);
            Database.DeleteResult result2 = Database.delete(contact, false);
            Test.stopTest();
        }
        catch (Exception  e){
    	    System.debug('The following exception has occurred in Webhook.jsonContent' + e);
      	}
    }
}