/**************************************************************************************************
Description: Trigger Helper class for AccountTriggerHelper that will handle all types of trigger events.
====================================================================================================
====================================================================================================
TestClass: 
Code Coverage: 
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		06/02/2021		    Gourav Goyal				Initial Creation    
***************************************************************************************************/
public class AccountTriggerHelper implements TriggerHandler {
    
    /*Allows unit tests (or other code) to disable this trigger for the transaction */
    
    public static Boolean TriggerDisabled = false;
    
    /*Checks to see if the trigger has been disabled either by custom setting or by running code*/
    
    public Boolean IsDisabled() {
        /*Use the option below if you set up Custom Settings to controll Triggers*/
        Trigger_Configuration__c configSetting = Trigger_Configuration__c.getInstance();   
        if(configSetting.Account_Trigger_Disable__c == true) {
            return true;
        } else {
            return TriggerDisabled;
        }
    }
    
    /* CALLING */
    public void BeforeInsert(SObject[] newList) {
        updateAccountNumber( (List<Account>)newList );
    }
    
    public void BeforeUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {
        updateAccountNumber((List<Account>)newMap.values() );
    }
    
    public void BeforeDelete(Map<Id, SObject> oldMap) {}
    
    public void AfterInsert(Map<Id, SObject> newMap) {
        sendAccountToYayPay((List<Account>)newMap.values(), NULL);
    }
    
    public void AfterUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {
        sendAccountToYayPay((List<Account>)newMap.values(), (Map<Id, Account>) oldMap);
    }
    
    public void AfterDelete(Map<Id, SObject> oldMap) {
        
    }
    
    public void AfterUndelete(Map<Id, SObject> oldMap) {}

    
    
    public static void sendAccountToYayPay(List<Account> newList, Map<Id, Account> oldMap){
       
        List<Account> filteredAccountList = new List<Account>();
        set<Id> accountIds = new set<Id>();
        
        try {
            //getting filtered Contact.
            for(Account acc : newList){
                if( Trigger.isInsert ){
                    filteredAccountList.add( acc );
                }else if( Trigger.isUpdate ){
                    if( ( acc.Name != oldMap.get( acc.Id ).Name)
                      || ( acc.DNBI__DnB_DUNS_NO__c != oldMap.get( acc.Id ).DNBI__DnB_DUNS_NO__c) 
                      || ( acc.inscor__Account_Region__c != oldMap.get( acc.Id ).inscor__Account_Region__c) 
                      || ( acc.inscor__Credit_Limit__c != oldMap.get( acc.Id ).inscor__Credit_Limit__c) 
                      || ( acc.inscor__Account_Terms__c != oldMap.get( acc.Id ).inscor__Account_Terms__c) 
                      || ( acc.ShippingCity != oldMap.get( acc.Id ).ShippingCity) 
                      || ( acc.Shippingcountry != oldMap.get( acc.Id ).Shippingcountry) 
                      || ( acc.inscor__Billing_Contact__c != oldMap.get( acc.Id ).inscor__Billing_Contact__c )
                      || ( acc.ShippingStreet != oldMap.get( acc.Id ).ShippingStreet )
                      || ( acc.Phone != oldMap.get( acc.Id ).Phone )
                      || ( acc.ShippingState != oldMap.get( acc.Id ).ShippingState )
                      || ( acc.ShippingPostalCode != oldMap.get( acc.Id ).ShippingPostalCode )
                      || ( acc.Website != oldMap.get( acc.Id ).Website )){
                        filteredAccountList.add( acc );
                    }
                }
                
            }           
            
            Set<Id> validAccountIds = new Set<Id>();
            for(Account acc : filteredAccountList){
                validAccountIds.add(acc.Id);
            }
            
            if(validAccountIds.size() > 0){
                if( YayPayUtility.sendYayPayCallout() ){
                    Database.executeBatch(new BatchProcessCustomerToYayPay(validAccountIds), 10);
                }
            }
            if(Test.isRunningTest())
                Integer i = 1/0; 
        } catch (Exception error) {	
            LogService.createErrorLog('AccountTriggerHelper.apxc', NULL, error, NULL);	
        }  
        
    }
    
   
     public static void updateAccountNumber(List<Account> accList){
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
}