@isTest
public class SyncInvoicesToYaypayControllerTest {
    
    @testSetup()
    private static void setup(){
        Test.setMock(HttpCalloutMock.class, new YayPayMockResponseGenerator());
        Account acc = new Account();
        acc.Name ='Test Account';
        insert acc;
        
        Contact con = new Contact();
        con.FirstName ='Test';
        con.LastName ='Contact';
        con.AccountId = acc.Id;
        con.Email ='test@etst.com';
        insert con;
        
        YayPay_Configuration__c yayPayConfigSetting = YayPay_Configuration__c.getOrgDefaults();   
        yayPayConfigSetting.EndPoint__c = 'https://developer.yaypay.com/api/v1/token';
        yayPayConfigSetting.Transaction_End_Time__c = 10;
        yayPayConfigSetting.Records_To_Query_Batch__c = '10';
        yayPayConfigSetting.Batch_Interval_Minutes__c = 10;
        yayPayConfigSetting.Is_Integration_Enable__c = true;
        
        yayPayConfigSetting.Client_Key__c = '45q70fmc8n1agi258vhnaoh99e';
        yayPayConfigSetting.Client_Secret__c = '1mqaafklenu997svqlcv8j7u5cifhchdbifd4fdopc759lejmj0';
        upsert yayPayConfigSetting;
        
        Product2 productRec = new Product2(Name = 'Laptop X200', 
                                           Family = 'Hardware', inscor__Keyword__c ='test', inscor__Description__c ='Test Desc.');
        insert productRec;
        
    }
    
    @isTest
    static void batchWithParamTest() {
        
        Account acc = [ SELECT Id FROM Account LIMIT 1];
        Contact con = [ SELECT Id FROM Contact LIMIT 1];
        inscor__Invoice__c inv = new inscor__Invoice__c();
        inv.inscor__Invoice_Date__c = Date.today();
        inv.inscor__Status__c ='Created';
        inv.inscor__Account__c = acc.Id;
        inv.inscor__Billing_Contact__c = con.Id;
        insert inv;
        
        List<inscor__Invoice__c> invoices = new List<inscor__Invoice__c>();
        invoices.add(inv);
        
        inscor__Invoice_Line__c invLine = new inscor__Invoice_Line__c();
        invLine.inscor__Price__c =200;
        invLine.inscor__Quantity__c = 2;
        invLine.inscor__Invoice__c = inv.Id;
        insert invLine;
        
        Test.setMock(HttpCalloutMock.class, new YayPayMockResponseGenerator());
        Test.startTest();
        Test.setCurrentPage(Page.SyncInvoicesToYayPay);
        ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(invoices);
        stdSetController.setSelected(invoices);
        SyncInvoicesToYaypayController SyncInvoiceToYayPayCtrl = new SyncInvoicesToYaypayController(stdSetController);
        SyncInvoiceToYayPayCtrl.SyncInvoicesToYayPay();
        Test.stopTest();
    }
}