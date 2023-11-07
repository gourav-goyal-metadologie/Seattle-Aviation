/**************************************************************************************************
Description: Trigger Helper class for AcctSeed__Billing__c that will handle all types of trigger events.
====================================================================================================
====================================================================================================
TestClass: BillingsTriggerHelperTest
Code Coverage: 92%
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		09/03/2021		    Kushal Bagadia				Initial Creation    
***************************************************************************************************/
public class BillingsTriggerHelper implements TriggerHandler {
    
    /*Allows unit tests (or other code) to disable this trigger for the transaction */
    
    public static Boolean TriggerDisabled = false;
        
        /*Checks to see if the trigger has been disabled either by custom setting or by running code*/
        
        public Boolean IsDisabled() {
            /*Use the option below if you set up Custom Settings to controll Triggers*/
            Trigger_Configuration__c configSetting = Trigger_Configuration__c.getInstance();   
            if(configSetting.Billing_Trigger_Disabled__c == true) {
                return true;
            } else {
                return TriggerDisabled;
            }
        }
    
    /* CALLING */
    public void BeforeInsert(SObject[] newList) {
        BillingsTriggerHelper.updateCountryAndState((List<AcctSeed__Billing__c>)newList);
    }
    
    public void BeforeUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {
        BillingsTriggerHelper.updateCountryAndState((List<AcctSeed__Billing__c>)newMap.values());
    }
    
    public void BeforeDelete(Map<Id, SObject> oldMap) {}
    
    public void AfterInsert(Map<Id, SObject> newMap) {
    }
    
    public void AfterUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {  
    }
    
    public void AfterDelete(Map<Id, SObject> oldMap) {  }
    
    public void AfterUndelete(Map<Id, SObject> oldMap) {}
    
    public static void updateCountryAndState(List<AcctSeed__Billing__c> newList){
        for(AcctSeed__Billing__c billing : newList){
            if(billing.AcctSeed__Billing_Country__c != null && Country_Codes__mdt.getInstance(billing.AcctSeed__Billing_Country__c.replaceAll(' ', '_')) != null){
                billing.AcctSeed__Billing_Country__c = Country_Codes__mdt.getInstance(billing.AcctSeed__Billing_Country__c.replaceAll(' ', '_')).Country_Code__c;
            }
            if(billing.AcctSeed__Shipping_Country__c != null && Country_Codes__mdt.getInstance(billing.AcctSeed__Shipping_Country__c.replaceAll(' ', '_')) != null){
                billing.AcctSeed__Shipping_Country__c = Country_Codes__mdt.getInstance(billing.AcctSeed__Shipping_Country__c.replaceAll(' ', '_')).Country_Code__c;
            }
            if(billing.AcctSeed__Billing_Country__c == 'US' && billing.AcctSeed__Billing_State__c != null && State_Code__mdt.getInstance(billing.AcctSeed__Billing_State__c.replaceAll(' ', '_')) != null){
                billing.AcctSeed__Billing_State__c = State_Code__mdt.getInstance(billing.AcctSeed__Billing_State__c.replaceAll(' ', '_')).State_Code__c;
            }
            if(billing.AcctSeed__Shipping_Country__c == 'US' && billing.AcctSeed__Shipping_State__c != null && State_Code__mdt.getInstance(billing.AcctSeed__Shipping_State__c.replaceAll(' ', '_')) != null){
                billing.AcctSeed__Shipping_State__c = State_Code__mdt.getInstance(billing.AcctSeed__Shipping_State__c.replaceAll(' ', '_')).State_Code__c;
            }
        }
    }
}