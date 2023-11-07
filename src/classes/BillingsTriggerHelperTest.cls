/**************************************************************************************************
Description: Trigger class for AcctSeed__Billing__c that will handle all types of trigger events Test Methods.
====================================================================================================
====================================================================================================
Class: BillingsTriggerHelperTest
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		09/03/2021		    Kushal Bagadia				Initial Creation     
***************************************************************************************************/
@isTest
private class BillingsTriggerHelperTest {
    
    @isTest
	private static void test() {
	    Account accRec = new Account();
        accRec.Name = 'TEST Account';
        accRec.inscor__Account_Number__c = '2';  
        insert accRec;
        
        AcctSeed__Accounting_Period__c accPeriod = new AcctSeed__Accounting_Period__c();
        accPeriod.Name = '2021-06';
        accPeriod.AcctSeed__Start_Date__c = System.today();
        accPeriod.AcctSeed__Status__c = 'Open';
        accPeriod.AcctSeed__End_Date__c = System.today();
        insert accPeriod;
        
        AcctSeed__Billing_Format__c billFormat = new AcctSeed__Billing_Format__c();
        billFormat.Name = 'test';
        billFormat.AcctSeed__Default_Email_Template__c =  'Billing_Email_Template';
        billFormat.AcctSeed__Visualforce_PDF_Page__c = 'BillingProductModernPDF';
        insert billFormat;
        
        AcctSeed__GL_Account__c acc = new AcctSeed__GL_Account__c();
        acc.Name = 'Test';
        acc.AcctSeed__Type__c = 'Balance Sheet';
        acc.AcctSeed__Sub_Type_1__c = 'Assets';
        acc.AcctSeed__Bank__c = true;
        insert acc;
        
        AcctSeed__Ledger__c ledger = new AcctSeed__Ledger__c();
        ledger.Name = 'test';
        ledger.AcctSeed__Type__c = 'Transactional';
        ledger.AcctSeed__Billing_Activity_Statement_Format__c = billFormat.Id;
        ledger.AcctSeed__Billing_Outstanding_Statement_Format__c = billFormat.Id;
        ledger.AcctSeed__Default_Bank_Account__c = acc.Id;
        ledger.AcctSeed__Default_Billing_Format__c = billFormat.Id;
        insert ledger;
	    
        AcctSeed__Billing__c billing = new AcctSeed__Billing__c();
        billing.AcctSeed__Shipping_State__c = 'Texas';
        billing.AcctSeed__Billing_State__c = 'Texas';
        billing.AcctSeed__Shipping_Country__c = 'United States';
        billing.AcctSeed__Billing_Country__c = 'United States';
        billing.AcctSeed__Customer__c = accRec.Id;
        billing.AcctSeed__Accounting_Period__c = accPeriod.Id;
        billing.AcctSeed__Billing_Format__c = billFormat.Id;
        // billing.AcctSeed__Default_Billing_Format__c = billFormat.Id;
        billing.AcctSeed__Ledger__c = ledger.Id;
        test.StartTest();
        insert billing;
        billing.AcctSeed__Shipping_State__c = 'Tex';
        update billing;
        delete billing;
        test.StopTest();
	}

}