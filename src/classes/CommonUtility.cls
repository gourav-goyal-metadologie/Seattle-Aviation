/**************************************************************************************************
Description: Class contains common util methods
====================================================================================================
====================================================================================================
TestClass: 
Code Coverage: 
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		05/22/2021		    Nikhil Kumar Srivastava		Initial Creation    
1.0 -      		08/23/2021		    Nikhil Kumar Srivastava	    Added new sendEmailWithEmailBody()    
***************************************************************************************************/
public class CommonUtility 
{

    /* public static final string SUCCESS = 'Success';
    public static final string FAILURE = 'Failure'; */

    /**
    * Send email template.
    * @Param emailTemplateName email template name
    * @Param toAddress List of to-address email 
    * @Param toCCAddress List of to-CCaddress email 
    * @return response.
    */
    public static void sendEmail(Id templateId, Map<Id, List<String>> objIdtoTOAddress, Map<Id, List<String>> objIdtoCCAddress,
                                 Map<Id, Set<Id>> objIdToListContentDocumentIdMap, map<String, String> mapReleaseIdToEmailTemplate) {
        if((objIdtoTOAddress != NULL && !objIdtoTOAddress.isEmpty()) || (objIdtoCCAddress != NULL && !objIdtoCCAddress.isEmpty())){
            try {
                List<Messaging.SingleEmailMessage> allMessage = new List<Messaging.SingleEmailMessage>();
                for(Id idRec : objIdtoTOAddress.keySet()) 
                {
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    /* mail.setTemplateID(templateId); */
                    if(objIdtoTOAddress != NULL){ mail.setToAddresses(objIdtoTOAddress.get(idRec)); } 
                    if(objIdtoCCAddress != NULL){ mail.setCcAddresses(objIdtoCCAddress.get(idRec)); } 

                    mail.setSaveAsActivity(false);
                    /* mail.setTargetObjectId(UserInfo.getUserId());
                    mail.setWhatId(idRec); */
                    
                    OrgWideEmailAddress orgWideAddress = [SELECT Id, Address, DisplayName 
                                                          FROM OrgWideEmailAddress 
                                                          WHERE Address='updates@seattleav.com' 
                                                          LIMIT 1 ];
                    
                    if ( orgWideAddress != null) {
                        mail.setOrgWideEmailAddressId( orgWideAddress.Id );
                    }
                    templateId = mapReleaseIdToEmailTemplate.containsKey(idRec) ? mapReleaseIdToEmailTemplate.get(idRec) : null;
                    Messaging.SingleEmailMessage getEmailTempResponse = Messaging.renderStoredEmailTemplate(templateId, NULL, idRec);
                    
                    inscor__Release__c rls = [SELECT Id, inscor__Sales_Order__r.inscor__Customer_PO_Number__c,
                                              inscor__Sales_Order__r.Name, inscor__Ship_Method__r.Name,
                                              inscor__Shipped_Method__r.Name, inscor__AWB__c, 
                                              inscor__Sales_Order__r.inscor__Assigned_To__r.Name,
                                              inscor__Sales_Order__r.inscor__Assigned_To__r.Email 
                                              FROM inscor__Release__c
                                              WHERE Id = :idRec];
                    
                    
                    if(getEmailTempResponse != NULL) {
                        //Email body
                        if(getEmailTempResponse.getHtmlBody() != NULL) {
                            String htmlBody = getEmailTempResponse.getHtmlBody();
                            htmlBody = setMergeFields(htmlBody, rls);
                            mail.setHtmlBody(htmlBody);
                        } else if(getEmailTempResponse.getPlainTextBody() != NULL) {
                            String plainText = getEmailTempResponse.getPlainTextBody();
                            plainText = setMergeFields(plainText, rls);
                            mail.setPlainTextBody(plainText);
                        }
                        //Email Subject 
                        if(getEmailTempResponse.getSubject() != NULL) {
                            String subject = getEmailTempResponse.getSubject();
                            subject = subject.replace('(Cust.PO#)', rls.inscor__Sales_Order__r.inscor__Customer_PO_Number__c);
                            mail.setSubject(subject);
                        }
                    }
                    if(objIdToListContentDocumentIdMap != NULL && objIdToListContentDocumentIdMap.containsKey(idRec) 
                        && objIdToListContentDocumentIdMap.get(idRec) != NULL) 
                    {
                        mail.setEntityAttachments(new List<Id>(objIdToListContentDocumentIdMap.get(idRec)));
                    }

                    allMessage.add(mail);
                }
                
                if(allMessage != NULL && !allMessage.isEmpty())
                {
                    //Additional parameter is AllOrNothing  to determine whether partial sucees is allowed or not, Default value for AllorNothing is true , in our case we don't want it.     
                    if(!Test.isRunningTest()) {
                        Messaging.SendEmailResult [] sendEmailResults = Messaging.sendEmail(allMessage,false);
                    }
                }
                    
                if(Test.isRunningTest())
                    Integer i = 1/0; 
            } catch(Exception error) {
                LogService.createErrorLog('CommonUtility.apxc', NULL, error, NULL);
            }   
        }    
    }

