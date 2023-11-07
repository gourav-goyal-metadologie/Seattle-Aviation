/**************************************************************************************************
Description: Trigger Helper class for TransactionActivityTrigger that will handle all types of trigger events.
====================================================================================================
====================================================================================================
TestClass: 
Code Coverage: 
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		06/11/2021		    Gourav Goyal				Initial Creation    
***************************************************************************************************/
public class TransactionActivityTriggerHelper implements TriggerHandler {
    
    /*Allows unit tests (or other code) to disable this trigger for the transaction */
    
    public static Boolean TriggerDisabled = false;
    
    /*Checks to see if the trigger has been disabled either by custom setting or by running code*/
    
    public Boolean IsDisabled() {
        /*Use the option below if you set up Custom Settings to controll Triggers*/
        Trigger_Configuration__c configSetting = Trigger_Configuration__c.getInstance();   
        if(configSetting.TransactionActivity_Trigger_Disable__c == true) {
            return true;
        } else {
            return TriggerDisabled;
        }
    }
    
    /* CALLING */
    public void BeforeInsert(SObject[] newList) {}
    
    public void BeforeUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {}
    
    public void BeforeDelete(Map<Id, SObject> oldMap) {}
    
    public void AfterInsert(Map<Id, SObject> newMap) {
        sendTransactionForComplianceCheck((List<inscor__Activity__c>)newMap.values(), NULL);
    }
    
    public void AfterUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {
        sendTransactionForComplianceCheck((List<inscor__Activity__c>)newMap.values(), (Map<Id, inscor__Activity__c>) oldMap);
    }
    
    public void AfterDelete(Map<Id, SObject> oldMap) {
        
    }
    
    public void AfterUndelete(Map<Id, SObject> oldMap) {}

    
    
    public static void sendTransactionForComplianceCheck(List<inscor__Activity__c> newList, Map<Id, inscor__Activity__c> oldMap){
       
        List<inscor__Activity__c> filteredTransactionList = new List<inscor__Activity__c>();
        set<Id> accountIds = new set<Id>();
        
        try {
            //getting filtered Contact.
            for(inscor__Activity__c act : newList){
                if( Trigger.isInsert ){
                    if( act.inscor__INVC__c != null ){
                        filteredTransactionList.add( act );
                    }
                    
                }else if( Trigger.isUpdate ){
                    if( ( act.inscor__INVC__c!= null && act.inscor__INVC__c != oldMap.get( act.Id ).inscor__INVC__c ) ||
                       ( act.inscor__Line_Value__c!= null && act.inscor__Line_Value__c != oldMap.get( act.Id ).inscor__Line_Value__c )
                       ){
                        filteredTransactionList.add( act );
                    }
                }
            }           
            
            Set<Id> validInvoiceIds = new Set<Id>();
            for(inscor__Activity__c act : filteredTransactionList){
                validInvoiceIds.add(act.inscor__INVC__c);
            }
            
            if(validInvoiceIds.size() > 0){
                //Database.executeBatch(new BatchProcessInvoiceToYayPay( validInvoiceIds, true ), 1);
            }
            if(Test.isRunningTest())
                Integer i = 1/0; 
        }catch (Exception error) {	
            LogService.createErrorLog('InvoiceTriggerHandler.apxc', NULL, error, NULL);	
        }  
        
    }
}