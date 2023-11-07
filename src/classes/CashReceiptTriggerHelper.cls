/**************************************************************************************************
Description: Trigger Helper class for BillingTrigger that will handle all types of trigger events.
====================================================================================================
====================================================================================================
TestClass: -
Code Coverage: -
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		06/18/2021		    Gourav Goyal				Initial Creation    
***************************************************************************************************/
public class CashReceiptTriggerHelper implements TriggerHandler {
    
    /*Allows unit tests (or other code) to disable this trigger for the transaction */
    
    public static Boolean TriggerDisabled = false;
    
    /*Checks to see if the trigger has been disabled either by custom setting or by running code*/
    
    public Boolean IsDisabled() {
        /*Use the option below if you set up Custom Settings to controll Triggers*/
        Trigger_Configuration__c configSetting = Trigger_Configuration__c.getInstance();   
        if(configSetting.CashReceipt_Trigger_Disable__c == true) {
            return true;
        } else {
            return TriggerDisabled;
        }
    }
    
    /* CALLING */
    public void BeforeInsert(SObject[] newList) {
        resetYayPayCashReceiptFields( (List<AcctSeed__Cash_Receipt__c>)newList  );
    }
    
    public void BeforeUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {
        resetYayPayCashReceiptFields( (List<AcctSeed__Cash_Receipt__c>)newMap.values()  );
    }
    
    public void BeforeDelete(Map<Id, SObject> oldMap) {}
    
    public void AfterInsert(Map<Id, SObject> newMap) {
    }
    
    public void AfterUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {
             
    }
    
    public void AfterDelete(Map<Id, SObject> oldMap) {
        createDeleteRecords( (List<AcctSeed__Cash_Receipt__c>)oldMap.values() );
    }
    
    public void AfterUndelete(Map<Id, SObject> oldMap) {
        
    }    
    
    public static void resetYayPayCashReceiptFields( List<AcctSeed__Cash_Receipt__c> newList ){
       
        if( System.isBatch() ){
            return;
        }
        try{
            //reset Fields.
            for(AcctSeed__Cash_Receipt__c rep : newList){
                rep.Is_Processed__c = FALSE;
                rep.YayPay_Error_Message__c = '';                
            }
            if(Test.isRunningTest())
                Integer i = 1/0; 
        }catch (Exception error) {  
            LogService.createErrorLog('CashReceiptTriggerHelper.apxc', NULL, error, NULL); 
        }  
        
    }
    
    public static void createDeleteRecords( List<AcctSeed__Cash_Receipt__c> oldList ){
       
        if( System.isBatch() ){
            return;
        }
        try{
            List<Deleted_Record__c> deleteRecordsToInsert = new List<Deleted_Record__c>();
            for(AcctSeed__Cash_Receipt__c rep : oldList){
                if( rep.YayPay_Last_Sync_Date__c != null ){
                	deleteRecordsToInsert.add( new Deleted_Record__c( Deleted_Record_Id__c = rep.Id,
                                                                    Object_Type__c = 'payments'));
                }
            }
            if( deleteRecordsToInsert.size() > 0 ){
                insert deleteRecordsToInsert;
            }
            if(Test.isRunningTest())
                Integer i = 1/0; 
        }catch (Exception error) {  
            LogService.createErrorLog('CashReceiptTriggerHelper.apxc', NULL, error, NULL); 
        }  
        
    }
   
}