@isTest
private class PartNumberControllerTest {
    public static final Integer COUNT_LIMIT = 10;
    
    @testSetup()
    private static void setup(){
        Account accRec = new Account();
        accRec.Name = 'TEST';
        accRec.inscor__Account_Number__c = '2';  
        insert accRec;
        List<Account> accList = new List<Account>([SELECT Id,Name FROM Account LIMIT 1]);
        List<inscor__Customer_Quote__c> customerQuoteToInsertList = new List<inscor__Customer_Quote__c>();
        List<inscor__Customer_Quote_Line__c> customerQuoteLineToInsertList = new List<inscor__Customer_Quote_Line__c>();
        
        inscor__Company__c companyInstance = new inscor__Company__c();
        companyInstance.inscor__Company_Name__c = 'inscor Company' ;
        companyInstance.inscor__Address_1__c = 'address';
        companyInstance.inscor__City__c = 'xyz';
        companyInstance.inscor__Zip_Code__c = '21321';
        insert companyInstance;
        
        List<inscor__Company__c> companyInstances = [SELECT Id, inscor__Company_Name__c, inscor__Address_1__c, inscor__City__c, inscor__Zip_Code__c FROM inscor__Company__c];
        
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Customer_Quote__c customerQuoteRec = new inscor__Customer_Quote__c();
            customerQuoteRec.inscor__Customer__c = accList[0].Id;
            customerQuoteRec.inscor__Company__c = companyInstances[0].Id;
            customerQuoteRec.inscor__Status__c = 'New';
            customerQuoteToInsertList.add(customerQuoteRec);
        }
        insert customerQuoteToInsertList;
    }
    
    @isTest
	private static void test() {
	    List<Opportunity> oppList = new List<Opportunity>([SELECT Id FROM Opportunity]);
        PartNumberController.getCustomerQuotesLineItem(10,10,oppList[0].Id,'a');
	}

}