/**************************************************************************************************
Description: Test class for CoreExchangeReturn LWCs controller 
====================================================================================================
====================================================================================================
TestClass: CoreExchangeReturnCtrlTest
Code Coverage: %
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		09/02/2021		    Nikhil Kumar Srivastava		 Initial Creation    
***************************************************************************************************/
@isTest
public class CoreExchangeReturnCtrlTest {
    public static final Integer COUNT_LIMIT = 2;

    @TestSetup
    private static void setup() { 
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

        Product2 product = new Product2(name = '12345', inscor__Keyword__c = 'test', inscor__Description__c = 'Test Description');
        insert product;
        
        Contact con = new Contact();
        con.FirstName = 'Customer';
        con.LastName = 'Contact 101';
        con.Email = 'customercontact101@xyz.com';
        con.AccountId = accRec.Id;
        insert con;

        List<inscor__Customer_Quote__c> customerQuoteToInsertList = new List<inscor__Customer_Quote__c>();
        List<inscor__Customer_Quote_Line__c> customerQuoteLineToInsertList = new List<inscor__Customer_Quote_Line__c>();
        
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Customer_Quote__c customerQuoteRec = new inscor__Customer_Quote__c();
            customerQuoteRec.inscor__Customer__c = accRec.Id;
            customerQuoteRec.inscor__Company__c = companyInstance.Id;
            customerQuoteRec.inscor__Status__c = 'New';
            customerQuoteToInsertList.add(customerQuoteRec);
        }
        insert customerQuoteToInsertList;

        List<Opportunity> oppList = new List<Opportunity>([SELECT Id FROM Opportunity]);
        
