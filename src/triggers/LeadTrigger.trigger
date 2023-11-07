/**************************************************************************************************
Description: Trigger class for Lead that will handle all types of trigger events.
====================================================================================================
====================================================================================================
TestClass: LeadTriggerHelperTest
Code Coverage: 100%
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		05/15/2021        	Gourav Goyal 				Initial Creation   
***************************************************************************************************/
trigger LeadTrigger on Lead (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	TriggerDispatcher.Run(new LeadTriggerHelper(), Trigger.operationType);
}