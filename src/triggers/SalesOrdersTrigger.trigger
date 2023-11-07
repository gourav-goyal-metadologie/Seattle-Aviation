/**************************************************************************************************
Description: Trigger class for inscor__Sales_Order__c that will handle all types of trigger events.
====================================================================================================
====================================================================================================
TestClass: 
Code Coverage: 
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		05/22/2021		    Gourav Goyal				Initial Creation     
***************************************************************************************************/
trigger SalesOrdersTrigger on inscor__Sales_Order__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	TriggerDispatcher.Run(new SalesOrdersTriggerHelper(), Trigger.operationType);
}