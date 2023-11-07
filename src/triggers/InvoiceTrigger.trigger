/**************************************************************************************************
Description: Trigger class for Invoice that will handle all types of trigger events.
====================================================================================================
====================================================================================================
TestClass: 
Code Coverage: 
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		06/10/2021		    Gourav Goyal				Initial Creation     
***************************************************************************************************/
trigger InvoiceTrigger on inscor__Invoice__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	TriggerDispatcher.Run(new InvoiceTriggerHelper(), Trigger.operationType);
}