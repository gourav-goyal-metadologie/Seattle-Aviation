/**************************************************************************************************
Description: Trigger class for inscor__Sales_Order_Line__c that will handle all types of trigger events.
====================================================================================================
====================================================================================================
TestClass: SalesOrderLineItemTriggerHelperTest
Code Coverage: 100%
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		05/20/2021		    Gourav Goyal				Initial Creation     
***************************************************************************************************/
public class SalesOrderLineItemTriggerHelper implements TriggerHandler {
    
    /*Allows unit tests (or other code) to disable this trigger for the transaction */
    
    public static Boolean TriggerDisabled = false;
    
    Public static Set<String> statusToInclude = new Set<String>{'In Progress', 'Sent to Customer'};
        
        /*Checks to see if the trigger has been disabled either by custom setting or by running code*/
        
        public Boolean IsDisabled() {
            /*Use the option below if you set up Custom Settings to controll Triggers*/
            Trigger_Configuration__c configSetting = Trigger_Configuration__c.getInstance();   
            if(configSetting.Sales_Order_Line_Trigger_Disable__c == true) {
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
        SalesOrderLineItemTriggerHelper.updateCustomerScoreOnAccount((List<inscor__Sales_Order_Line__c>)newMap.values(), null);
    }
    
    public void AfterUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {
        SalesOrderLineItemTriggerHelper.updateCustomerScoreOnAccount((List<inscor__Sales_Order_Line__c>)newMap.values(), (Map<Id, inscor__Sales_Order_Line__c>) oldMap);
    }
    
    public void AfterDelete(Map<Id, SObject> oldMap) {
        SalesOrderLineItemTriggerHelper.updateCustomerScoreOnAccount((List<inscor__Sales_Order_Line__c>)oldMap.values(), null);
    }
    
    public void AfterUndelete(Map<Id, SObject> oldMap) {}

    public static void updateCustomerScoreOnAccount(List<inscor__Sales_Order_Line__c> salesOrderLines, Map<Id, inscor__Sales_Order_Line__c> oldMap) {
        try {  
            Set<String> salesOrderIds = new Set<String>();
            if (oldMap != null) {
                for (inscor__Sales_Order_Line__c orderLine : salesOrderLines) {
                    if (orderLine.inscor__Quantity_Ordered__c != oldMap.get(orderLine.Id).inscor__Quantity_Ordered__c
                        || orderLine.inscor__Line_Total__c != oldMap.get(orderLine.Id).inscor__Line_Total__c) {
                            salesOrderIds.add(orderLine.inscor__Order__c);
                    }
                }
            }else {
                for (inscor__Sales_Order_Line__c orderLine : salesOrderLines) {
                    salesOrderIds.add(orderLine.inscor__Order__c);
                }
            }
            if (!salesOrderIds.isEmpty()) {
                Set<String> accountIds = new Set<String>();      
                Set<String> customerQuoteIds = new Set<String>();      
                for(inscor__Sales_Order__c soRec : [SELECT inscor__Customer__c, inscor__Quote_Number__c  FROM inscor__Sales_Order__c WHERE Id IN :salesOrderIds]){
                    accountIds.add(soRec.inscor__Customer__c);
                    customerQuoteIds.add(soRec.inscor__Quote_Number__c);
                }
                AccountUtility.updateCustomerSalesOrderValues(accountIds);
                System.debug('customerQuoteIds ->' + customerQuoteIds);
                //OpportunityUtility.calculateOpportunityProbablity(accountIds);
            }
        } catch (Exception error) {
            System.debug('error:' + error.getMessage());
            LogService.createErrorLog('SalesOrderLineItemTriggerHelper.apxc', NULL, error, NULL);
        }
    }
}