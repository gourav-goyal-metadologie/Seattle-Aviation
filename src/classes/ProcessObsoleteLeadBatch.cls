global class ProcessObsoleteLeadBatch implements Database.Batchable<sObject>, Schedulable {
    global static Map<String,Lead_Managment__mdt> leadManagmentSettings = new Map<String,Lead_Managment__mdt>();
    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        String query = 'Select id,Name,OwnerId,(Select Name,Id from inscor__Customer_Quotes__r),(Select Id from inscor__Sales_Orders__r),(Select Id from Leads__r) from Account';
        return Database.getQueryLocator(query);
    }
     
    global void execute(Database.BatchableContext BC, List<Account> scope) {
        if(leadManagmentSettings.size()  == 0){
             leadManagmentSettings = Lead_Managment__mdt.getall();
        }
        List<Lead> leadRecToInsert = new List<Lead>();
        for(Account accRec : scope){
            if(accRec.Leads__r.size() == 0 && accRec.inscor__Sales_Orders__r.size() == 0
               && accRec.inscor__Customer_Quotes__r.size() > 50 ){
                   leadRecToInsert.add(createLeadRecord(accRec));
               }
        }
        
        if(leadRecToInsert.size() > 0){
            insert leadRecToInsert;
        }
         
    }   
     
    global void finish(Database.BatchableContext BC) {
        
    }
    
    global void execute(SchedulableContext sc) {
       
      Database.executeBatch(new ProcessObsoleteLeadBatch());
   }
    
    private static Lead createLeadRecord(Account acc){
        Lead leadRec = new Lead();
        leadRec.LastName = acc.Name;
        leadRec.Company = acc.Name;
        leadRec.Customer__c = acc.id;
        leadRec.Status =  leadManagmentSettings.containsKey('Lead_Status') ? 
                    leadManagmentSettings.get('Lead_Status').Value__C : 'New';
        leadRec.ownerId = leadManagmentSettings.containsKey('Lead_OwnerId') ? 
                   ( leadManagmentSettings.get('Lead_OwnerId').Value__c != null ? 
                    leadManagmentSettings.get('Lead_OwnerId').Value__c : acc.ownerId) : acc.ownerId;
        return leadRec;        
    } 
}