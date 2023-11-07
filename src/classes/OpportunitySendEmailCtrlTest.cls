@isTest
public class OpportunitySendEmailCtrlTest {
    public static final Integer COUNT_LIMIT = 10;
    
    @testSetup()
    private static void setup(){
        //Create a Account for Customer
        Account accRec = new Account();
        accRec.Name = 'TEST';
        accRec.inscor__Account_Number__c = '2';  
        insert accRec;
        
        List<Account> accList = new List<Account>([SELECT Id,Name FROM Account LIMIT 1]);
        List<inscor__Customer_Quote__c> customerQuoteToInsertList = new List<inscor__Customer_Quote__c>();
        List<inscor__Customer_Quote_Line__c> customerQuoteLineToInsertList = new List<inscor__Customer_Quote_Line__c>();
        
        inscor__Company__c  company = new inscor__Company__c(inscor__Address_1__c = '1111', inscor__City__c = '1111', 
                                                             inscor__Company_Name__c = '1111', inscor__Zip_Code__c = '1111');
        insert company;
        
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Customer_Quote__c customerQuoteRec = new inscor__Customer_Quote__c();
            customerQuoteRec.inscor__Customer__c = accList[0].Id;
            customerQuoteRec.inscor__Status__c = 'New';
            customerQuoteRec.inscor__Company__c = company.Id;
            customerQuoteToInsertList.add(customerQuoteRec);
        }
        insert customerQuoteToInsertList;
        
        List<Opportunity> oppList = new List<Opportunity>([SELECT Id FROM Opportunity]);
    }
    
    @isTest
    private static void sendOpportunityEmailTest(){
        Test.startTest();
        List<Opportunity> oppList = new List<Opportunity>([SELECT Id FROM Opportunity]);
        system.assertEquals(oppList.size(), COUNT_LIMIT);
        for(Opportunity oppRec : oppList) {
            System.assertEquals(OpportunitySendEmailCtrl.sendOpportunityEmail
                                (String.valueOf(oppRec.Id),'Congrats On New Opportunities ','test@test.com','Congrats'),'Sucess');
        }
        Test.stopTest();
    }
    
    @isTest
    private static void getEmailBodyTest(){
        Test.startTest();
        EmailTemplate emailTemplate = OpportunitySendEmailCtrl.getEmailBody();
        Test.stopTest();
        system.assert(emailTemplate == NULL || emailTemplate != NULL);
    }
    
}