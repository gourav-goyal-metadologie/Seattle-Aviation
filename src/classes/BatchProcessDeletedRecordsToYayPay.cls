global class BatchProcessDeletedRecordsToYayPay implements Database.Batchable<sObject>,Database.AllowsCallouts,Database.Stateful, Schedulable {
    
    Public Set<Id> deletedRecordObjIds;
    Public DateTime TokenGenerateTime;
    Public DateTime TokenExpiaryTime;
    Public String accessToken;
    Public Integer tokenGenerateCount =0 ;
    Public String transactionId;
    Public List<Deleted_Record__c> deletedRecordsToUpdate;
    global BatchProcessDeletedRecordsToYayPay(){
        deletedRecordObjIds = new Set<Id>();
        deletedRecordsToUpdate = new list<Deleted_Record__c>();
    }
    global BatchProcessDeletedRecordsToYayPay(Set<Id> Ids){
        deletedRecordObjIds = Ids;
        deletedRecordsToUpdate = new list<Deleted_Record__c>();
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id, Object_Type__c, YayPay_Last_Sync_Date__c, Is_Processed__c, '+
            ' Is_Error__c, Deleted_Record_Id__c ' +
            ' FROM Deleted_Record__c ' +
            ' WHERE Id != null';
        
        if(deletedRecordObjIds.size() > 0){
            query += ' AND Id IN: receiptIds';
        }else{
            query += ' AND Is_Processed__c = FALSE ';
        }
        
        query += ' ORDER By Is_Error__c ASC,LastModifiedDate DESC LIMIT 10 ALL ROWS ';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Deleted_Record__c> delRecords ){
        
        if( !YayPayUtility.sendYayPayCallout() ){
            return;
        }
        Deleted_Record__c delRecordObj = delRecords.get(0);
        
        list<AcctSeed__Cash_Receipt__c> receiptList = new list<AcctSeed__Cash_Receipt__c>(); 

        if( TokenExpiaryTime == null || TokenExpiaryTime < System.now() ){
            //get Access Token for Request API.
            accessToken = YayPayAuthentication.getAccessToken(); 
            TokenExpiaryTime = System.now().addMinutes(50);
            //starting transaction.
            transactionId = YayPayTransactionAPIService.startTransaction( accessToken );
        }
        
        YayPayAPIService.deleteRecordsFromYayPay( New List<String>{ delRecordObj.Deleted_Record_Id__c }, delRecordObj.Object_Type__c , accessToken, transactionId );
        delRecordObj.Is_Processed__c = TRUE;
        delRecordObj.YayPay_Last_Sync_Date__c = System.now();
        deletedRecordsToUpdate.add( delRecordObj );
    }
    global void execute(SchedulableContext sc) {
        Database.executeBatch(new BatchProcessDeletedRecordsToYayPay(), 1 );
    }
    
    global void finish(Database.BatchableContext bc){
        try{
            //Finish transaction.
            Integer transactionFinishCode = YayPayTransactionAPIService.finishTransaction( accessToken, transactionId ); 
            update deletedRecordsToUpdate;
        }catch( exception error ){
            LogService.createErrorLog('BatchProcessDeletedRecordsToYayPay.finish', NULL, error, NULL);
        }
    }
}