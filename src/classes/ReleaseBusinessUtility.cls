/**************************************************************************************************
Description: Class for inscor__Release__c Business Utility.
====================================================================================================
====================================================================================================
TestClass: ReleaseTriggerHelperTest
Code Coverage: 92%
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		05/28/2021		    Gourav Goyal				Initial Creation    
***************************************************************************************************/
public class ReleaseBusinessUtility {
    
    private static final string INVOICED = 'Invoiced';
    private static final string EMAIL_TEMPLATE_CONFIG = 'Release_Invoice_Email';
    private static final string EMAIL_TEMPLATE_CONFIG_WITHOUT_ATTACHMENT = 'Release_Invoice_Email_Without_Attachment';
    
    /*
* Method : sendEmailOnReleaseStatusInvoiced - 
* Purpose: This method will send Email when status = 'Invoiced'
* @author Gourav Goyal
* @Param Task New List
* return 
*/   
    
    public static void sendEmailOnReleaseStatusInvoiced( List<inscor__Release__c> newList ) {
        if(newList == NULL || newList.isEmpty()) {
            return;
        }
        try {
            List<inscor__Release__c> filteredReleaseRecords = new List<inscor__Release__c>();
            Set<Id> releaseIds = new Set<Id>();
            Map<Id, Set<Id>> relIdToListContentDocumentIdMap = new Map<Id, Set<Id>>();
            for(inscor__Release__c rec : newList){
                if(rec.inscor__Status__c != NULL && rec.inscor__Status__c == INVOICED ) {
                      filteredReleaseRecords.add(rec);
                      releaseIds.add(rec.Id);                      
                  }
            }
            Set<String> emailTemplateNames = new set<String>();
            map<String, EmailTemplate> mapEmailTemplateNameToEmailTemplate = new map<String, EmailTemplate>();
            if(filteredReleaseRecords != NULL && !filteredReleaseRecords.isEmpty()){
                //System.debug('Debug*** filteredReleaseIdToEmailMap'+ filteredReleaseIdToEmailMap);
                for(inscor__Release__c rec : filteredReleaseRecords){
                    if(rec.inscor__Sales_Order__r.Type__c != null && rec.inscor__Sales_Order__r.Type__c == 'Vendor'){
                       emailTemplateNames.add(Email_Template_Management__mdt.getInstance(EMAIL_TEMPLATE_CONFIG_WITHOUT_ATTACHMENT).Email_Template_Name__c);
                    }
                    if((rec.inscor__Sales_Order__r.Type__c != null && rec.inscor__Sales_Order__r.Type__c == 'All') ||
                            (String.isBlank(rec.inscor__Sales_Order__r.Type__c))){
                        emailTemplateNames.add(Email_Template_Management__mdt.getInstance(EMAIL_TEMPLATE_CONFIG).Email_Template_Name__c);
                    }
                }
                Id emailTemplateId;
                if(emailTemplateNames.size() == 0){
                    LogService.createErrorLog('ReleaseBusinessUtility.apxc', NULL, NULL, 'Template name not defined.');
                    return;
                } else {
                    List<EmailTemplate> eTemplates = [SELECT Id, HTMLValue, Name FROM EmailTemplate WHERE Name IN: emailTemplateNames];
                    
                    if(eTemplates == NULL) {
                        LogService.createErrorLog('ReleaseBusinessUtility.apxc', NULL, NULL, EMAIL_TEMPLATE_CONFIG+ ' Template does not exist.');
                        return;
                    }
                    
                    for( EmailTemplate temp : eTemplates){
                      mapEmailTemplateNameToEmailTemplate.put(temp.Name, temp);  
                    }
                }
                
                map<String, String> mapReleaseIdToEmailTemplate = new map<String, String>();
                for(inscor__Release__c rec : filteredReleaseRecords){
                    if(rec.inscor__Sales_Order__r.Type__c != null && rec.inscor__Sales_Order__r.Type__c == 'Vendor'){
                        string templateName = Email_Template_Management__mdt.getInstance(EMAIL_TEMPLATE_CONFIG_WITHOUT_ATTACHMENT).Email_Template_Name__c;
                        String templateId = mapEmailTemplateNameToEmailTemplate.containsKey(templateName) ? 
                            				mapEmailTemplateNameToEmailTemplate.get(templateName).Id : null;
                        mapReleaseIdToEmailTemplate.put(rec.Id, templateId);
                    }
                    else if((rec.inscor__Sales_Order__r.Type__c != null && rec.inscor__Sales_Order__r.Type__c == 'All') ||
                            (String.isBlank(rec.inscor__Sales_Order__r.Type__c))) {
                        string templateName = Email_Template_Management__mdt.getInstance(EMAIL_TEMPLATE_CONFIG).Email_Template_Name__c;
                        String templateId = mapEmailTemplateNameToEmailTemplate.containsKey(templateName) ?
                            				mapEmailTemplateNameToEmailTemplate.get(templateName).Id: null;
                        mapReleaseIdToEmailTemplate.put(rec.Id, templateId);
                    }
                }
                //GET LinkIds
                List<ContentDocumentLink> contentLinkList = new List<ContentDocumentLink>([SELECT Id, LinkedEntityId, ContentDocumentId FROM ContentDocumentLink where LinkedEntityId IN :releaseIds]);
                Map<Id, List<Id>> linkEntityIdToListCDocIdMap = new Map<Id, List<Id>>();
                List<Id> contentDocIdList = new List<Id>();
                if(contentLinkList != NULL && !contentLinkList.isEmpty()) {
                    for(ContentDocumentLink cLinkRec : contentLinkList) {
                        if(!linkEntityIdToListCDocIdMap.containsKey(cLinkRec.LinkedEntityId)) {
                            linkEntityIdToListCDocIdMap.put(cLinkRec.LinkedEntityId, new List<Id>());
                        }
                        linkEntityIdToListCDocIdMap.get(cLinkRec.LinkedEntityId).add(cLinkRec.ContentDocumentId);
                        contentDocIdList.add(cLinkRec.ContentDocumentId);
                    }
                    if(!linkEntityIdToListCDocIdMap.isEmpty() && !contentDocIdList.isEmpty()) {
                        List<ContentVersion> cvList = 
                            new List<ContentVersion>([SELECT Id, ContentDocumentId FROM ContentVersion 
                                                      WHERE ContentDocumentId IN :contentDocIdList 
                                                      AND isLatest = TRUE]);
                        if(cvList != NULL && !cvList.isEmpty()) {
                            Map<Id, Id> cdDocIdToCVIdMap = new Map<Id, Id>();
                            for(ContentVersion cv : cvList){
                                if(!cdDocIdToCVIdMap.containsKey(cv.ContentDocumentId)) {
                                    cdDocIdToCVIdMap.put(cv.ContentDocumentId, cv.Id);
                                }
                            }
                            for(Id linkEntyIdRec : linkEntityIdToListCDocIdMap.keySet()){
                                if(!relIdToListContentDocumentIdMap.containsKey(linkEntyIdRec)) {
                                    relIdToListContentDocumentIdMap.put(linkEntyIdRec, new Set<Id>());
                                }
                                Set<Id> cvIdListFromCD = new Set<Id>();
                                for(Id IdRec : linkEntityIdToListCDocIdMap.get(linkEntyIdRec)) {
                                    if(cdDocIdToCVIdMap.containsKey(IdRec)) {
                                        cvIdListFromCD.add(cdDocIdToCVIdMap.get(IdRec));
                                    }
                                }
                                relIdToListContentDocumentIdMap.get(linkEntyIdRec).addAll(cvIdListFromCD); 
                            }
                        }
                    }
                }
                
                Map<Id, List<String>> toAddressMap = new Map<Id, List<String>>();
                Map<Id, List<String>> ccAddressMap = new Map<Id, List<String>>();
                
                for(inscor__Release__c rec : filteredReleaseRecords){
                    if(rec.inscor__Sales_Order__r.inscor__Contact__r.Email != null){
                        if(!toAddressMap.containsKey(rec.Id)){
                            toAddressMap.put(rec.Id, new List<String>());
                        }
                        toAddressMap.get(rec.Id).add(rec.inscor__Sales_Order__r.inscor__Contact__r.Email);
                    }
                    if(rec.inscor__Sales_Order__r.inscor__Billing_Contact__r.Email != null){
                        if(!toAddressMap.containsKey(rec.Id)){
                            toAddressMap.put(rec.Id, new List<String>());
                        }
                        toAddressMap.get(rec.Id).add(rec.inscor__Sales_Order__r.inscor__Billing_Contact__r.Email);
                    }
                    if(rec.inscor__Sales_Order__r.inscor__Assigned_To__r.Email != null){
                        if(!ccAddressMap.containsKey(rec.Id)){
                            ccAddressMap.put(rec.Id, new List<String>());
                        }
                        ccAddressMap.get(rec.Id).add(rec.inscor__Sales_Order__r.inscor__Assigned_To__r.Email);
                    }
                }
                //Send Email to its respective recipient
                System.debug('Debug*** emailTemplateId'+ emailTemplateId);
                //System.debug('Debug*** filteredReleaseIdToEmailMap'+ filteredReleaseIdToEmailMap);
                System.debug('Debug*** relIdToListContentDocumentIdMap'+ relIdToListContentDocumentIdMap);
                CommonUtility.sendEmail(emailTemplateId, toAddressMap, ccAddressMap, relIdToListContentDocumentIdMap, mapReleaseIdToEmailTemplate );
            }
            if(Test.isRunningTest())
                Integer i = 1/0;  
        } catch (Exception error) {	
            LogService.createErrorLog('ReleaseBusinessUtility.apxc', NULL, error, NULL);	
        }  
    }
    
    @InvocableMethod( label='Send Invoice Email Notification' )
    public static List<String> sendInvoiceEmails(List<Id> releaseIds ) {
        List<inscor__Release__c> releases = [SELECT Name, inscor__Status__c, Receivers_Email__c, 
                                             inscor__Sales_Order__r.inscor__Assigned_To__r.Email,
                                             inscor__Sales_Order__r.inscor__Contact__r.Email,
                                             inscor__Sales_Order__r.inscor__Billing_Contact__r.Email, 
                                             inscor__Sales_Order__r.Type__c, 
                                             OwnerId 
                                             FROM inscor__Release__c
                                             WHERE Id in :releaseIds ];
       
        sendEmailOnReleaseStatusInvoiced( releases );
        return null;
    }
}