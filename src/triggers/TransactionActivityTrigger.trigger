/**************************************************************************************************
Description: Trigger class for Activity that will handle all types of trigger events.
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
trigger TransactionActivityTrigger on inscor__Activity__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	TriggerDispatcher.Run(new TransactionActivityTriggerHelper(), Trigger.operationType);
}