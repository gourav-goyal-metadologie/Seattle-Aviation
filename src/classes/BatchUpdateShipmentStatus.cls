global class BatchUpdateShipmentStatus implements Database.Batchable<sObject>,Database.AllowsCallouts,Schedulable {

    Public Set<Id> releaseIds;
    global BatchUpdateShipmentStatus(){
        releaseIds = new Set<Id>();
    }
    global BatchUpdateShipmentStatus(Set<Id> Ids){
        releaseIds = Ids;
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String complianceStatus = 'Upload Successful';
        String releaseStatus = 'Invoiced';
        String query = 'SELECT Id, Name '+
            			'FROM  inscor__Release__c '+
            			'WHERE inscor__Sales_Order__c != null AND Compliance_Status__c = :complianceStatus '+
            			'AND International_Transaction_Number__c = NULL AND inscor__Status__c != :releaseStatus';
        
        if(releaseIds.size() > 0){
            query += ' AND Id IN: releaseIds';
        }
        //system.assert(false,query);
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<inscor__Release__c> releases){
        ReleaseToShipmentAPIService.checkShipmentStatus(releases);
    }
    
    global void finish(Database.BatchableContext bc){
        
    }
    
    global void execute(SchedulableContext sc) {
    	Database.executeBatch(new BatchUpdateShipmentStatus(), 20);
    }

}