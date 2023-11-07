@isTest
public class SalesOrderPDFControllerTEST {

    public static final Integer COUNT_LIMIT = 2;
    public static final Integer COUNT_LIMIT_FOR_LINE_ITEM = 2;

    @TestSetup
    static void setupTestData(){

        Account accRec = new Account();
        accRec.Name = 'TEST';
        accRec.inscor__Account_Number__c = '2';  
        insert accRec;

        inscor__Company__c  company = new inscor__Company__c(
        inscor__Address_1__c = '1111', inscor__City__c = '1111', inscor__Company_Name__c = '1111', inscor__Zip_Code__c = '1111');
        insert company;

        List<inscor__Customer_Quote__c> customerQuoteToInsertList = new List<inscor__Customer_Quote__c>();
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Customer_Quote__c customerQuoteRec = new inscor__Customer_Quote__c();
            customerQuoteRec.inscor__Customer__c = accRec.Id;
            customerQuoteRec.inscor__Status__c = 'New';
            customerQuoteRec.inscor__Company__c = company.Id;
            customerQuoteToInsertList.add(customerQuoteRec);
        }
        insert customerQuoteToInsertList;

        List<inscor__Customer_Quote_Line__c> customerQuoteLineToInsertList = new List<inscor__Customer_Quote_Line__c>();
        for(inscor__Customer_Quote__c quoteRec : customerQuoteToInsertList){
            for(Integer i = 0; i< COUNT_LIMIT_FOR_LINE_ITEM; i++) { 
            	inscor__Customer_Quote_Line__c qouteLineRec = new inscor__Customer_Quote_Line__c();
                qouteLineRec.inscor__Customer_Quote__c = quoteRec.Id;
                qouteLineRec.inscor__Quantity__c = 10;
                qouteLineRec.inscor__Business_Category__c = 'Distribution';
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
        
        Product2 pr = new Product2(Name = 'Laptop X200', Family = 'Hardware', inscor__Keyword__c ='test');
        insert pr;

        List<inscor__Sales_Order_Line__c> salesOrderLineToInsertList = new List<inscor__Sales_Order_Line__c>();
        for(inscor__Sales_Order__c salesOrder : salesOrderToInsertList){
            for(Integer i = 0; i< COUNT_LIMIT_FOR_LINE_ITEM; i++) {
                inscor__Sales_Order_Line__c salesOrderLineRec = new inscor__Sales_Order_Line__c();
                salesOrderLineRec.inscor__Order__c = salesOrder.Id;
                salesOrderLineRec.inscor__Condition_Code__c = conditionCode.Id;
                salesOrderLineRec.inscor__Quantity_Ordered__c = 10;
                salesOrderLineRec.inscor__Product__c = pr.Id;
                salesOrderLineToInsertList.add(salesOrderLineRec);
            }
        }
        insert salesOrderLineToInsertList;
    }


    @IsTest
    static void testSalesOrderPdfController(){
        
        Test.startTest();
        inscor__Sales_Order__c salesOrder = [SELECT Id FROM inscor__Sales_Order__c LIMIT 1];
        PageReference salesOrderPdfPage = Page.SalesOrderPDF; 
        Test.setCurrentPage(salesOrderPdfPage);
        salesOrderPdfPage.getParameters().put('Id', salesOrder.Id);
        
        ApexPages.StandardController sc = new  ApexPages.StandardController(salesOrder);
        SalesOrderPDFController salesOrderPDFController = new SalesOrderPDFController(sc);
        System.assertEquals(COUNT_LIMIT_FOR_LINE_ITEM, salesOrderPDFController.salesOrderLines.size());
        Test.stopTest();
        
    }

}