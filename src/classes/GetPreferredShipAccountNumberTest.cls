@isTest
public class GetPreferredShipAccountNumberTest {
	@isTest
    public static void GetPreferredShipAccountNumberTestCase(){
        Id p = [select id from profile where name='Customer Community Plus Login User'].id;
        Account ac = new Account(name ='Grazitti') ;
        insert ac; 
       
        Contact con = new Contact(LastName ='testCon',BillNPay__LP_Payment_Request_Method__c ='Email',Email='mlum@cloudstreet.com',AccountId = ac.Id);
        insert con;  
                  
        /*User user = new User(alias = 'test123', email='test123@noemail.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = p, country='United States',IsActive =true,
                ContactId = con.Id,
                timezonesidkey='America/Los_Angeles', username='tester@noemail.com');
       
        insert user;*/
        List<User> user = [SELECT Id, Name,ContactID FROM User WHERE ProfileId = :p AND isActive = true];
        system.runAs(user[0]) {
            String result = GetPreferredShipAccountNumber.getPreferredShipAccountNumberDetails();
        }
        
    }
    
    /*@isTest
    public static void GetPreferredShipAccountNumberTestCase2(){
        String result = GetPreferredShipAccountNumber.getPreferredShipAccountNumberDetails('0056s000000Ww1DAAS');
    }*/
}