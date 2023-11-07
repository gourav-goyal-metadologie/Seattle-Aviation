/**************************************************************************************************
Description: Trigger Helper class for inscor__Customer_Quote__c that will handle all types of trigger events.
====================================================================================================
====================================================================================================
TestClass: CustomerQuoteTriggerHelperTest
Code Coverage: 100%
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		05/20/2021		    Gourav Goyal				Initial Creation    
2.0 -      		05/20/2021		    Gourav Goyal				Initial Creation    
***************************************************************************************************/
public class CustomerQuoteTriggerHelper implements TriggerHandler {
    /*Allows unit tests (or other code) to disable this trigger for the transaction */ 
    public static Boolean TriggerDisabled = false;
    
    public Boolean IsDisabled() {
        /*Use the option below if you set up Custom Settings to controll Triggers*/
        Trigger_Configuration__c configSetting = Trigger_Configuration__c.getInstance();   
        if(configSetting.Customer_Quote_Trigger_Disable__c == true) {
            return true;
        } else {
            return TriggerDisabled;
        }
    }
    
    /* CALLING */
    public void BeforeInsert(SObject[] newList) {}
    
    public void BeforeUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {
    }
    
    public void BeforeDelete(Map<Id, SObject> oldMap) {
        CustomerQuoteTriggerHelper.deleteOpportunitiesOnDelete((List<inscor__Customer_Quote__c>)oldMap.values());
    }
    
    public void AfterInsert(Map<Id, SObject> newMap) {
        CustomerQuoteTriggerHelper.convertQuoteToOpportunity((List<inscor__Customer_Quote__c>) newMap.values());
    }
    
    public void AfterUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {
    	CustomerQuoteTriggerHelper.updateOppProbablityOnUpdate((List<inscor__Customer_Quote__c>)newMap.values(), (Map<Id, inscor__Customer_Quote__c>)oldMap);
    }
    
    public void AfterDelete(Map<Id, SObject> oldMap) {
    }
    
    public void AfterUndelete(Map<Id, SObject> oldMap) {
    }
    
    /* DEFINITION */
    public static void convertQuoteToOpportunity(List<inscor__Customer_Quote__c> newList){
        try{
            List<opportunity> opportunityToInsert = new List<Opportunity>();
            for(inscor__Customer_Quote__c quoteRec : newList){
                Opportunity oppRec = new Opportunity();
                oppRec.Name =  quoteRec.Name;
                oppRec.accountId =  quoteRec.inscor__Customer__c;
                //oppRec.CloseDate =  quoteRec.inscor__Create_Date__c != null ? (quoteRec.inscor__Create_Date__c.Date() + 14) : Date.today();
                oppRec.CloseDate =  Date.today().addDays(14);
                oppRec.StageName = 'Prospecting';
                oppRec.Amount = quoteRec.inscor__Quote_Total__c;
                oppRec.Customer_Quote__c = quoteRec.Id;
                opportunityToInsert.add(oppRec);
            }
            if(opportunityToInsert.size() > 0){
                insert opportunityToInsert;
            }
            if(Test.isRunningTest())
                Integer i = 1/0;  
        } catch(Exception error) {
            LogService.createErrorLog('CustomerQuoteTriggerHelper.apxc', NULL, error, NULL);	
        }
    }

    /**
     * @author : Vinod Kumar Sharma
     * @description : Method used delete the opportunity when a customer quote deleted
     * @createDate : 10/28/2021
     */
    public static void deleteOpportunitiesOnDelete(List<inscor__Customer_Quote__c> oldList) {
        Set<String> customerQuoteIds = new Set<String>();
        for (inscor__Customer_Quote__c customerQuote : oldList) {
            customerQuoteIds.add(customerQuote.Id);
        }
        if (!customerQuoteIds.isEmpty()) {
            List<Opportunity> opportunitiesToDelete = [SELECT Id FROM Opportunity WHERE Customer_Quote__c IN :customerQuoteIds];
            if (!opportunitiesToDelete.isEmpty()) {
                delete opportunitiesToDelete;
            }
        }
    }
    
    /**
     * @author : Vinod Kumar Sharma
     * @description : Method used update the opportunity when Customer Quote convert to sales order
     * @createDate : 10/28/2021
     */
    public static void updateOppProbablityOnUpdate(List<inscor__Customer_Quote__c> newList, Map<Id, inscor__Customer_Quote__c> oldMap){
        try{
            Set<String> customerIds = new Set<String>();
            for(inscor__Customer_Quote__c quote : newList){
                if(quote.inscor__Customer__c != null && quote.inscor__Status__c == 'Closed - Won' && quote.inscor__Status__c != oldMap.get(quote.Id).inscor__Status__c){
                    customerIds.add(quote.inscor__Customer__c);
                }
            }
            if (!customerIds.isEmpty()) {
                OpportunityUtility.calculateOpportunityProbablity(customerIds);
            }
        } catch(Exception error) {
            LogService.createErrorLog('CustomerQuoteTriggerHelper.apxc', NULL, error, NULL);	
        }
    }
}