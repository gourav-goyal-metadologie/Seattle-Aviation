/**************************************************************************************************
Description: This is the interface to be implemented by all trigger handler classes.
Simply complete the implemented methods which are required for the trigger. 
Leave any events that you do not need blank. 
====================================================================================================
====================================================================================================
TestClass: 
Code Coverage: 
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		05/24/2021         	Gourav Goyal				Initial Creation    
***************************************************************************************************/
public interface TriggerHandler {
    
    void BeforeInsert(SObject[] newList);
    
    void BeforeUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap);
    
    void BeforeDelete(Map<Id, SObject> oldMap);
    
    void AfterInsert(Map<Id, SObject> newMap);
    
    void AfterUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap);
    
    void AfterDelete(Map<Id, SObject> oldMap);
    
    void AfterUndelete(Map<Id, SObject> newMap);
    
    // This method needs to be implemented to check whether or not trigger logic should run.
    Boolean IsDisabled();
    
}