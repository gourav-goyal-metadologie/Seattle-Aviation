/**************************************************************************************************
Description: Trigger class for Task that will handle all types of trigger events.
====================================================================================================
====================================================================================================
TestClass: BillingsTriggerHelperTest
Code Coverage: 100%
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		09/03/2021		    Kushal Bagadia				Initial Creation      
***************************************************************************************************/
trigger BillingsTrigger on AcctSeed__Billing__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    TriggerDispatcher.Run(new BillingsTriggerHelper(), Trigger.operationType);
}