        for(inscor__Customer_Quote__c quoteRec : customerQuoteToInsertList){
            for(Integer i = 0; i< COUNT_LIMIT; i++) { 
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
        
        List<inscor__Customer_Quote__c> customerQuoteList = new List<inscor__Customer_Quote__c>([SELECT Id FROM inscor__Customer_Quote__c]);
        List<inscor__Sales_Order__c> salesOrders = new List<inscor__Sales_Order__c>();
        
        for(Integer i = 0; i < COUNT_LIMIT; i++) {
            inscor__Sales_Order__c salesOrder = new inscor__Sales_Order__c();
            salesOrder.inscor__Quote_Number__c = customerQuoteList[i].Id;
            salesOrder.inscor__Customer__c = accRec.Id;
            salesOrder.inscor__Company__c = companyInstance.Id;
            salesOrder.inscor__Contact__c = con.Id;
            salesOrder.inscor__Assigned_To__c = UserInfo.getUserId();
            salesOrders.add(salesOrder);
        }
        insert salesOrders;  

        List<inscor__Sales_Order_Line__c> salesOrderLines = new List<inscor__Sales_Order_Line__c>();
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Sales_Order_Line__c salesOrderLine = new inscor__Sales_Order_Line__c();
            salesOrderLine.inscor__Order__c = salesOrders[i].Id;
            salesOrderLine.inscor__Condition_Code__c = conditionCode.Id;
            salesOrderLine.inscor__Quantity_Ordered__c = 10;
            salesOrderLine.inscor__Product__c = product.Id;
            salesOrderLine.inscor__Exchange_Type__c = 'Cost Plus';
            salesOrderLines.add(salesOrderLine);
        }
        insert salesOrderLines;

        List<inscor__Customer_Exchange_Summary__c> cess = new List<inscor__Customer_Exchange_Summary__c>();
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Customer_Exchange_Summary__c ces = new inscor__Customer_Exchange_Summary__c();
            ces.inscor__Original_SO_ID__c = salesOrders[i].Id;
            ces.inscor__Original_SO_Line__c = salesOrderLines[i].Id;
            ces.inscor__Original_Core_Due_Date__c = Math.mod(i, 2) == 0 ? Date.today().addDays(5): Date.today().addDays(0);
            ces.inscor__Exchange_Status__c = FollowUpEmailCtrl.SHIPPED;
            ces.inscor__Original_Product__c = product.Id;
            cess.add(ces);
        }
        insert cess;
    }


    @isTest
    private static void validateGetCoreExchangeRecord(){
        Test.startTest();
        
        List<inscor__Customer_Exchange_Summary__c> customerExchangeSummaries = [SELECT Id FROM inscor__Customer_Exchange_Summary__c];
        
        for(inscor__Customer_Exchange_Summary__c ces : customerExchangeSummaries){
            System.assert(CoreExchangeReturnCtrl.getCoreExchangeRecord(ces.Id) != NULL);
        }
    	//Handle Exception
        try {
            System.assert(CoreExchangeReturnCtrl.getCoreExchangeRecord(NULL) == NULL);
        } catch (Exception e) {
            System.assert(e != NULL);
        }
        Test.stopTest();

        
    }

    @isTest 
    private static void validateSaveCoreExchangeRecord(){
        Test.startTest();
        List<inscor__Customer_Exchange_Summary__c> customerExchangeSummaries = [SELECT Id FROM inscor__Customer_Exchange_Summary__c];
        CoreExchangeReturnCtrl.CustomerExchangeSummaryFormResponse formResponseWrapper = CoreExchangeReturnCtrl.getCoreExchangeRecord(customerExchangeSummaries.get(0).Id);
        formResponseWrapper.AWB = 'AZC';
        formResponseWrapper.AircraftModel = 'Test';
        formResponseWrapper.TSO = 'TSO';
        formResponseWrapper.CSO = 'CSO';
        formResponseWrapper.AgreementToNonIncident = true;
        CoreExchangeReturnCtrl.CustomerExchangeSummaryFormResponse saveFormResponseWrapper = CoreExchangeReturnCtrl.saveCoreExchangeRecord(JSON.serialize(formResponseWrapper));
        system.assert(saveFormResponseWrapper.formResponseId != Null);
        
		CoreExchangeReturnCtrl.CustomerExchangeSummaryFormResponse formResponseWrapperAfterFormSaved = CoreExchangeReturnCtrl.getCoreExchangeRecord(customerExchangeSummaries.get(0).Id);
        System.assert(formResponseWrapperAfterFormSaved.AWB == 'AZC');
        
        //HandleException 
        try {
            CoreExchangeReturnCtrl.saveCoreExchangeRecord(NULL);
        }catch (Exception e) {
            System.assert(e != NULL);
        }
        Test.stopTest();        
    }
	
    
    @isTest
    private static void testAfterSubmitProcess(){

        Test.startTest();
        List<inscor__Customer_Exchange_Summary__c> customerExchangeSummaries = [SELECT Id FROM inscor__Customer_Exchange_Summary__c];
        CoreExchangeReturnCtrl.CustomerExchangeSummaryFormResponse formResponseWrapper = CoreExchangeReturnCtrl.getCoreExchangeRecord(customerExchangeSummaries.get(0).Id);
        formResponseWrapper.AWB = 'AZC';
        formResponseWrapper.AircraftModel = 'Test';
        formResponseWrapper.AgreementToNonIncident = true;
        CoreExchangeReturnCtrl.CustomerExchangeSummaryFormResponse saveFormResponseWrapper = CoreExchangeReturnCtrl.saveCoreExchangeRecord(JSON.serialize(formResponseWrapper));
        CoreExchangeReturnCtrl.AfterSubmitProcess(JSON.serialize(saveFormResponseWrapper));
        CoreExchangeReturnCtrl.CustomerExchangeSummaryFormResponse formResponseWrapperAfterFormSaved = CoreExchangeReturnCtrl.getCoreExchangeRecord(customerExchangeSummaries.get(0).Id);
        System.assert(formResponseWrapperAfterFormSaved.AWB == 'AZC');
        system.assert(saveFormResponseWrapper.formResponseId != Null);
        
        //HandleException 
        try {
            CoreExchangeReturnCtrl.AfterSubmitProcess(JSON.serialize(formResponseWrapper));
        } catch (Exception e) {
            System.assert(e != NULL);
        }
        Test.stopTest();
    }
	
    
    @isTest
    private static void testUtilMethods(){
        Test.startTest();
        inscor__Customer_Exchange_Summary__c customerExchangeSummarie = [SELECT Id, Request_More_Information_JSON__c FROM inscor__Customer_Exchange_Summary__c Limit 1];
        customerExchangeSummarie.Request_More_Information_JSON__c = 'Test';
        update customerExchangeSummarie;
        CoreExchangeReturnCtrl.CustomerExchangeSummaryFormResponse formResponseWrapper = CoreExchangeReturnCtrl.getCoreExchangeRecord(customerExchangeSummarie.Id);
        formResponseWrapper.AWB = 'AZC';
        formResponseWrapper.AgreementToNonIncident = true;
        CoreExchangeReturnCtrl.CustomerExchangeSummaryFormResponse saveFormResponseWrapper = CoreExchangeReturnCtrl.saveCoreExchangeRecord(JSON.serialize(formResponseWrapper));
        CoreExchangeReturnCtrl.getPDFAsBase64(saveFormResponseWrapper.formResponseId);
        CoreExchangeReturnCtrl.CustomerExchangeSummaryFormResponse saveExistFromAgainWrapper = CoreExchangeReturnCtrl.saveCoreExchangeRecord(JSON.serialize(saveFormResponseWrapper));
        
        System.assert(saveExistFromAgainWrapper.formResponseId == saveFormResponseWrapper.formResponseId);
        Test.stopTest();
    }
    
}