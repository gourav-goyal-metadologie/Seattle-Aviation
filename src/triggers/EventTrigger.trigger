trigger EventTrigger on Event (after insert, after update , after delete) {
	EventTriggerHelper.oldMap  = (Map<Id, Event >)Trigger.oldMap; 
    EventTriggerHelper.oldList = (List< Event >)Trigger.old;
    EventTriggerHelper.newMap  = (Map<Id, Event >)Trigger.newMap; 
    EventTriggerHelper.newList = (List< Event >)Trigger.new;
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            EventTriggerHelper.updateLeadProbablityOnInsert();
        }
        if(Trigger.isUpdate){
            EventTriggerHelper.updateLeadProbablityOnUpdate();
        }
        if(Trigger.isDelete){
            EventTriggerHelper.updateLeadProbablityOnDelete();
        }
    }
}