/**************************************************************************************************
Description: Trigger class for Account that will handle all types of trigger events.
====================================================================================================
====================================================================================================
TestClass: AccountTriggerHandler_Test
Code Coverage: 100%
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		05/19/2021		    Gourav Goyal				Initial Creation     
***************************************************************************************************/
trigger AccountTrigger on Account (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    //TriggerDispatcher.Run(AccountTriggerHandler, Trigger.operationType);
    TriggerDispatcher.Run(new AccountTriggerHandler(), Trigger.operationType);
}