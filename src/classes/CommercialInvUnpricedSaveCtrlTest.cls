@isTest
public class CommercialInvUnpricedSaveCtrlTest {
     
    @testSetup()
    private static void setup(){
        
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
        
        inscor__Customer_Quote__c customerQuoteRec = new inscor__Customer_Quote__c();
        customerQuoteRec.inscor__Customer__c = accRec.Id;
        customerQuoteRec.inscor__Status__c = 'New';
        customerQuoteRec.inscor__Company__c = companyInstance.Id;
        insert customerQuoteRec;
        
        inscor__Sales_Order__c salesOrderRec = new inscor__Sales_Order__c();
        salesOrderRec.inscor__Quote_Number__c = customerQuoteRec.Id;
        salesOrderRec.inscor__Customer__c = accRec.Id;
        salesOrderRec.inscor__Company__c = companyInstance.Id;
        insert salesOrderRec;
        
        Product2 productRec = new Product2(Name = 'Laptop X200', 
                                           Family = 'Hardware', inscor__Keyword__c ='test');
        insert productRec;
        
        inscor__Condition_Code__c conditionCode = new inscor__Condition_Code__c(Name ='Condition Code 1', inscor__Show_in_Summary__c = false);
        insert conditionCode;
        
        inscor__Sales_Order_Line__c salesOrderLineRec = new inscor__Sales_Order_Line__c();
        salesOrderLineRec.inscor__Order__c = salesOrderRec.Id;
        salesOrderLineRec.inscor__Condition_Code__c = conditionCode.Id;
        salesOrderLineRec.inscor__Quantity_Ordered__c = 10;
        salesOrderLineRec.inscor__Product__c = productRec.Id;
        insert salesOrderLineRec;
        
        inscor__Account_Ship_Address__c addRec = new inscor__Account_Ship_Address__c();
        insert addRec;
        
        inscor__Release__c releaseRec = new inscor__Release__c();
        releaseRec.inscor__Ship_To_Address__c = addRec.Id;
        releaseRec.inscor__Sales_Order__c = salesOrderRec.Id;
        
        insert releaseRec;
        
        
        inscor__Condition_Code__c conditionalCode  = new inscor__Condition_Code__c( inscor__Show_in_Summary__c = false);
        insert conditionalCode;
        
        inscor__Form_Options__c formOption = new inscor__Form_Options__c();
        formOption.name = 'Packing Slip (Unpriced)';
        formOption.inscor__Footer__c = 'test footer';
        formOption.inscor__Body_1__c = 'test body';
        formOption.inscor__Company__c = companyInstance.Id;
        insert formOption;
        
    }    
    
    @isTest
    static void batchWithParamTest() {
        List<inscor__Release__c> releases = [SELECT Id, Name FROM inscor__Release__c];
        Test.startTest();
        PageReference testPage = Page.CommercialInvoiceUnpricedSaveAsFile; 
        Test.setCurrentPage(testPage);
        testPage.getParameters().put('Id', releases[0].Id);
        
        ApexPages.StandardController sc = new  ApexPages.StandardController(releases[0]);
        CommercialInvoiceUnpricedSaveAsFileCtrl ext = new CommercialInvoiceUnpricedSaveAsFileCtrl(sc);
        Test.stopTest();
        
    } 

}