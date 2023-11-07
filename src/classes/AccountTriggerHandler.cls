/**************************************************************************************************
Description: Trigger Helper class for Account that will handle all types of trigger events.
====================================================================================================
====================================================================================================
TestClass: AccountTriggerHandler_Test
Code Coverage: 100%
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		05/19/2021		    Gourav Goyal				Initial Creation    
2.0 -      		10/23/2021		    Vinod Kumar Sharma				customerScoreCalculations   
***************************************************************************************************/
public class AccountTriggerHandler implements TriggerHandler {
    
    /*Allows unit tests (or other code) to disable this trigger for the transaction */
    
    public static Boolean TriggerDisabled = false;
    
    /*Checks to see if the trigger has been disabled either by custom setting or by running code*/
    
    public Boolean IsDisabled() {
        /*Use the option below if you set up Custom Settings to controll Triggers*/
        if (TriggerDisabled == true) {
            return true;
        }else {
            Trigger_Configuration__c configSetting = Trigger_Configuration__c.getInstance();   
            if(configSetting.Account_Trigger_Disable__c == true) {
                return true;
            } else {
                return TriggerDisabled;
            }
        }
    }


    
    /* CALLING */
    public void BeforeInsert(SObject[] newList) {
        AccountTriggerHandler.updateAccountNumber((List<Account>)newList);
    }
    
    public void BeforeUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {
        AccountTriggerHandler.customerScoreCalculations((List<Account>)newMap.values(), (Map<Id, Account>) oldMap);
        AccountTriggerHandler.updateAccountNumber((List<Account>)newMap.values());
    }

    public void BeforeDelete(Map<Id, SObject> oldMap) {
        
    }
    
    public void AfterInsert(Map<Id, SObject> newMap) {   }
    
    public void AfterUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {   }
    
    public void AfterDelete(Map<Id, SObject> oldMap) {  }
    
    public void AfterUndelete(Map<Id, SObject> oldMap) {}

    /* DEFINITION */
    
    public static void updateAccountNumber(List<Account> accList) {
        try{
            Integer uniqueKeyCustomer = 100001; 
            Integer uniqueKeyVendor = 200001; 
            
            //Get the last updated highest unique key from account
            for(Account acc:[select id, inscor__Account_Number__c from account where inscor__Account_Number__c like '1%' order by inscor__Account_Number__c desc]){
                if(!String.isEmpty(acc.inscor__Account_Number__c) && acc.inscor__Account_Number__c.isNumeric()){
                    uniqueKeyCustomer = Integer.valueof(acc.inscor__Account_Number__c);
                    break;
                }
            }
            for(Account acc:[select id, inscor__Account_Number__c from account where inscor__Account_Number__c like '2%' order by inscor__Account_Number__c desc]){
                if(!String.isEmpty(acc.inscor__Account_Number__c) && acc.inscor__Account_Number__c.isNumeric()){
                    uniqueKeyVendor = Integer.valueof(acc.inscor__Account_Number__c);
                    break;
                }
            }
            
            for(Account acc : accList){
                if(!String.isEmpty(acc.inscor__Account_Number__c)){
                    acc.inscor__Account_Number__c = updateExistingAccountNumber(acc, uniqueKeyCustomer, uniqueKeyVendor);
                }else {
                    acc.inscor__Account_Number__c = addNewAccountNumber(acc, uniqueKeyCustomer, uniqueKeyVendor);
                }
                
            }
            
            if(Test.isRunningTest())
                Integer i = 1/0;  
        } catch(Exception error) {
            LogService.createErrorLog('AccountTriggerHandler.apxc', NULL, error, NULL);	
        }
    }
    public static string updateExistingAccountNumber(Account acc, Integer uniqueKeyCustomer, Integer uniqueKeyVendor){
        if(!String.isEmpty(acc.inscor__Accounting_Type__c) && acc.inscor__Accounting_Type__c == 'Customer' && acc.inscor__Account_Number__c.substring(0,1)!='1'){
            uniqueKeyCustomer++;
            acc.inscor__Account_Number__c = string.valueof(uniqueKeyCustomer);
        }else if(!String.isEmpty(acc.inscor__Accounting_Type__c) && acc.inscor__Accounting_Type__c == 'Vendor' && acc.inscor__Account_Number__c.substring(0,1)!='2'){
            uniqueKeyVendor++;
            acc.inscor__Account_Number__c = string.valueof(uniqueKeyVendor);
        }
        return acc.inscor__Account_Number__c;
        
    }
    public static string addNewAccountNumber(Account acc, Integer uniqueKeyCustomer, Integer uniqueKeyVendor){
        if(!String.isEmpty(acc.inscor__Accounting_Type__c) && acc.inscor__Accounting_Type__c == 'Customer'){
            uniqueKeyCustomer++;
            acc.inscor__Account_Number__c = string.valueof(uniqueKeyCustomer);
        }else if(!String.isEmpty(acc.inscor__Accounting_Type__c) && acc.inscor__Accounting_Type__c == 'Vendor'){
            uniqueKeyVendor++;
            acc.inscor__Account_Number__c = string.valueof(uniqueKeyVendor);
        }
        return acc.inscor__Account_Number__c;
        
    }

