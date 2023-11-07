/**************************************************************************************************
Description: Used to test apex class : CustomerScoreCalcVerSecondBatch
====================================================================================================
====================================================================================================
Class: CustomerScoreCalcVerSecondBatchTest
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		10/13/2021		   Vinod Kumar Sharma				Initial Creation    
***************************************************************************************************/
@isTest
public class CustomerScoreCalcVerSecondBatchTest {
    public static final Integer COUNT_LIMIT = 10;

    @TestSetup
    private static void testDataSetup(){
        Account accRec = new Account();
        accRec.Name = 'TEST';
        accRec.inscor__Account_Number__c = '2';  
        insert accRec;

        inscor__Company__c companyInstance = new inscor__Company__c();
        companyInstance.inscor__Company_Name__c = 'inscor Company' ;
        companyInstance.inscor__Address_1__c = 'address';
        companyInstance.inscor__City__c = 'xyz';
        companyInstance.inscor__Zip_Code__c = '21321';
        insert companyInstance;
        
        inscor__Condition_Code__c conditionCode = new inscor__Condition_Code__c(name = 'test code', inscor__Show_in_Summary__c = false);
        insert conditionCode;

        Product2 product = new Product2(name = '12345', inscor__Keyword__c = 'test');
        insert product;
        
        inscor__Customer_Quote__c customerQuoteRec;
        List<inscor__Customer_Quote__c> customerQuoteToInsertList = new List<inscor__Customer_Quote__c>();
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            customerQuoteRec = new inscor__Customer_Quote__c();
            customerQuoteRec.inscor__Customer__c = accRec.Id;
            customerQuoteRec.inscor__Company__c = companyInstance.Id;
            customerQuoteRec.inscor__Status__c = 'New';
            customerQuoteToInsertList.add(customerQuoteRec);
        }

        insert customerQuoteToInsertList;

        inscor__Customer_Quote_Line__c customerQuoteLineRec;
        List<inscor__Customer_Quote_Line__c> customerQuoteLineToInsertList = new List<inscor__Customer_Quote_Line__c>();
        for(inscor__Customer_Quote__c customerQuote : customerQuoteToInsertList) {
            customerQuoteLineRec = new inscor__Customer_Quote_Line__c();
            customerQuoteLineRec.inscor__Customer_Quote__c = customerQuote.Id;
            customerQuoteLineRec.inscor__Price__c = 122;
            customerQuoteLineRec.inscor__Product__c = product.id;
            customerQuoteLineRec.inscor__Quantity__c = 12;
            customerQuoteLineRec.inscor__Condition_Code__c = conditionCode.id;
            customerQuoteLineToInsertList.add(customerQuoteLineRec);
        }
        insert customerQuoteLineToInsertList;
    }
    
    @isTest
    private static void testCustomerScoreCalcVerSecondBatch(){
        Test.startTest();
        CustomerScoreCalcVerSecondBatch customerScoreCalcVerSecondBatch = new CustomerScoreCalcVerSecondBatch();
        String jobId = Database.executeBatch(new CustomerScoreCalcVerSecondBatch(), 10);
        System.assert(jobId != null);
        Test.stopTest();
    }
}