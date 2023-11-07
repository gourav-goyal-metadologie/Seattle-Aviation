/**************************************************************************************************
Description: test class used to test apex class CommonUtility
====================================================================================================
====================================================================================================
TestClass: 
Code Coverage: 
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		10/14/2021		   Vinod Kumar Sharma       		Initial Creation   
***************************************************************************************************/
@IsTest
private class OpportunityUtilityTest {
    public static final Integer COUNT_LIMIT = 5;

    @TestSetup
    static void setupTestData(){
        Account accRec = new Account();
        accRec.Name = 'Customer 101';
        accRec.inscor__Account_Number__c = '2';  
        insert accRec;

        inscor__Company__c companyInstance = new inscor__Company__c();
        companyInstance.inscor__Company_Name__c = 'inscor Company' ;
        companyInstance.inscor__Address_1__c = 'address';
        companyInstance.inscor__City__c = 'xyz';
        companyInstance.inscor__Zip_Code__c = '21321';
        insert companyInstance;

        Product2 product = new Product2(name = '12345', inscor__Keyword__c = 'test');
        insert product;
        
        Contact c = new Contact();
        c.FirstName = 'Customer';
        c.LastName = 'Contact 101';
        c.Email = 'customercontact101@xyz.com';
        c.AccountId = accRec.Id;
        insert c;

        List<inscor__Customer_Quote__c> customerQuoteToInsertList = new List<inscor__Customer_Quote__c>();
        List<inscor__Customer_Quote_Line__c> customerQuoteLineToInsertList = new List<inscor__Customer_Quote_Line__c>();
        
        for(Integer i = 0; i< COUNT_LIMIT; i++) 
        {
            inscor__Customer_Quote__c customerQuoteRec = new inscor__Customer_Quote__c();
            customerQuoteRec.inscor__Customer__c = accRec.Id;
            customerQuoteRec.inscor__Company__c = companyInstance.Id;
            customerQuoteRec.inscor__Status__c = 'New';
            customerQuoteToInsertList.add(customerQuoteRec);
        }
        insert customerQuoteToInsertList;

        List<Opportunity> oppList = new List<Opportunity>([SELECT Id FROM Opportunity]);
        
        for(inscor__Customer_Quote__c quoteRec : customerQuoteToInsertList)
        {
            for(Integer i = 0; i< COUNT_LIMIT; i++) 
            { 
                inscor__Customer_Quote_Line__c qouteLineRec = new inscor__Customer_Quote_Line__c();
                qouteLineRec.inscor__Customer_Quote__c = quoteRec.Id;
                qouteLineRec.inscor__Quantity__c = 10;
                if (i < 2) {
                    qouteLineRec.inscor__Business_Category__c = 'Distribution';
                }else if(MATH.mod(i, 2) == 0){
                    qouteLineRec.inscor__Business_Category__c = 'Surplus';
                }else {
                    qouteLineRec.inscor__Business_Category__c = 'Broker';
                }
                customerQuoteLineToInsertList.add(qouteLineRec);
            }  
        }
        insert customerQuoteLineToInsertList;

        inscor__Condition_Code__c conditionCode = new inscor__Condition_Code__c(Name ='Condition Code 1', inscor__Show_in_Summary__c = false);	
        insert conditionCode;
    }

    @IsTest
    static void testCalculateOpportunityProbablity(){
        
        Test.startTest();
        List<Account> accList = new List<Account>([SELECT Id,Name FROM Account LIMIT 1]);
        inscor__Condition_Code__c conditionCode = [SELECT Id,Name FROM inscor__Condition_Code__c LIMIT 1];
        List<inscor__Customer_Quote__c> customerQuoteList = [SELECT Id FROM inscor__Customer_Quote__c];
        inscor__Company__c company = [SELECT Id FROM inscor__Company__c];
        List<inscor__Sales_Order__c> salesOrderToInsertList = new List<inscor__Sales_Order__c>();

        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Sales_Order__c salesOrderRec = new inscor__Sales_Order__c();
            salesOrderRec.inscor__Quote_Number__c = customerQuoteList[i].Id;
            salesOrderRec.inscor__Customer__c = accList[0].Id;
            salesOrderRec.inscor__Company__c = company.Id;
            salesOrderToInsertList.add(salesOrderRec);
        }
        insert salesOrderToInsertList;

        List<inscor__Sales_Order__c> salesOrderList = new List<inscor__Sales_Order__c>([SELECT Id FROM inscor__Sales_Order__c]);
        system.assertEquals(salesOrderList.size(), COUNT_LIMIT);

        List<inscor__Sales_Order_Line__c> salesOrderLineToInsertList = new List<inscor__Sales_Order_Line__c>();
        Product2 pr = new Product2(Name = 'Laptop X200', Family = 'Hardware', inscor__Keyword__c ='test');
        insert pr;

        for(inscor__Sales_Order__c salesOrder : salesOrderList){
            for(Integer i = 0; i< COUNT_LIMIT; i++) {
                inscor__Sales_Order_Line__c salesOrderLineRec = new inscor__Sales_Order_Line__c();
                salesOrderLineRec.inscor__Order__c = salesOrder.Id;
                salesOrderLineRec.inscor__Condition_Code__c = conditionCode.Id;
                salesOrderLineRec.inscor__Quantity_Ordered__c = 10;
                salesOrderLineRec.inscor__Product__c = pr.Id;
                salesOrderLineToInsertList.add(salesOrderLineRec);
            }
        }
        insert salesOrderLineToInsertList;
        for (inscor__Customer_Quote__c quote : customerQuoteList) {
            quote.inscor__Status__c = 'Closed - Won';
        }
        update customerQuoteList;
        OpportunityUtility.calculateOpportunityProbablity(new Set<String> {accList.get(0).Id});
        Test.stopTest();
        
    }
}