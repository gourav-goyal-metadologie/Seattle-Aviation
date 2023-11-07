/**************************************************************************************************
Description: Trigger Helper class for inscor__Customer_Quote_Line__c that will handle all types of trigger events.
====================================================================================================
====================================================================================================
TestClass: CustomerQuoteLineTriggerHelperTest
Code Coverage: 100%
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		05/22/2021		    Gourav Goyal				Initial Creation    
2.0 -      		10/28/2021		    Vinod Kumar Sharma		    Removed unUsed methods and Added method updateCustomerScoreOnAccount
***************************************************************************************************/
public class CustomerQuoteLineTriggerHelper implements TriggerHandler {
    
    /*Allows unit tests (or other code) to disable this trigger for the transaction */
    
    public static Boolean TriggerDisabled = false;
        
    public Boolean IsDisabled() {
        /*Use the option below if you set up Custom Settings to controll Triggers*/
        Trigger_Configuration__c configSetting = Trigger_Configuration__c.getInstance();   
        if(configSetting.Customer_Quote_Line_Trigger_Disable__c == true) {
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
        CustomerQuoteLineTriggerHelper.updateCustomerScoreOnAccount((List<inscor__Customer_Quote_Line__c>)newMap.values(), null);
    }
    
    public void AfterUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {
        CustomerQuoteLineTriggerHelper.updateCustomerScoreOnAccount((List<inscor__Customer_Quote_Line__c>)newMap.values(), (Map<Id, inscor__Customer_Quote_Line__c>) oldMap);
    }
    
    public void AfterDelete(Map<Id, SObject> oldMap) {
        CustomerQuoteLineTriggerHelper.updateCustomerScoreOnAccount((List<inscor__Customer_Quote_Line__c>)oldMap.values(), null);
     }
    
    public void AfterUndelete(Map<Id, SObject> oldMap) {}

    public static void updateCustomerScoreOnAccount(List<inscor__Customer_Quote_Line__c> customerQuoteLines, Map<Id, inscor__Customer_Quote_Line__c> oldMap) {
        try {
            Set<String> customerQuoteIds = new Set<String>();
            if (oldMap != null) {
                for (inscor__Customer_Quote_Line__c orderLine : customerQuoteLines) {
                    if (orderLine.inscor__Quantity__c != oldMap.get(orderLine.Id).inscor__Quantity__c) {
                            customerQuoteIds.add(orderLine.inscor__Customer_Quote__c);
                    }
                }
            }else {
                for (inscor__Customer_Quote_Line__c orderLine : customerQuoteLines) {
                    customerQuoteIds.add(orderLine.inscor__Customer_Quote__c);
                }
            }
            if (!customerQuoteIds.isEmpty()) {
                Set<String> accountIds = new Set<String>();        
                for(inscor__Customer_Quote__c customerQuote : [SELECT inscor__Customer__c FROM inscor__Customer_Quote__c WHERE Id IN :customerQuoteIds]){
                    accountIds.add(customerQuote.inscor__Customer__c);
                }
                AccountUtility.updateCustomerQuoteOrderLineCount(accountIds);
                OpportunityUtility.calculateOpportunityProbablity(accountIds);
            }
        } catch (Exception error) {
            System.debug('error:' + error.getMessage());
            LogService.createErrorLog('CustomerQuoteLineTriggerHelper.apxc', NULL, error, NULL);
        }
    }
}