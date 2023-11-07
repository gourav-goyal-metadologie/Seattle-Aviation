trigger AlternateTrigger on inscor__Alternate__c (after insert, after update, after delete, before insert, before update, before delete) {
    TriggerDispatcher.Run(new AlternateTriggerHelper(), Trigger.operationType);
}