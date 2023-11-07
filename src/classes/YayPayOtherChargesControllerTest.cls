@isTest
public class YayPayOtherChargesControllerTest {

    @testSetup()
    private static void setup(){
        AccountTriggerHelper.TriggerDisabled = true;
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
        
        inscor__Invoice__c inv = new inscor__Invoice__c();
        inv.inscor__Invoice_Date__c = Date.today();
        inv.inscor__Status__c ='Created';
        inv.inscor__Account__c = acc.Id;
        inv.inscor__Billing_Contact__c = con.Id;
        inv.YayPay_Last_Sync_Date__c = DateTime.now();
        insert inv;
        
        inscor__Invoice_Line__c invLine = new inscor__Invoice_Line__c();
        invLine.inscor__Price__c =200;
        invLine.inscor__Quantity__c = 2;
        invLine.inscor__Invoice__c = inv.Id;
        insert invLine;
        
        AcctSeed__Accounting_Period__c period = new AcctSeed__Accounting_Period__c();
        period.Name ='2021-06';
        period.AcctSeed__End_Date__c = date.today().addDays(10);
        period.AcctSeed__Start_Date__c = date.today();
        insert period;
        
        AcctSeed__Billing_Format__c format = new AcctSeed__Billing_Format__c();
        format.Name ='format11';
        format.AcctSeed__Default_Email_Template__c = 'Billing_Email_Template';
        format.AcctSeed__Visualforce_PDF_Page__c = 'BillingProductModernPDF';
        insert format;
        
         AcctSeed__Billing_Format__c format2 = new AcctSeed__Billing_Format__c();
        format2.Name ='format11';
        format2.AcctSeed__Default_Email_Template__c = 'Billing_Email_Template';
        format2.AcctSeed__Visualforce_PDF_Page__c = 'BillingProductModernPDF';
        format2.AcctSeed__Type__c= 'Activity Statement';
        insert format2;
        
        AcctSeed__Billing_Format__c format3= new AcctSeed__Billing_Format__c();
        format3.Name ='format11';
        format3.AcctSeed__Default_Email_Template__c = 'Billing_Email_Template';
        format3.AcctSeed__Visualforce_PDF_Page__c = 'BillingProductModernPDF';
        format3.AcctSeed__Type__c= 'Outstanding Statement';
        insert format3;
        
        AcctSeed__Billing_Format__c format4 = new  AcctSeed__Billing_Format__c();
        format4.Name ='format11';
        format4.AcctSeed__Default_Email_Template__c = 'Billing_Email_Template';
        format4.AcctSeed__Visualforce_PDF_Page__c = 'BillingProductModernPDF';
        format4.AcctSeed__Type__c= 'Billing';
        insert format4;
        
        AcctSeed__GL_Account__c accObj = new AcctSeed__GL_Account__c();
        accObj.Name ='Test';
        accObj.AcctSeed__Sub_Type_1__c = 'Liabilities';
        accObj.AcctSeed__Bank__c = TRUE;
        insert accObj;
        
         AcctSeed__GL_Account__c accObj02 = new AcctSeed__GL_Account__c();
        accObj02.Name ='Test';
        accObj02.AcctSeed__Sub_Type_1__c = 'Liabilities';
        insert accObj02;
        
        AcctSeed__Ledger__c ledger = new AcctSeed__Ledger__c();
        ledger.Name = 'Budget';
        ledger.AcctSeed__Type__c = 'Transactional';
        ledger.AcctSeed__Billing_Activity_Statement_Format__c = format2.Id;
        ledger.AcctSeed__Billing_Outstanding_Statement_Format__c = format3.Id;
        ledger.AcctSeed__Default_Bank_Account__c = accObj.Id;
        ledger.AcctSeed__Default_Billing_Format__c = format4.Id;
        insert ledger;
        
        AcctSeed__Billing__c billing = new AcctSeed__Billing__c();
        billing.AcctSeed__Status__c = 'Posted';
        billing.AcctSeed__Customer__c = acc.Id;
        billing.AcctSeed__Date__c = Date.today();
        billing.inscoras__Invoice__c = inv.Id;
        billing.AcctSeed__Accounting_Period__c = period.Id;
        billing.AcctSeed__Billing_Format__c = format.Id;
        billing.AcctSeed__Ledger__c = ledger.Id;
        //billing.AcctSeed__Type__c = 'Credit Memo';
        insert billing;
        
        AcctSeed__Billing_Line__c billLine = new AcctSeed__Billing_Line__c();
        //billLine.Name = 'Test';
        billLine.AcctSeed__Billing__c = billing.Id;
        billLine.AcctSeed__Rate__c = 2;
        billLine.AcctSeed__Hours_Units__c = 2;
        billLine.AcctSeed__Revenue_GL_Account__c = accObj02.Id;
        billLine.AcctSeed__Tax_Amount2__c = -200;
        insert billLine;  
        
        AcctSeed__Billing__c billing02 = new AcctSeed__Billing__c();
        billing02.AcctSeed__Status__c = 'Posted';
        billing02.AcctSeed__Customer__c = acc.Id;
        billing02.AcctSeed__Date__c = Date.today();
        billing02.inscoras__Invoice__c = inv.Id;
        billing02.AcctSeed__Accounting_Period__c = period.Id;
        billing02.AcctSeed__Billing_Format__c = format.Id;
        billing02.AcctSeed__Ledger__c = ledger.Id;
        //billing.AcctSeed__Type__c = 'Credit Memo';
        insert billing02;
        
        AcctSeed__Billing_Line__c billLine02 = new AcctSeed__Billing_Line__c();
        //billLine.Name = 'Test';
        billLine02.AcctSeed__Billing__c = billing02.Id;
        billLine02.AcctSeed__Rate__c = 2;
        billLine02.AcctSeed__Hours_Units__c = 2;
        billLine02.AcctSeed__Revenue_GL_Account__c = accObj02.Id;
        billLine02.AcctSeed__Tax_Amount2__c = 200;
        insert billLine02;  
        
        AcctSeed__Billing_Credit_Memo__c cMemo = new AcctSeed__Billing_Credit_Memo__c(
            AcctSeed__Accounting_Period__c = period.Id, AcctSeed__Amount__c = -20.0,
            AcctSeed__Billing_Credit_Memo__c = billing.Id, AcctSeed__Billing_Invoice__c = billing02.Id);
        insert cMemo;
    } 
    
    @isTest
    private static void getOtherChargesTest() {
        Test.startTest();
        List<String> getOtherCharges= YayPayOtherChargesController.getOtherCharges();
        Test.stopTest();
    } 
    
    @isTest
    private static void getRecordTest() {
        
        AcctSeed__Billing__c billObj = [ SELECT Id FROM AcctSeed__Billing__c LIMIT 1];
        Test.startTest();
        AcctSeed__Billing__c getRecord= YayPayOtherChargesController.getRecord(billObj.Id);
        Test.stopTest();
    } 
    
    @isTest
    private static void updateBillingCommentTest() {
        
        AcctSeed__Billing__c billObj = [ SELECT Id FROM AcctSeed__Billing__c LIMIT 1];
        Test.startTest();
        AcctSeed__Billing__c updateBillingComment= YayPayOtherChargesController.updateBillingComment(billObj.Id, 'Credit Card Fees');
        Test.stopTest();
    } 
}