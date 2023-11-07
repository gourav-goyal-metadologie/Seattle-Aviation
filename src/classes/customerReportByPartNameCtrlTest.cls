@isTest
public class customerReportByPartNameCtrlTest {
    
    public static final Integer COUNT_LIMIT = 10;    
    @testSetup static void setup() {
        Test.setMock(HttpCalloutMock.class, new YayPayMockResponseGenerator());
        Reports_Configuration__c reportConfig = new Reports_Configuration__c();
        reportConfig.Minimum_No_of_Orders__c = 1;
        reportConfig.Minimum_No_of_Quotes__c = 1;
        insert reportConfig;
        //Create a Account for Customer
        Account accRec = new Account();
        accRec.Name='test';
        accRec.inscor__Account_Number__c = '9197347';
        accRec.inscor__Accounting_Type__c='Customer';
        insert accRec;
        
        inscor__Company__c  company = new inscor__Company__c(inscor__Address_1__c = '1111', 
                                                             inscor__City__c = '1111', 
                                                             inscor__Company_Name__c = '1111', 
                                                             inscor__Zip_Code__c = '1111');
        insert company;

        Contact con = new Contact();
        con.FirstName ='Test';
        con.LastName ='Contact';
        con.AccountId = accRec.Id;
        con.Email ='test@etst.com';
        insert con;   
        Product2 prod = new Product2(Name = 'Laptop X200', 
                                     Family = 'Hardware', inscor__Keyword__c ='test');
        insert prod;
        List<inscor__Customer_Quote__c> customerQuoteToInsertList = new List<inscor__Customer_Quote__c>();
        List<inscor__Customer_Quote_Line__c> customerQuoteLineToInsertList = new List<inscor__Customer_Quote_Line__c>();
        
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Customer_Quote__c customerQuoteRec = new inscor__Customer_Quote__c();
            customerQuoteRec.inscor__Customer__c = accRec.Id;
            customerQuoteRec.inscor__Status__c = 'New';
            customerQuoteRec.inscor__Company__c = company.Id;
            customerQuoteToInsertList.add(customerQuoteRec);
        }
        insert customerQuoteToInsertList;
        for(inscor__Customer_Quote__c quoteRec : customerQuoteToInsertList){
            for(Integer i = 0; i< COUNT_LIMIT; i++) { 
                inscor__Customer_Quote_Line__c qouteLineRec = new inscor__Customer_Quote_Line__c();
                qouteLineRec.inscor__Customer_Quote__c = quoteRec.Id;
                qouteLineRec.inscor__Quantity__c = 10;
                qouteLineRec.inscor__Business_Category__c = 'Distribution';
                qouteLineRec.inscor__Product__c = prod.id;
                customerQuoteLineToInsertList.add(qouteLineRec);
            }  
        }
        
        insert customerQuoteLineToInsertList;
        inscor__Condition_Code__c conditionCode = new inscor__Condition_Code__c(Name ='Condition Code 1', inscor__Show_in_Summary__c = false);
        insert conditionCode; 
        
        List<inscor__Sales_Order__c> salesOrderToInsertList = new List<inscor__Sales_Order__c>();
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Sales_Order__c salesOrderRec = new inscor__Sales_Order__c();
            salesOrderRec.inscor__Quote_Number__c = customerQuoteToInsertList[i].Id;
            salesOrderRec.inscor__Customer__c = accRec.Id;
            salesOrderRec.inscor__Company__c = company.Id;
            salesOrderToInsertList.add(salesOrderRec);
        }
        insert salesOrderToInsertList;  
        List<inscor__Sales_Order_Line__c> salesOrderLineToInsertList = new List<inscor__Sales_Order_Line__c>();
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Sales_Order_Line__c salesOrderLineRec = new inscor__Sales_Order_Line__c();
            salesOrderLineRec.inscor__Order__c = salesOrderToInsertList[i].Id;
            salesOrderLineRec.inscor__Condition_Code__c = conditionCode.Id;
            salesOrderLineRec.inscor__Quantity_Ordered__c = 10;
            salesOrderLineRec.inscor__Product__c = prod.id;
            salesOrderLineToInsertList.add(salesOrderLineRec);
        }
        insert salesOrderLineToInsertList;
    }
    
    @isTest static void getQuoteResultsTest() {
        Test.setMock(HttpCalloutMock.class, new YayPayMockResponseGenerator());
        test.startTest();
        List<customerQuoteReportByPartNameCtrl.ReportWrapper> result = customerQuoteReportByPartNameCtrl.getQuoteResults();
        test.stopTest();
        system.assertEquals(result.size(), 1);
    }
     
    @isTest static void getOrderResultsTest() {
        Test.setMock(HttpCalloutMock.class, new YayPayMockResponseGenerator());
        test.startTest();
        List<customerQuoteReportByPartNameCtrl.ReportWrapper> result = customerQuoteReportByPartNameCtrl.getOrderResults();
        test.stopTest();
        system.assertEquals(result.size(), 1);
    }
    
    
    
}