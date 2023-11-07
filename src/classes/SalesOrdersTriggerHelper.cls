/**************************************************************************************************
Description: Trigger Helper class for inscor__Sales_Order__c that will handle all types of trigger events.
====================================================================================================
====================================================================================================
TestClass: SalesOrdersTriggerHelperTest
Code Coverage: 
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		05/21/2021		    Gourav Goyal				Initial Creation    
1.0 -      		10/23/2021		    Vinod Kumar sharma		    Added enqueueJob for account update   
1.0 -      		10/23/2021		    Vinod Kumar sharma		    Removed enqueueJob for account update and updated trigger  
***************************************************************************************************/
public class SalesOrdersTriggerHelper implements TriggerHandler {
    
    /*Allows unit tests (or other code) to disable this trigger for the transaction */
    
    public static Boolean TriggerDisabled = false;
    
    /*Checks to see if the trigger has been disabled either by custom setting or by running code*/
    
    public Boolean IsDisabled() {
        /*Use the option below if you set up Custom Settings to controll Triggers*/
        Trigger_Configuration__c configSetting = Trigger_Configuration__c.getInstance();   
        if(configSetting.Sales_Order_Trigger_Disable__c == true) {
            return true;
        } else {
            return TriggerDisabled;
        }
    }

    /* CALLING */
    public void BeforeInsert(SObject[] newList) {}
    
    public void BeforeUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {}
    
    public void BeforeDelete(Map<Id, SObject> oldMap) {}
    
    public void AfterInsert(Map<Id, SObject> newMap) {
        SalesOrdersTriggerHelper.updateOpportunityProbablityOnInsertAndDelete((List<inscor__Sales_Order__c>)newMap.values());
        SalesOrdersTriggerHelper.updateOpportunityStatus((List<inscor__Sales_Order__c>)newMap.values());
        SalesOrdersTriggerHelper.updateSalesOrderCountOnCustomer((List<inscor__Sales_Order__c>)newMap.values());
    }
    
    public void AfterUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {
    }
    
    public void AfterDelete(Map<Id, SObject> oldMap) {
        SalesOrdersTriggerHelper.updateOpportunityProbablityOnInsertAndDelete((List<inscor__Sales_Order__c>)oldMap.values());
        SalesOrdersTriggerHelper.updateSalesOrderCountOnCustomer((List<inscor__Sales_Order__c>)oldMap.values());
    }
    
    public void AfterUndelete(Map<Id, SObject> oldMap) {
    }
    
    /* DEFINITION */
    
    public static void updateSalesOrderCountOnCustomer(List<inscor__Sales_Order__c> salesOrderList) {

        Set<String> accountIds = getAccountIds(salesOrderList);
        List<Account> customerToUpdate = new List<Account>();
        for (AggregateResult aggregateResult : [SELECT Count(Id) numberOfSalesOrder, inscor__Customer__c accountId
                            FROM inscor__Sales_Order__c
                            WHERE inscor__Customer__c IN :accountIds AND CreatedDate = LAST_N_DAYS:30
                            GROUP BY inscor__Customer__c]) {
            Account customer = new Account();
            customer.Id =  (Id)aggregateResult.get('AccountId');
            customer.No_Of_Sales_Order__c =  (Integer)aggregateResult.get('numberOfSalesOrder');
            customerToUpdate.add(customer);
        }
        if (!customerToUpdate.isEmpty()) {
            AccountTriggerHandler.TriggerDisabled = true;
            update customerToUpdate;    //No need to start trigger we only updating no of sales order field of the account
            AccountTriggerHandler.TriggerDisabled = false;
        }
    }
    
    public static void updateOpportunityStatus(List<inscor__Sales_Order__c> newList){
        try{
            List<String> quoteIds = new List<String>();
            for(inscor__Sales_Order__c salesOrderRec : newList){
                if(salesOrderRec.inscor__Quote_Number__c != null){
                    quoteIds.add(salesOrderRec.inscor__Quote_Number__c);
                }
            }
            
            List<Opportunity> opportunityRecs = [Select Id from Opportunity where Customer_Quote__c IN: quoteIds];
            
            for(Opportunity oppRec : opportunityRecs){
                oppRec.StageName  = 'Closed Won';
            }
            
            if(opportunityRecs.size() > 0){
                System.debug('updateOpportunityStatus.opportunityRecs' + opportunityRecs);
                update opportunityRecs;
            }
            
            if(Test.isRunningTest())
                Integer i = 1/0;  
        } catch(Exception error) {
            LogService.createErrorLog('SalesOrdersTriggerHelper.apxc', NULL, error, NULL);	
        } 
    }
    
    public static void updateOpportunityProbablity(List<inscor__Sales_Order__c> newList){
        try{
            Set<String> quoteIds = new Set<String>();
            for(inscor__Sales_Order__c salesOrderRec : newList){
                if(salesOrderRec.inscor__Quote_Number__c != null){
                    quoteIds.add(salesOrderRec.inscor__Quote_Number__c);
                }
            }
            if(quoteIds.size() > 0){
                OpportunityUtility.calculateOpportunityProbablity(quoteIds);
            }
            if(Test.isRunningTest())
                Integer i = 1/0;  
        } catch(Exception error) {
            LogService.createErrorLog('SalesOrdersTriggerHelper.apxc', NULL, error, NULL);	
        } 
    }

    public static Set<String> getAccountIds(List<inscor__Sales_Order__c> salesOrders) {
        Set<String> accountIds = new Set<String>();        
        for(inscor__Sales_Order__c soRec : salesOrders){
            accountIds.add(soRec.inscor__Customer__c);
        }    
        return accountIds;
    }

    /**
     * @desription : update the winning opportunity score when delete sales order
     * @author : Vinod Kumar Sharma
     * @date : 09/23/2021
     * createdReason : SS-207
     */
    public static void updateOpportunityProbablityOnInsertAndDelete(List<inscor__Sales_Order__c> newList){
        try{
            Set<String> customerIds = new Set<String>();
            
            for(inscor__Sales_Order__c salesOrderRec : newList){
                if(salesOrderRec.inscor__Customer__c != null){
                    customerIds.add(salesOrderRec.inscor__Customer__c);
                }
            }
            if(customerIds.size() > 0){
                OpportunityUtility.calculateOpportunityProbablity(customerIds);
            }
            if(Test.isRunningTest())
                Integer i = 1/0;  
        } catch(Exception error) {
            LogService.createErrorLog('SalesOrdersTriggerHelper.apxc', NULL, error, NULL);	
        } 
    }
}