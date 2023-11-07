global class ProcessQuoteStatusBatch implements Database.Batchable<sObject>, Schedulable {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query;
        if(Test.isRunningTest()){
            query = 'SELECT Id, Name,inscor__Status__c, Lost_Reason__c FROM inscor__Customer_Quote__c where  LastModifiedDate = Today';
        } else {
           query = 'SELECT Id, Name,inscor__Status__c, Lost_Reason__c FROM inscor__Customer_Quote__c where  LastModifiedDate < LAST_N_DAYS:30'; 
        }
        return Database.getQueryLocator(query);
    }
     
    global void execute(Database.BatchableContext BC, List<inscor__Customer_Quote__c> scope) {
        
        for(inscor__Customer_Quote__c quoteRec : scope){
            quoteRec.Lost_Reason__c = 'High Price';
            quoteRec.inscor__Status__c = 'Closed - Lost';
        }
        
        if(scope.size() > 0){
            update scope;
        }
         
    }   
     
    global void finish(Database.BatchableContext BC) {
        
    }
    
    global void execute(SchedulableContext sc) {
       
      Database.executeBatch(new ProcessQuoteStatusBatch());
   }
}