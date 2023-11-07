/**************************************************************************************************
Description: Trigger class for inscor__Release__c that will handle all types of trigger events.
====================================================================================================
====================================================================================================
TestClass: ReleaseTriggerHelperTest
Code Coverage: 100%
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		05/28/2021		    Gourav Goyal				Initial Creation     
***************************************************************************************************/
trigger ReleaseTrigger on inscor__Release__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	TriggerDispatcher.Run(new ReleaseTriggerHelper(), Trigger.operationType);
}