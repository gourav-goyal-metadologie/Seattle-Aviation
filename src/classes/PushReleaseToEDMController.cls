public with sharing class PushReleaseToEDMController {
    @AuraEnabled
    public static String pushReleaseToEDM(String validReleaseId) {
        Set<Id> validReleaseIds = new Set<Id>{validReleaseId};
        Database.executeBatch(new BatchProcessReleaseToShipment(validReleaseIds));
        return null;
    }
}