/**************************************************************************************************
Description: Trigger class for inscor__Customer_Quote__c that will handle all types of trigger events.
====================================================================================================
====================================================================================================
TestClass: CustomerQuoteTriggerHelperTest
Code Coverage: 100%
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		05/20/2021		    Gourav Goyal				Initial Creation 
***************************************************************************************************/
trigger CustomerQuotTrigger on inscor__Customer_Quote__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	TriggerDispatcher.Run(new CustomerQuoteTriggerHelper(), Trigger.operationType);
}