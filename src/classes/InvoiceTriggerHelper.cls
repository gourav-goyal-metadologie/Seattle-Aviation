/**************************************************************************************************
Description: Trigger Helper class for InvoiceTrigger that will handle all types of trigger events.
====================================================================================================
====================================================================================================
TestClass: 
Code Coverage: 
====================================================================================================
====================================================================================================
History
<Version>       <Date>             <Author Name>                <Brief description of change > 
1.0 -           06/02/2021          Gourav Goyal                Initial Creation    
***************************************************************************************************/
public class InvoiceTriggerHelper implements TriggerHandler {
    
    /*Allows unit tests (or other code) to disable this trigger for the transaction */
    
    public static Boolean TriggerDisabled = false;
    
    /*Checks to see if the trigger has been disabled either by custom setting or by running code*/
    
    public Boolean IsDisabled() {
        /*Use the option below if you set up Custom Settings to controll Triggers*/
        Trigger_Configuration__c configSetting = Trigger_Configuration__c.getInstance();   
        if(configSetting.Invoice_Trigger_Disable__c == true) {
            return true;
        } else {
            return TriggerDisabled;
        }
    }

    
    /* CALLING */
    public void BeforeInsert(SObject[] newList) {
        resetYayPayInvoiceField( (List<inscor__Invoice__c>)newList  );
    }
    
    public void BeforeUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {
       resetYayPayInvoiceField( (List<inscor__Invoice__c>)newMap.values()  );
    }
    
    public void BeforeDelete(Map<Id, SObject> oldMap) {}
    
    public void AfterInsert(Map<Id, SObject> newMap) {
        InvoiceTriggerHelper.updateCustomerScoreOnAccount((List<inscor__Invoice__c>)newMap.values(), null);
    }
    
    public void AfterUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {
        InvoiceTriggerHelper.updateCustomerScoreOnAccount((List<inscor__Invoice__c>)newMap.values(), (Map<Id, inscor__Invoice__c>) oldMap);
    }
    
    public void AfterDelete(Map<Id, SObject> oldMap) {
        InvoiceTriggerHelper.updateCustomerScoreOnAccount((List<inscor__Invoice__c>)oldMap.values(), null);
    }
    
    public void AfterUndelete(Map<Id, SObject> oldMap) {
    }
    
    public static void resetYayPayInvoiceField( List<inscor__Invoice__c> newList ){
       
        if( System.isBatch() ){
            return;
        }
        List<inscor__Invoice__c> filteredInvoiceList = new List<inscor__Invoice__c>();
        set<Id> accountIds = new set<Id>();
        
        try {
            //reset Fields.
            for(inscor__Invoice__c inv : newList){
                inv.Is_Error__c = FALSE;
                inv.Is_Processed__c = FALSE;
            }
            if(Test.isRunningTest())
                Integer i = 1/0; 
        }catch (Exception error) {  
            LogService.createErrorLog('InvoiceTriggerHandler.apxc', NULL, error, NULL); 
        }    
    }

    public static Set<String> getAccountIds(List<inscor__Invoice__c> invoices) {
        Set<String> accountIds = new Set<String>();        
        for(inscor__Invoice__c invRec : invoices){
            accountIds.add(invRec.inscor__Account__c);
        }
        accountIds.remove(null);
        return accountIds;
    }

    public static void updateCustomerScoreOnAccount(List<inscor__Invoice__c> invoices, Map<Id, inscor__Invoice__c> oldMap) {
        try {
            Set<String> accountIds = new Set<String>();
            if (oldMap != null) {
                for (inscor__Invoice__c invoice : invoices) {
                    if (invoice.inscor__Margin_Percent__c != oldMap.get(invoice.Id).inscor__Margin_Percent__c) {
                        accountIds.add(invoice.inscor__Account__c);
                    }
                }
            }else {
                for (inscor__Invoice__c invoice : invoices) {
                    accountIds.add(invoice.inscor__Account__c);
                }
            }
            if (!accountIds.isEmpty()) {
                AccountUtility.updateCustomeMargin(accountIds);
            }
        } catch (Exception error) {
            System.debug('error:' + error.getMessage());
            LogService.createErrorLog('InvoiceTriggerHelper.apxc', NULL, error, NULL);
        }
    }
}