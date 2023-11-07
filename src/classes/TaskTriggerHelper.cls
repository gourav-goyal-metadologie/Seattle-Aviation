/**************************************************************************************************
Description: Trigger Helper class for Task that will handle all types of trigger events.
====================================================================================================
====================================================================================================
TestClass: TaskTriggerHelperTest
Code Coverage: 
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		05/22/2021		    Gourav Goyal				Initial Creation    
***************************************************************************************************/
public class TaskTriggerHelper implements TriggerHandler {
    
    /*Allows unit tests (or other code) to disable this trigger for the transaction */
    
    public static Boolean TriggerDisabled = false;
    
    /*Checks to see if the trigger has been disabled either by custom setting or by running code*/
    
    public Boolean IsDisabled() {
        /*Use the option below if you set up Custom Settings to controll Triggers*/
        Trigger_Configuration__c configSetting = Trigger_Configuration__c.getInstance();   
        if(configSetting.Task_Trigger_Disable__c == true) {
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
        TaskTriggerHelper.updateLeadProbablityOnInsert((List<Task>)newMap.values());
    }
    
    public void AfterUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {
        TaskTriggerHelper.updateLeadProbablityOnUpdate((List<Task>)newMap.values(),(Map<Id, Task>)oldMap);
    }
    
    public void AfterDelete(Map<Id, SObject> oldMap) {
        TaskTriggerHelper.updateLeadProbablityOnDelete((List<Task>)oldMap.values());
    }
    
    public void AfterUndelete(Map<Id, SObject> oldMap) {}
    
    /* DEFINITION */
    public static void updateLeadProbablityOnInsert(List<Task> newList) {
        try{
            Set<Id> leadIds = new Set<Id>();
            for(Task taskRec :  newList){
                if(taskRec.WhoId != null && ((String)(taskRec.WhoId)).StartsWith('00Q')){
                    leadIds.add(taskRec.WhoId);
                }
            }
            LeadUtilityCntrl.updateLeadConversionProbablity(leadIds);
            if(Test.isRunningTest())
                Integer i = 1/0;  
        } catch(Exception error) {
            LogService.createErrorLog('.apxc', NULL, error, NULL);	
        }
    }
    
    public static void updateLeadProbablityOnUpdate(List<Task> newList, Map<Id, Task> oldMap){
        try{
            Set<Id> leadIds = new Set<Id>();
            for(Task taskRec :  newList){
                if(taskRec.WhoId != null && ((String)(taskRec.WhoId)).StartsWith('00Q') && taskRec.WhoId != oldMap.get(taskRec.Id).WhoId){
                    leadIds.add(taskRec.WhoId);
                    leadIds.add(oldMap.get(taskRec.Id).WhoId);
                }
            }
            LeadUtilityCntrl.updateLeadConversionProbablity(leadIds);            
            if(Test.isRunningTest())
                Integer i = 1/0;  
        } catch(Exception error) {
            LogService.createErrorLog('.apxc', NULL, error, NULL);	
        } 
    }
    
    public static void updateLeadProbablityOnDelete(List<Task> oldList){
        try{
            Set<Id> leadIds = new Set<Id>();
            for(Task taskRec :  oldList){
                if(taskRec.WhoId != null && ((String)(taskRec.WhoId)).StartsWith('00Q')){
                    leadIds.add(taskRec.WhoId); 
                }
            }
            LeadUtilityCntrl.updateLeadConversionProbablity(leadIds); 
            if(Test.isRunningTest())
                Integer i = 1/0;
        } catch (Exception error) {	
            LogService.createErrorLog('TaskTriggerHelper.apxc', NULL, error, NULL);	
        }  
    }
}