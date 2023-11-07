/**************************************************************************************************
Description: Trigger class for Account that will handle all types of trigger events Test Methods.
====================================================================================================
====================================================================================================
Class: AccountTriggerHandler_Test
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		05/19/2021		    Gourav Goyal				Initial Creation     
***************************************************************************************************/
@isTest
public class AccountTriggerHandler_Test {
    public TestMethod static void updateCustomerAccountNumberTest()
        
    {
        Account objacc = New Account();
        objacc.Name='test';
        objacc.inscor__Account_Number__c = '9197347';
        objacc.inscor__Accounting_Type__c='Customer';
        insert objacc;
        Test.startTest();
        System.assert(objacc!=null);
        Test.stopTest();
    }
    public TestMethod static void addCustomerAccountNumberTest()
        
    {
        Account objacc = New Account();
        objacc.Name='test';
        objacc.inscor__Account_Number__c = '';
        objacc.inscor__Accounting_Type__c='Customer';
        insert objacc;
        Test.startTest();
        System.assert(objacc!=null);
        Test.stopTest();
    }
    public TestMethod static void updateVendorAccountNumberTest()
        
    {
        Account objacc = New Account();
        objacc.Name='test';
        objacc.inscor__Account_Number__c = '9197347';
        objacc.inscor__Accounting_Type__c='Vendor';
        insert objacc;
        Test.startTest();
        System.assert(objacc!=null);
        Test.stopTest();
    }
    public TestMethod static void addVendorAccountNumberTest()
        
    {
        Account objacc = New Account();
        objacc.Name='test';
        objacc.inscor__Account_Number__c = '';
        objacc.inscor__Accounting_Type__c='Vendor';
        insert objacc;
        Test.startTest();
        System.assert(objacc!=null);
        Test.stopTest();
    }
    
    @isTest
    public static void triggerMethodsTest() { 
        test.StartTest();
        Account objacc = New Account();
        objacc.Name='test';
        objacc.inscor__Account_Number__c = '';
        objacc.inscor__Accounting_Type__c='Vendor';
        insert objacc;
        List<Account> recList = new List<Account>([SELECT id FROM Account]);
        test.stopTest();   
        delete recList;
        List<Account> recListToAssert = new List<Account>([SELECT id FROM Account]);
        system.assertEquals(recListToAssert.size(), 0);
        undelete recList;  
    }
    
    @isTest
    public static void triggerDisabledFlagTest() { 
        test.StartTest();
        //Trigger Disabled Coverage
        Trigger_Configuration__c tc = new Trigger_Configuration__c();
        tc.Account_Trigger_Disable__c  = TRUE;
        insert tc;
        Account objacc = New Account();
        objacc.Name='test';
        objacc.inscor__Account_Number__c = '';
        objacc.inscor__Accounting_Type__c='Vendor';
        insert objacc;
        List<Account> recList = new List<Account>([SELECT id FROM Account]);
        test.stopTest();   
        delete recList;
        List<Account> recListToAssert = new List<Account>([SELECT id FROM Account]);
        system.assertEquals(recListToAssert.size(), 0);
    }
    
}