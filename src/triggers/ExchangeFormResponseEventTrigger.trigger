/**************************************************************************************************
Description: Trigger used to handle Exchange_Form_Response__e platform event
====================================================================================================
====================================================================================================
TestClass: 
Code Coverage: %
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		10/04/2021		  Vinod Kumar Sharma		        Initial Creation
***************************************************************************************************/
trigger ExchangeFormResponseEventTrigger on Exchange_Form_Response__e (after insert) {
        if (Trigger.isAfter) {
            Set<Id> customerExchangeSummaryIds = new Set<Id>();
            for (Exchange_Form_Response__e formResponseEvent : Trigger.new) {
                customerExchangeSummaryIds.add(formResponseEvent.Exchange_Summary_Id__c);
            }
            
            updateCustomerExchangeSummaries(customerExchangeSummaryIds);
        }

        private static void updateCustomerExchangeSummaries( Set<Id> customerExchangeSummaryIds) {
            List<inscor__Customer_Exchange_Summary__c> summariesToUpdate = new List<inscor__Customer_Exchange_Summary__c>();
            for (Id customerExchangeSummaryId : customerExchangeSummaryIds) {
                inscor__Customer_Exchange_Summary__c summary = new inscor__Customer_Exchange_Summary__c(Id = customerExchangeSummaryId);
                summary.Is_Exchange_Form_Submmited__c = true;
                summary.Request_More_Information_JSON__c = null;
                summariesToUpdate.add(summary);
            }
            update summariesToUpdate;
        }
}