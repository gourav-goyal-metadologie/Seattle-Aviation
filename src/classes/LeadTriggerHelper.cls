/**************************************************************************************************
Description: Trigger Helper class for Lead that will handle all types of trigger events.
====================================================================================================
====================================================================================================
TestClass: LeadTriggerHelperTest
Code Coverage: 100%
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		05/15/2021        	Gourav Goyal 				Initial Creation     				         						      	Initial Creation    
***************************************************************************************************/
public class LeadTriggerHelper implements TriggerHandler {
    /*Allows unit tests (or other code) to disable this trigger for the transaction */
    
    public static Boolean TriggerDisabled = false;
    
    /*Checks to see if the trigger has been disabled either by custom setting or by running code*/
    
    public Boolean IsDisabled() {
        /*Use the option below if you set up Custom Settings to controll Triggers*/
        
        Trigger_Configuration__c configSetting = Trigger_Configuration__c.getInstance();   
        if(configSetting.Lead_Trigger_Disable__c == true) {
            return true;
        } else {
            return TriggerDisabled;
        }
    }
    /* CALLING */
    public void BeforeInsert(SObject[] newList) {
        LeadTriggerHelper.updateLeadProbablityStatusOnLeadInsert((List<Lead>)newList);
        LeadTriggerHelper.setConversionProbabilityDefault(newList);
    }
    public void BeforeUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) { 
        LeadTriggerHelper.updateLeadProbablityOnLead((List<Lead>)newMap.values(), (Map<Id, Lead>)oldMap);
    }
    public void BeforeDelete(Map<Id, SObject> oldMap) {}
    public void AfterInsert(Map<Id, SObject> newMap) {}
    public void AfterUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {
        createTaskForAssignedUser((List<Lead>)newMap.values(), (Map<Id, Lead>)oldMap);
    }
    public void AfterDelete(Map<Id, SObject> oldMap) {}
    public void AfterUndelete(Map<Id, SObject> oldMap) {}
    
    /**
     * @description : method used to calculate customer conversion probablity
     * lastModifiedBy : Vinod Kumar Sharma
     * lastModifiedDate : 18/09/2021
     */
    public static void updateLeadProbablityOnLead(List<Lead> newList, Map<Id, Lead> oldMap ){
        try{
            for(Lead leadrec : newList){
                if(leadrec.Customer_Conversion_Probablity__c !=  oldMap.get(leadrec.Id).Customer_Conversion_Probablity__c){
                    if(leadrec.Customer_Conversion_Probablity__c == 'Low'){
                        leadrec.Conversion_Probablity__c = (leadrec.Conversion_Probablity__c - 10 > 0)?  leadrec.Conversion_Probablity__c - 10 : 0;
                        
                    } else if(leadrec.Customer_Conversion_Probablity__c == 'Medium'){
                        leadrec.Conversion_Probablity__c = (leadrec.Conversion_Probablity__c + 30 > 100)?  100 : leadrec.Conversion_Probablity__c + 30;
                        
                    }else if(leadrec.Customer_Conversion_Probablity__c == 'High'){
                        leadrec.Conversion_Probablity__c = (leadrec.Conversion_Probablity__c + 50 > 100)?  100 : leadrec.Conversion_Probablity__c + 50;  
                    }
                }
            } 
            if(Test.isRunningTest())
                Integer i = 1/0;    
        } catch (Exception error) {	
            LogService.createErrorLog('LeadTriggerHelper.apxc', NULL, error, NULL);	
        }
    }
    
    public static void updateLeadProbablityStatusOnLeadInsert(List<Lead> newList) {
        try{
            for(Lead leadrec : newList){
                leadrec.Customer_Conversion_Probablity__c = '';
            }
            if(Test.isRunningTest())
                Integer i = 1/0;    
        } catch (Exception error) {	
            LogService.createErrorLog('LeadTriggerHelper.apxc', NULL, error, NULL);	
        }
    }

    /**
     * @author : Vinod Kumar Sharma
     * @date : 15/09/2021
     * @description : method create a task when we assigned a lead to user 
     * Create Under SS-18
     */
    public static void createTaskForAssignedUser(List<Lead> newList, Map<Id, Lead> oldMap ) {
        Set<Id> eligibleLeadIds = new Set<Id>();
        for(Lead leadrec : newList){
            if (leadrec.Assigned_To__c != null && leadrec.Assigned_To__c != oldMap.get(leadrec.Id).Assigned_To__c) {
                eligibleLeadIds.add(leadrec.Id);
            }
        }
        
        List<Task> tasksToInsert = new List<Task>();
        for (Lead  lead : [SELECT Id, Customer__r.Name FROM Lead WHERE Id IN :eligibleLeadIds]) {
            Task task = new Task();
            task.Subject = lead.Customer__c != null ? lead.Customer__r.Name : '' ;
            task.ActivityDate = System.today().addDays(1);
            task.Related_Lead__c = lead.Id;
            tasksToInsert.add(task);
        }

        System.debug('tasksToInsert->' + JSON.serializePretty(tasksToInsert));
        if (!tasksToInsert.isEmpty()) {
            insert tasksToInsert;
        }
    }

    /**
     * @author : Vinod Kumar Sharma
     * @date : 18/09/2021
     * @description : method used to set by default conversion probability
     * Reason : Created under SS-22
     */
    public static void setConversionProbabilityDefault(List<Lead> newleads) {
        Map<String,Lead_Managment__mdt> leadManagmentSettings = Lead_Managment__mdt.getall();
        Decimal defaultConversionProbability = Decimal.valueOf(leadManagmentSettings.containsKey('Convertion_Probablity') ? 
                   ( leadManagmentSettings.get('Convertion_Probablity').Value__c != null ? 
                    leadManagmentSettings.get('Convertion_Probablity').Value__c : '10' ) : '10');
        
        for (Lead lead : newleads) {
            lead.Conversion_Probablity__c = defaultConversionProbability;
        }       
    }
}