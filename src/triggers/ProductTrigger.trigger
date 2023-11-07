/**************************************************************************************************
Description: Trigger class for Product2 that will handle all types of trigger events.
====================================================================================================
====================================================================================================
TestClass: -
Code Coverage: -
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		06/02/2021		    Gourav Goyal				Initial Creation     
***************************************************************************************************/
trigger ProductTrigger on Product2 (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	TriggerDispatcher.Run(new ProductTriggerHelper(), Trigger.operationType);
}