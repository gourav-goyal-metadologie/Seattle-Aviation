/**************************************************************************************************
Description: Trigger class for AcctSeed__Billing__c that will handle all types of trigger events.
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
trigger BillingTrigger on AcctSeed__Billing__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	TriggerDispatcher.Run(new BillingTriggerHelper(), Trigger.operationType);
}