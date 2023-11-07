@isTest
public class ConvertLeadToCustomerCtrlTest {
    
    public static final Integer COUNT_LIMIT = 10;
    
    @TestSetup
    private static void setup(){
        //Create a Account for Customer
        Account accRec = new Account();
        accRec.Name = 'TEST';
        accRec.inscor__Account_Number__c = '2';  
        insert accRec;
        //Lead Insertion
        List<Lead> leadListToInsert = new List<Lead>();
        for(Integer i = 0; i < COUNT_LIMIT; i++){
            Lead leadRec = new Lead();
            leadRec.FirstName = 'TEST ' + i;
            leadRec.LastName = 'Name';
            leadRec.Company = 'TEST ' + i + ' Company';
            leadRec.Customer_Conversion_Probablity__c = NULL;
            if(Math.Mod(i,2) == 0){
                leadRec.Customer__c = accRec.Id;
            }
            if(Math.Mod(i,3) == 0){
                leadRec.Email = 'test@test.com';
            }
            leadListToInsert.add(leadRec); 
        }
        if(leadListToInsert.size() > 0){
            insert leadListToInsert;
        }
    }
    
    @isTest
    private static void convertLeadtoCustomerTest(){
        Test.startTest();
        List<Lead> leadList = new List<Lead>([Select Id,Status,Customer__c,Company,ownerId from Lead]);
        system.assertEquals(leadList.size(),COUNT_LIMIT);
        for(Lead leadRec : leadList){
            if(leadRec.Customer__c != NULL){
                system.assertEquals(ConvertLeadToCustomerCtrl.convertLeadtoCustomer(leadRec.Id), 'Lead Status is Changed and Customer is already Created');
            } else {
                String returnString = ConvertLeadToCustomerCtrl.convertLeadtoCustomer(leadRec.Id);
                Boolean flag = (returnString == 'Account with same email domain is already exist.' || returnString == 'Lead Status is Changed and Customer is Created');
                system.assert(flag);
                //system.assertEquals(ConvertLeadToCustomerCtrl.convertLeadtoCustomer(leadRec.Id), 'Lead Status is Changed and Customer is Created');
            }
        }
        Test.stopTest();
    }       
}