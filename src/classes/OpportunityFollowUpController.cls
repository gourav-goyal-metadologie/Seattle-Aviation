/**************************************************************************************************
Description: Controller class for opportunityFolloUpModel lwc component
====================================================================================================
====================================================================================================
TestClass: 
Code Coverage: 
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		09/27/2021        	Vinod Kumar Sharma 				Initial Creation   				         						      	Initial Creation    
2.0 -      		09/27/2021        	Vinod Kumar Sharma 				Added generatePDF method  				         						      	Initial Creation    
***************************************************************************************************/
public class OpportunityFollowUpController {
    
    private static final string OPP_FOLLOW_UP_EMAIL = 'Opportunity_Follow_Up_Email';

    @AuraEnabled(cacheable=false)
    public static EmailBody getEmailRenderedTemplate(Id recordId)
    {
        try 
        {
            if(String.isNotBlank(recordId) && String.valueOf(Id.valueOf(recordId).getSObjectType()) == 'Opportunity') 
            {
                Id emailTemplateId = [SELECT Id FROM EmailTemplate 
                                    WHERE DeveloperName =: OPP_FOLLOW_UP_EMAIL 
                                    LIMIT 1]?.Id;

                if(emailTemplateId == NULL) 
                {
                    LogService.createErrorLog('OpportunityFollowUpController.cls', NULL, NULL, OPP_FOLLOW_UP_EMAIL+ ' Email template does not exist.');
                    throw new AuraHandledException('Email template does not exist.');
                }
                return new EmailBody(Messaging.renderStoredEmailTemplate(emailTemplateId, NULL, recordId));
            } 
            else 
            {
               
                throw new AuraHandledException('Invalid Id for this process');
            }
        } 
        catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
          
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<inscor__Customer_Quote_Line__c> getQuoteLines(String opportunityId){
        try {
            List<inscor__Customer_Quote_Line__c> quoteLines = [SELECT Id, inscor__Customer_Quote__c  
                                                                FROM inscor__Customer_Quote_Line__c 
                                                                WHERE inscor__Customer_Quote__c IN (SELECT Customer_Quote__c 
                                                                                                    FROM Opportunity WHERE Id =:opportunityId)];
            return quoteLines;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=false)
    public static String sendFollowUpEmail(Id recordId, String emailBodyJSON)
    { 
        try 
        {
            if(String.isBlank(recordId))
            {
                throw new AuraHandledException('Invalid Id for this process');
            }

            EmailBody emailBodyObj = (EmailBody)System.JSON.deserialize(emailBodyJSON, EmailBody.class);
            emailBodyObj.htmlBody = emailBodyObj.TextBody; //Added for SS-285 by Vinod Sharma
            String status = sendEmailFollowUpWithEmailBody(recordId, emailBodyObj);
            
            return status;
        } 
        catch (Exception e) 
        {
            LogService.createErrorLog('FollowUpEmailCtrl.apxc', NULL, e, NULL);
            System.debug('Debug** Error :  ' + e.getStackTraceString());
            throw new AuraHandledException('Failure ' + e.getMessage());
        }
    }

    public static String sendEmailFollowUpWithEmailBody(Id recordId, EmailBody emailBodyObj)
    {
        
        String objectType = String.valueOf(Id.valueOf(recordId).getSObjectType());
        String query;
        if(objectType == 'Opportunity')
        {
                query = 'SELECT Id,Customer_Quote__r.inscor__Contact__r.Email';
                query+= ' FROM Opportunity';
                query+= ' WHERE Id = \''+ recordId + '\'';
                query+= ' LIMIT 1';
        
        }
        if(String.isNotBlank(query))
        {
            return getSendEmailResponse(query, emailBodyObj); 
        }
        return 'Error';
    }

    public static String getSendEmailResponse(String query, EmailBody emailBodyObj) //private
    {
        System.debug('Debug** getSendEmailResponse query ' + query);
        List<Opportunity> oppList = Database.query(query);

        if(!oppList.isEmpty()) 
        {   
            Opportunity oppRecord = oppList[0];
            /* Assumption : Only one record will come because we have recordId Check in Query */
            
            Map<Id, List<String>> cseIdtoTOAddressMap = new Map<Id, List<String>>();
            if(String.isNotBlank(oppRecord.Customer_Quote__c))
            {
                if(!cseIdtoTOAddressMap.containsKey(oppRecord.Id))
                {
                    if((oppRecord.Customer_Quote__r.inscor__Contact__r != NULL && oppRecord.Customer_Quote__r.inscor__Contact__r.Email != NULL))
                    {
                        cseIdtoTOAddressMap.put(oppRecord.Id, new List<String>());
                    }
                }
            
                if(oppRecord.Customer_Quote__r.inscor__Contact__r != NULL && oppRecord.Customer_Quote__r.inscor__Contact__r.Email != NULL)
                    cseIdtoTOAddressMap.get(oppRecord.Id)
                        .add(oppRecord.Customer_Quote__r.inscor__Contact__r.Email);
                
                System.debug('cseIdtoTOAddressMap->' + cseIdtoTOAddressMap);
                //CommonUtility.sendEmailWithEmailBody(emailBodyObj, cseIdtoTOAddressMap, NULL, NULL); 
                sendEmailWithEmailBodyAndAttachment(emailBodyObj, cseIdtoTOAddressMap, NULL, generatePDF(oppRecord.Customer_Quote__c)); 
                return 'Success';
            }    
        }
        return 'Error';
    }

    /**
     * @author : Vinod Kumar Sharma
     * @description : it will generate the pdf of exchange response form
     */
    public static Blob generatePDF(String customerQuoteId) {
        try {
            String quoteLineIds = '';
            for ( inscor__Customer_Quote_Line__c quoteLine : [SELECT Id FROM inscor__Customer_Quote_Line__c WHERE inscor__Customer_Quote__c = :customerQuoteId]) {
                quoteLineIds += quoteLine.Id + ',';
            }
            
            PageReference page = new PageReference('/apex/inscor__GenerateQuote_Master');
            page.getParameters().put('id', customerQuoteId);
            page.getParameters().put('title', 'QUOTE');
            if (quoteLineIds != '') {
                quoteLineIds = quoteLineIds.removeEnd(',');
            }
            page.getParameters().put('cqid', quoteLineIds);
            return (!Test.isRunningTest()) ? page.getContent() : Blob.valueOf('Test Class Page Content!');
            //return page.getContent();
        } catch (Exception error) {
            LogService.createErrorLog('OpportunityFollowUpController.cls', NULL, error, NULL);
            return null;
        }
    }

    public static void sendEmailWithEmailBodyAndAttachment(EmailBody emailBody, Map<Id, List<String>> objIdtoTOAddress, Map<Id, List<String>> objIdtoCCAddress, Blob bodyBlob) {

        if((objIdtoTOAddress != NULL && !objIdtoTOAddress.isEmpty()) || (objIdtoCCAddress != NULL && !objIdtoCCAddress.isEmpty())){
            try {
                List<Messaging.SingleEmailMessage> allMessage = new List<Messaging.SingleEmailMessage>();
                
                for(Id idRec : objIdtoTOAddress.keySet()) 
                {
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

                    if(objIdtoTOAddress != NULL){ mail.setToAddresses(objIdtoTOAddress.get(idRec)); } 
                    if(objIdtoCCAddress != NULL){ mail.setCcAddresses(objIdtoCCAddress.get(idRec)); } 

                    mail.setSaveAsActivity(false);

                    //Email body
                    if(emailBody.HtmlBody != NULL) 
                    {
                        mail.setHtmlBody(emailBody.HtmlBody);
                    } 
                    else if(emailBody.TextBody != NULL) 
                    {
                        mail.setPlainTextBody(emailBody.TextBody);
                    }
                    //Email Subject 
                    if(emailBody.Subject != NULL) 
                    {
                        mail.setSubject(emailBody.Subject);
                    }

                    OrgWideEmailAddress orgWideAddress = [SELECT Id, Address, DisplayName 
                                                          FROM OrgWideEmailAddress 
                                                          WHERE Address='notifications@seattleav.com' 
                                                          LIMIT 1 ];
                    
                    if ( orgWideAddress != null) {
                        mail.setOrgWideEmailAddressId( orgWideAddress.Id );
                    }

                    if (bodyBlob != null) {
                        Messaging.EmailFileAttachment emailAttachment = new Messaging.EmailFileAttachment();
                        emailAttachment.setFileName('QuoteInformation' + '.pdf');
                        emailAttachment.setBody(bodyBlob);
                        mail.setFileAttachments(new Messaging.EmailFileAttachment[] {emailAttachment});
                    }

                    allMessage.add(mail);
                }
                if(allMessage != NULL && !allMessage.isEmpty())
                {
                    if(!Test.isRunningTest()) {
                        System.debug('CommonUtility.allMessage ->' + JSON.serializePretty(allMessage));
                        Messaging.SendEmailResult [] sendEmailResults = Messaging.sendEmail(allMessage,false);
                    }
                }
            } 
            catch(Exception e) {
                LogService.createErrorLog('CommonUtility.apxc', NULL, e, NULL);
                System.debug('Exception Occured: '+e.getMessage());
                throw e;
            }   
        }    
    }
}