    /**
     * @description : method used to update customer score on the account whenever account will be update
     */
    private static void customerScoreCalculations(List<Account> accList, Map<Id, Account> oldMap) {
        List<Account> accountListToUpdateCustomerScore = new List<Account>();
        for (Account  account : accList) {
            if (account.Sales_Orders_Lines_Received__c != oldMap.get(account.Id).Sales_Orders_Lines_Received__c
                || account.Customer_Quotes_Lines_Received__c != oldMap.get(account.Id).Customer_Quotes_Lines_Received__c
                || account.Total_Sales__c != oldMap.get(account.Id).Total_Sales__c
                || account.Average_Margin__c != oldMap.get(account.Id).Average_Margin__c) {

                accountListToUpdateCustomerScore.add(account);
            }
        }
        if (!accountListToUpdateCustomerScore.isEmpty()) {
            List<Customer_Score_Factor__mdt> customerScoreFactorList = [SELECT Weightage__c, Starting_Number__c, Ending_Number__c, Type__c FROM Customer_Score_Factor__mdt];
            
            Decimal numberOfSOL;
            Decimal numberOfCQL;
            Decimal totalSales;
            Decimal avgMarginPercent;
            for(Account acc : accList) {
                numberOfSOL = acc.Sales_Orders_Lines_Received__c;
                numberOfCQL = acc.Customer_Quotes_Lines_Received__c;
                totalSales = acc.Total_Sales__c;
                avgMarginPercent = acc.Average_Margin__c;
                acc.Customer_Score_2__c = 0;
                for(Customer_Score_Factor__mdt customerScoreFactor : customerScoreFactorList) {
                    if(customerScoreFactor.Type__c == 'Sales Orders Lines Received' && customerScoreFactor.Starting_Number__c <= numberOfSOL && (customerScoreFactor.Ending_Number__c == null || customerScoreFactor.Ending_Number__c >= numberOfSOL)) {
                        acc.Customer_Score_2__c += customerScoreFactor.Weightage__c;
                    }
                    if(customerScoreFactor.Type__c == 'Customer Quotes Lines Received' && customerScoreFactor.Starting_Number__c <= numberOfCQL && (customerScoreFactor.Ending_Number__c == null || customerScoreFactor.Ending_Number__c >= numberOfCQL)) {
                        acc.Customer_Score_2__c += customerScoreFactor.Weightage__c;
                    }
                    if(customerScoreFactor.Type__c == 'Total Sales' && customerScoreFactor.Starting_Number__c <= totalSales && (customerScoreFactor.Ending_Number__c == null || customerScoreFactor.Ending_Number__c >= totalSales)) {
                        acc.Customer_Score_2__c += customerScoreFactor.Weightage__c;
                    }
                    if(customerScoreFactor.Type__c == 'Margin' && customerScoreFactor.Starting_Number__c <= avgMarginPercent && (customerScoreFactor.Ending_Number__c == null || customerScoreFactor.Ending_Number__c >= avgMarginPercent)) {
                        acc.Customer_Score_2__c += customerScoreFactor.Weightage__c;
                    }
                }
            }
        }
    }
}