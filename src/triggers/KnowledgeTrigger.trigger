trigger KnowledgeTrigger on Knowledge__c (before insert) {
	KnowledgeTriggerHandler.updateDefaultProfiles(Trigger.new);
}