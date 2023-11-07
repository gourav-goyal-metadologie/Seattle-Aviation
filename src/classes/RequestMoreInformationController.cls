/**************************************************************************************************
Description: Controller class for requestMoreInformation LWCs
====================================================================================================
====================================================================================================
TestClass: 
Code Coverage: %
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		08/09/2021		    Vinod Kumar Sharma		        Initial Creation    
***************************************************************************************************/
public class RequestMoreInformationController {

    @AuraEnabled
    public static void saveRequestMoreInformationMessage(String customerExchangeSummaryId, String informationJSON){
        try {
            inscor__Customer_Exchange_Summary__c customerExchangeSummary = new inscor__Customer_Exchange_Summary__c(Id = customerExchangeSummaryId);
            customerExchangeSummary.Request_More_Information_JSON__c = informationJSON;
            update customerExchangeSummary;
            Customer_Exchange_Summary_Form_Response__c customerExchangeSummaryResponse = [SELECT Id, Locked__c 
                                                                                            FROM Customer_Exchange_Summary_Form_Response__c 
                                                                                            WHERE  Customer_Exchange_Summary__c = :customerExchangeSummaryId];
            customerExchangeSummaryResponse.Locked__c = false;
            update customerExchangeSummaryResponse;
            sendEmail(customerExchangeSummary.Id);
        } catch (Exception e) {
            System.debug('exception '+e);
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static inscor__Customer_Exchange_Summary__c getCustomerSummary(String customerExchangeSummaryId){
        try {
            return [SELECT inscor__Exchange_Status__c, inscor__Original_Core_Due_Date__c FROM inscor__Customer_Exchange_Summary__c
                                                            WHERE Id =:customerExchangeSummaryId];

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Boolean isCustomerExchangeFormResponseAvailable(String customerExchangeSummaryId){
        try {
            System.debug('recordId ->' + customerExchangeSummaryId);
            List<Customer_Exchange_Summary_Form_Response__c> customerExchangeSummaryResponse = [SELECT Id 
                                                                                        FROM Customer_Exchange_Summary_Form_Response__c 
                                                                                        WHERE  Customer_Exchange_Summary__c = :customerExchangeSummaryId ];
                                                                                        
            if (!customerExchangeSummaryResponse.isEmpty()) {
                return true;
            }else {
                return false;
            }
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    /**
     * @date : 08/09/2021
     */
    private static void sendEmail(Id customerExchangeSummaryId){
        List<inscor__Customer_Exchange_Summary__c> customerExchangeSummary =  new List<inscor__Customer_Exchange_Summary__c>
                                                                                    ([
                                                                                        SELECT 
                                                                                            Id,
                                                                                            inscor__Original_SO_ID__c, 
                                                                                            inscor__Original_SO_ID__r.inscor__Assigned_To__r.Email,
                                                                                            inscor__Original_SO_ID__r.inscor__Contact__r.Email
                                                                                        FROM inscor__Customer_Exchange_Summary__c
                                                                                        WHERE Id =: customerExchangeSummaryId
                                                                                    ]);
                
        if(customerExchangeSummary != NULL && !customerExchangeSummary.isEmpty()){
            Id emailTemplateId = [  SELECT Id FROM EmailTemplate 
                                    WHERE DeveloperName =: Constants.EMAIL_TEMPLATE_REQUEST_MORE_INFORMATION 
                                    LIMIT 1]?.Id;
            inscor__Customer_Exchange_Summary__c iceRec = customerExchangeSummary[0];
            if(emailTemplateId == NULL) 
            {
                LogService.createErrorLog('RequestMoreInformationController.cls', NULL, NULL, Constants.EMAIL_TEMPLATE_REQUEST_MORE_INFORMATION+ ' Email template does not exist.');
                return;
            }
            /* Assumption : Only one record will come because we have recordId Check in Query */
            Map<Id, List<String>> cseIdtoTOAddressMap = new Map<Id, List<String>>();
            Map<Id, List<String>> objIdtoCCAddress = new Map<Id, List<String>>();
            List<String> ccEmailAddresses = new List<String>{Label.Core_Exchange_Customer_CC_EmailAddress};
            if(!cseIdtoTOAddressMap.containsKey(iceRec.Id))
            { 
                cseIdtoTOAddressMap.put(iceRec.Id, new List<String>());
                objIdtoCCAddress.put(iceRec.Id, ccEmailAddresses);
                if(String.isNotBlank(iceRec.inscor__Original_SO_ID__c))
                {
                    if(iceRec.inscor__Original_SO_ID__r.inscor__Contact__r != NULL && iceRec.inscor__Original_SO_ID__r.inscor__Contact__r.Email != NULL)
                        cseIdtoTOAddressMap.get(iceRec.Id)
                            .add(iceRec.inscor__Original_SO_ID__r.inscor__Contact__r.Email);
                }
                cseIdtoTOAddressMap.get(iceRec.Id)
                            .add(System.Label.Customer_Support_Email);
            }
            //CommonUtility.sendEmail(emailTemplateId, cseIdtoTOAddressMap, NULL, NULL);
            CommonUtility.sendEmailForCustomerExchangeSummary(emailTemplateId, cseIdtoTOAddressMap, objIdtoCCAddress, NULL);
        }
    }
}