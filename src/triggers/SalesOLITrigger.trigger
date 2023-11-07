/**************************************************************************************************
Description: Trigger class for inscor__Sales_Order_Line__c that will handle all types of trigger events.
====================================================================================================
====================================================================================================
TestClass: SalesOrderLineItemTriggerHelperTest
Code Coverage: 100%
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		05/20/2021		    Gourav Goyal				Initial Creation     
***************************************************************************************************/
trigger SalesOLITrigger on inscor__Sales_Order_Line__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    TriggerDispatcher.Run(new SalesOrderLineItemTriggerHelper(), Trigger.operationType);
}