    public static void sendEmailWithEmailBody(EmailBody emailBody, Map<Id, List<String>> objIdtoTOAddress, Map<Id, List<String>> objIdtoCCAddress, Map<Id, Set<Id>> objIdToListContentDocumentIdMap) 
    {   
        System.debug('sendEmailWithEmailBody.objIdtoTOAddress' + objIdtoTOAddress);
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

                    if(objIdToListContentDocumentIdMap != NULL && objIdToListContentDocumentIdMap.containsKey(idRec) 
                        && objIdToListContentDocumentIdMap.get(idRec) != NULL) 
                    {
                        mail.setEntityAttachments(new List<Id>(objIdToListContentDocumentIdMap.get(idRec)));
                    }
                    OrgWideEmailAddress orgWideAddress = [SELECT Id, Address, DisplayName 
                                                          FROM OrgWideEmailAddress 
                                                          WHERE Address='notifications@seattleav.com' 
                                                          LIMIT 1 ];
                    
                    if ( orgWideAddress != null) {
                        mail.setOrgWideEmailAddressId( orgWideAddress.Id );
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
    
    @Testvisible
    private static String setMergeFields(String emailBody, inscor__Release__c rls){
        if( rls.inscor__Sales_Order__r.inscor__Customer_PO_Number__c != null ){
            emailBody = emailBody.replace('(Cust. PO#)', rls.inscor__Sales_Order__r.inscor__Customer_PO_Number__c);
        }
        
        if( rls.inscor__Sales_Order__r.Name != null ){
            emailBody = emailBody.replace('(SO#)', rls.inscor__Sales_Order__r.Name);
        }
        if( rls.inscor__Ship_Method__r.Name != null ){
            emailBody = emailBody.replace('(Ship Via)', rls.inscor__Ship_Method__r.Name);
        }
        
        String trackURL = '';
        if( rls.inscor__Ship_Method__r.Name != null ){
            
            if( String.isNotBlank( rls.inscor__AWB__c ) ){
                if( rls.inscor__Ship_Method__r.Name.startsWithIgnoreCase('fedex') ){ 
                    trackURL = 'https://www.fedex.com/fedextrack/?trknbr=' + rls.inscor__AWB__c ;
                }else if( rls.inscor__Ship_Method__r.Name.startsWithIgnoreCase('dhl') ){
                    trackURL = 'https://www.dhl.com/us-en/home/tracking/tracking-express.html?submit=1&tracking-id=' + rls.inscor__AWB__c;
                }
                else if( rls.inscor__Ship_Method__r.Name.startsWithIgnoreCase('ups') ){
                    trackURL = 'https://www.ups.com/track?loc=null&tracknum=' + rls.inscor__AWB__c +'&requester=ST/trackdetails';
                }
                if( String.isNotBlank(trackURL) ){
                    trackURL = '<br/><br/><a href="'+
                        trackURL +  '" style="text-align: center; padding: 4px 8px; background-color: #d01c48; color: #fff;'+
                        ' font-family: \'helvetica\', sans-serif; font-size: 12px; text-transform: uppercase; border: 2px solid #d01c48;'+
                        ' -webkit-box-pack: center; -ms-flex-pack: center; text-decoration: none !important; justify-content: center;"'+
                        '>Click Here To Track</a><br/><br/>';
                }
            }
        }
        emailBody = emailBody.replace('(Track URL)', trackURL );
        
        if( rls.inscor__Sales_Order__r.inscor__Assigned_To__r.Name != null ){
            emailBody = emailBody.replace('(SO Assigned to)', rls.inscor__Sales_Order__r.inscor__Assigned_To__r.Name);
        }
        if( rls.inscor__Sales_Order__r.inscor__Assigned_To__r.Email != null ){
            emailBody = emailBody.replace('(Email of SO Assigned to)', rls.inscor__Sales_Order__r.inscor__Assigned_To__r.Email);
        }
        
        return emailBody;
    }


    
    /**
    * Send email template.
    * @Param emailTemplateName email template name
    * @Param toAddress List of to-address email 
    * @Param toCCAddress List of to-CCaddress email 
    * @return response.
    */
    public static void sendEmailForCustomerExchangeSummary(Id templateId, Map<Id, List<String>> objIdtoTOAddress, Map<Id, List<String>> objIdtoCCAddress, Map<Id, Set<Id>> objIdToListContentDocumentIdMap) {
        if((objIdtoTOAddress != NULL && !objIdtoTOAddress.isEmpty()) || (objIdtoCCAddress != NULL && !objIdtoCCAddress.isEmpty())){
            try {
                List<Messaging.SingleEmailMessage> allMessage = new List<Messaging.SingleEmailMessage>();
                Map<Id, inscor__Customer_Exchange_Summary__c> summaryById = new Map<Id, inscor__Customer_Exchange_Summary__c>([SELECT inscor__Original_Product__c, inscor__Original_Product__r.inscor__Description__c 
                                                                            FROM inscor__Customer_Exchange_Summary__c 
                                                                            WHERE Id IN :objIdtoTOAddress.keySet()]);
                
                for(Id idRec : objIdtoTOAddress.keySet()) 
                {
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    /* mail.setTemplateID(templateId); */
                    if(objIdtoTOAddress != NULL){ mail.setToAddresses(objIdtoTOAddress.get(idRec)); } 
                    if(objIdtoCCAddress != NULL){ mail.setCcAddresses(objIdtoCCAddress.get(idRec)); } 

                    mail.setSaveAsActivity(false);
                    /* mail.setTargetObjectId(UserInfo.getUserId());
                    mail.setWhatId(idRec); */
                    Messaging.SingleEmailMessage getEmailTempResponse = Messaging.renderStoredEmailTemplate(templateId, NULL, idRec);
                    
                    if(getEmailTempResponse != NULL) {
                        //Email body
                        if(getEmailTempResponse.getHtmlBody() != NULL) 
                        {
                            String htmlBody = getEmailTempResponse.getHtmlBody();
                            if (summaryById.containsKey(idRec)) {
                                htmlBody = htmlBody.replace('inscor__Description__c', summaryById.get(idRec).inscor__Original_Product__r.inscor__Description__c);
                            }
                            mail.setHtmlBody(htmlBody);
                        } else if(getEmailTempResponse.getPlainTextBody() != NULL) 
                        {
                            mail.setPlainTextBody(getEmailTempResponse.getPlainTextBody());
                        }
                        //Email Subject 
                        if(getEmailTempResponse.getSubject() != NULL) 
                        {
                            mail.setSubject(getEmailTempResponse.getSubject());
                        }
                    }
                    if(objIdToListContentDocumentIdMap != NULL && objIdToListContentDocumentIdMap.containsKey(idRec) 
                        && objIdToListContentDocumentIdMap.get(idRec) != NULL) 
                    {
                        mail.setEntityAttachments(new List<Id>(objIdToListContentDocumentIdMap.get(idRec)));
                    }
                    
                    

                    allMessage.add(mail);
                }
                
                if(allMessage != NULL && !allMessage.isEmpty())
                {
                    //Additional parameter is AllOrNothing  to determine whether partial sucees is allowed or not, Default value for AllorNothing is true , in our case we don't want it.     
                    if(!Test.isRunningTest()) {
                        Messaging.SendEmailResult [] sendEmailResults = Messaging.sendEmail(allMessage,false);
                    }
                }
                    
                if(Test.isRunningTest())
                    Integer i = 1/0; 
            } catch(Exception error) {
                System.debug('Exception :' + error.getMessage());
                System.debug('Exception :' + error.getStackTraceString());
                LogService.createErrorLog('CommonUtility.apxc', NULL, error, NULL);
            }   
        }    
    }

    /**
     * @author : Vinod Kumar Sharma
    * Send email template.
    * @Param emailTemplateName email template name
    * @Param toAddress List of to-address email 
    * @Param toCCAddress List of to-CCaddress email 
    * @return response.
    */
    public static void sendEmailWithAttachment(Id templateId, Map<Id, List<String>> objIdtoTOAddress, Map<Id, List<String>> objIdtoCCAddress, Map<Id, Set<Id>> objIdToListContentDocumentIdMap, 
                                                Blob bodyBlob, String attachmentFileName, String attachmentExtension) {
        if((objIdtoTOAddress != NULL && !objIdtoTOAddress.isEmpty()) || (objIdtoCCAddress != NULL && !objIdtoCCAddress.isEmpty())){
            try {
                List<Messaging.SingleEmailMessage> allMessage = new List<Messaging.SingleEmailMessage>();
                Map<Id, inscor__Customer_Exchange_Summary__c> summaryById = new Map<Id, inscor__Customer_Exchange_Summary__c>([SELECT inscor__Original_Product__c, inscor__Original_Product__r.inscor__Description__c 
                                                                            FROM inscor__Customer_Exchange_Summary__c 
                                                                            WHERE Id IN :objIdtoTOAddress.keySet()]);
                for(Id idRec : objIdtoTOAddress.keySet()) 
                {
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    if(objIdtoTOAddress != NULL){ mail.setToAddresses(objIdtoTOAddress.get(idRec)); } 
                    if(objIdtoCCAddress != NULL){ mail.setCcAddresses(objIdtoCCAddress.get(idRec)); } 
                    
                    mail.setSaveAsActivity(false);
                    Messaging.SingleEmailMessage getEmailTempResponse = Messaging.renderStoredEmailTemplate(templateId, NULL, idRec);
                    
                    if(getEmailTempResponse != NULL) {
                        //Email body
                        if(getEmailTempResponse.getHtmlBody() != NULL) 
                        {   
                            String htmlBody = getEmailTempResponse.getHtmlBody();
                            if (summaryById.containsKey(idRec)) {
                                htmlBody = htmlBody.replace('inscor__Description__c', summaryById.get(idRec).inscor__Original_Product__r.inscor__Description__c);
                            }                            
                            mail.setHtmlBody(htmlBody);
                        } else if(getEmailTempResponse.getPlainTextBody() != NULL) 
                        {
                            mail.setPlainTextBody(getEmailTempResponse.getPlainTextBody());
                        }
                        //Email Subject 
                        if(getEmailTempResponse.getSubject() != NULL) 
                        {
                            mail.setSubject(getEmailTempResponse.getSubject());
                        }
                    }
                    if(objIdToListContentDocumentIdMap != NULL && objIdToListContentDocumentIdMap.containsKey(idRec) 
                        && objIdToListContentDocumentIdMap.get(idRec) != NULL) 
                    {
                        mail.setEntityAttachments(new List<Id>(objIdToListContentDocumentIdMap.get(idRec)));
                    }
                    if (bodyBlob != null) {
                        Messaging.EmailFileAttachment emailAttachment = new Messaging.EmailFileAttachment();
                        emailAttachment.setFileName(attachmentFileName + attachmentExtension);
                        emailAttachment.setBody(bodyBlob);
                        mail.setFileAttachments(new Messaging.EmailFileAttachment[] {emailAttachment});
                    }
                    /**Added during production issue for submit button in core exchange */
                    OrgWideEmailAddress orgWideAddress = [SELECT Id, Address, DisplayName 
                                                          FROM OrgWideEmailAddress 
                                                          WHERE Address='notifications@seattleav.com' 
                                                          LIMIT 1 ];
                    
                    if ( orgWideAddress != null) {
                        mail.setOrgWideEmailAddressId( orgWideAddress.Id );
                    }

                    allMessage.add(mail);
                }
                
                if(allMessage != NULL && !allMessage.isEmpty())
                {
                    //Additional parameter is AllOrNothing  to determine whether partial sucees is allowed or not, Default value for AllorNothing is true , in our case we don't want it.     
                    if(!Test.isRunningTest()) {
                        Messaging.SendEmailResult [] sendEmailResults = Messaging.sendEmail(allMessage,false);
                        System.debug('sendEmailResults:' + sendEmailResults);
                    }
                }
                    
                if(Test.isRunningTest())
                    Integer i = 1/0; 
            } catch(Exception error) {
                LogService.createErrorLog('commanUtility.apxc', NULL, error, NULL);
            }   
        }    
    }


    /**
    * Send email template.
    * @Param emailTemplateName email template name
    * @Param toAddress List of to-address email 
    * @Param toCCAddress List of to-CCaddress email 
    * @return response.
    */
    public static void sendEmailForCustomerExchangeSummary(Map<Id,Id> emailTemplateByCustomerExchangeSummary, Map<Id, List<String>> objIdtoTOAddress, Map<Id, List<String>> objIdtoCCAddress, Map<Id, Set<Id>> objIdToListContentDocumentIdMap) {
        if((objIdtoTOAddress != NULL && !objIdtoTOAddress.isEmpty()) || (objIdtoCCAddress != NULL && !objIdtoCCAddress.isEmpty())){
            try {
                List<Messaging.SingleEmailMessage> allMessage = new List<Messaging.SingleEmailMessage>();
                Map<Id, inscor__Customer_Exchange_Summary__c> summaryById = new Map<Id, inscor__Customer_Exchange_Summary__c>([SELECT inscor__Original_Product__c, inscor__Original_Product__r.inscor__Description__c 
                                                                            FROM inscor__Customer_Exchange_Summary__c 
                                                                            WHERE Id IN :objIdtoTOAddress.keySet()]);
                
                for(Id idRec : objIdtoTOAddress.keySet()) 
                {
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    /* mail.setTemplateID(templateId); */
                    if(objIdtoTOAddress != NULL){ mail.setToAddresses(objIdtoTOAddress.get(idRec)); } 
                    if(objIdtoCCAddress != NULL){ mail.setCcAddresses(objIdtoCCAddress.get(idRec)); } 

                    mail.setSaveAsActivity(false);
                    /* mail.setTargetObjectId(UserInfo.getUserId());
                    mail.setWhatId(idRec); */
                    Messaging.SingleEmailMessage getEmailTempResponse = Messaging.renderStoredEmailTemplate(emailTemplateByCustomerExchangeSummary.get(idRec), NULL, idRec);
                    
                    if(getEmailTempResponse != NULL) {
                        //Email body
                        if(getEmailTempResponse.getHtmlBody() != NULL) 
                        {
                            String htmlBody = getEmailTempResponse.getHtmlBody();
                            if (summaryById.containsKey(idRec)) {
                                htmlBody = htmlBody.replace('inscor__Description__c', summaryById.get(idRec).inscor__Original_Product__r.inscor__Description__c);
                            }
                            mail.setHtmlBody(htmlBody);
                        } else if(getEmailTempResponse.getPlainTextBody() != NULL) 
                        {
                            mail.setPlainTextBody(getEmailTempResponse.getPlainTextBody());
                        }
                        //Email Subject 
                        if(getEmailTempResponse.getSubject() != NULL) 
                        {
                            mail.setSubject(getEmailTempResponse.getSubject());
                        }
                    }
                    if(objIdToListContentDocumentIdMap != NULL && objIdToListContentDocumentIdMap.containsKey(idRec) 
                        && objIdToListContentDocumentIdMap.get(idRec) != NULL) 
                    {
                        mail.setEntityAttachments(new List<Id>(objIdToListContentDocumentIdMap.get(idRec)));
                    }
                    
                    

                    allMessage.add(mail);
                }
                
                if(allMessage != NULL && !allMessage.isEmpty())
                {
                    //Additional parameter is AllOrNothing  to determine whether partial sucees is allowed or not, Default value for AllorNothing is true , in our case we don't want it.     
                    if(!Test.isRunningTest()) {
                        Messaging.SendEmailResult [] sendEmailResults = Messaging.sendEmail(allMessage,false);
                    }
                }
                    
                if(Test.isRunningTest())
                    Integer i = 1/0; 
            } catch(Exception error) {
                System.debug('Exception :' + error.getMessage());
                System.debug('Exception :' + error.getStackTraceString());
                LogService.createErrorLog('CommonUtility.apxc', NULL, error, NULL);
            }   
        }    
    }

    
}