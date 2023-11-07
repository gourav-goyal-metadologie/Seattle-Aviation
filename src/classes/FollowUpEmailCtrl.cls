/**************************************************************************************************
Description: Controller class for FollowUpEmail LWCs
====================================================================================================
====================================================================================================
TestClass: FollowUpEmailCtrlTest
Code Coverage: 92%
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		08/28/2021		    Nikhil Kumar Srivastava		 Initial Creation
2.0             10/14/2021          Vinod Kumar Sharma           Updated getCustomerSummary
***************************************************************************************************/
public class FollowUpEmailCtrl 
{

    private static final String CORE_UNIT_EXCHANGE_PPW_REQUEST_TEMPLATE = 'Core_Unit_Exchange_PPW_Request';
    //private static final String CORE_UNIT_EXCHANGE_PPW_REQUEST_TEMPLATE = 'Core_Unit_Exchange_PPW_Request_1';
    
    @Testvisible private static final String SHIPPED = 'Shipped';
    @Testvisible private static final String SUCCESS = 'Success';
    @Testvisible private static final String ERROR = 'Error';
    @Testvisible private static final String NO_DUE_RECORDS_FOUND = 'No Due Records Found';

    @AuraEnabled
    public static FollowUpWrapper getFollowUpWrapper(String customerExchangeSummaryId){
        try {
            Date next5Date = System.Today().addDays(5);
            Date todayDate = System.Today();
            List<inscor__Customer_Exchange_Summary__c> summaries = [SELECT inscor__Exchange_Status__c, inscor__Original_Core_Due_Date__c,
                                                                    Is_Customer_Email_Notified_D__c,
                                                                    Is_Customer_Email_Notified_D_5__c,
                                                                    Is_Customer_Email_Notified_D_3__c,
                                                                    Is_Customer_Email_Notified_D_2__c,
                                                                    Is_Customer_Email_Notified_D_1__c,
                                                                    Is_Customer_Email_Notified_D_3_Late__c,
                                                                    inscor__Original_SO_ID__c, 
                                                                    inscor__Original_SO_ID__r.inscor__Assigned_To__r.Email,
                                                                    inscor__Original_SO_ID__r.inscor__Dropship_ATTN__r.Email,
                                                                    inscor__Original_SO_ID__r.inscor__Contact__r.Email
                                                                    FROM inscor__Customer_Exchange_Summary__c
                                                                    WHERE Id =:customerExchangeSummaryId];
            FollowUpWrapper wrapper = new FollowUpWrapper();
            if (!summaries.isEmpty()) {    
                if (summaries.get(0).inscor__Original_Core_Due_Date__c == null) {
                    wrapper.isValid = false;
                    wrapper.errorMessage = 'Original due date not found!';
                }else if(summaries.get(0).inscor__Exchange_Status__c != SHIPPED) {
                    wrapper.isValid = false;
                    wrapper.errorMessage = 'Exchange status should be shipped for follow up activity!';
                }else if (summaries.get(0).inscor__Original_SO_ID__c == null) {
                    wrapper.isValid = false;
                    wrapper.errorMessage = 'Sales order not found!';
                }else if (summaries.get(0).inscor__Original_SO_ID__r.inscor__Assigned_To__r.Email == null) {
                    wrapper.isValid = false;
                    wrapper.errorMessage = 'AssignedTo email on sales order not found!';
                }else if (summaries.get(0).inscor__Original_SO_ID__r.inscor__Contact__r.Email == null && summaries.get(0).inscor__Original_SO_ID__r.inscor__Dropship_ATTN__r.Email == null ) {
                    wrapper.isValid = false;
                    wrapper.errorMessage = 'Contact email on sales order not found!';
                } else if (summaries.get(0).inscor__Original_Core_Due_Date__c != next5Date 
                            && summaries.get(0).inscor__Original_Core_Due_Date__c != System.Today().addDays(3)
                            && summaries.get(0).inscor__Original_Core_Due_Date__c != System.Today().addDays(2)
                            && summaries.get(0).inscor__Original_Core_Due_Date__c != System.Today().addDays(1)
                            && summaries.get(0).inscor__Original_Core_Due_Date__c != System.Today().addDays(-3)
                            && summaries.get(0).inscor__Original_Core_Due_Date__c != todayDate
                        ) {
                    wrapper.isValid = false;
                    wrapper.errorMessage = 'Follow up activity supposed to happen only on D-5, D-3, D-2, D-1, D+3 and due date.';
                }else if ((summaries.get(0).inscor__Original_Core_Due_Date__c == next5Date && summaries.get(0).Is_Customer_Email_Notified_D_5__c) 
                            || (summaries.get(0).inscor__Original_Core_Due_Date__c == todayDate && summaries.get(0).Is_Customer_Email_Notified_D__c)
                            || (summaries.get(0).inscor__Original_Core_Due_Date__c == System.Today().addDays(3) && summaries.get(0).Is_Customer_Email_Notified_D_3__c)
                            || (summaries.get(0).inscor__Original_Core_Due_Date__c == System.Today().addDays(2) && summaries.get(0).Is_Customer_Email_Notified_D_2__c)
                            || (summaries.get(0).inscor__Original_Core_Due_Date__c == System.Today().addDays(1) && summaries.get(0).Is_Customer_Email_Notified_D_1__c)
                            || (summaries.get(0).inscor__Original_Core_Due_Date__c == System.Today().addDays(-3) && summaries.get(0).Is_Customer_Email_Notified_D_3_Late__c)
                        ) {
                    wrapper.isValid = false;
                    wrapper.errorMessage = 'Follow up activity already happened!';
                }else{
                   //wrapper.Day = summaries.get(0).inscor__Original_Core_Due_Date__c.daysBetween(System.Today());
                   wrapper.Day = System.Today().daysBetween(summaries.get(0).inscor__Original_Core_Due_Date__c);
                }
            }else {
                wrapper.isValid = false;
                wrapper.errorMessage = 'Record not found!';
            }
            return wrapper;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

	@AuraEnabled(cacheable=false)
    public static EmailBody getEmailRenderedTemplate(Id recordId, Integer daysDifference)
    {
        try 
        {   
            String selectedEmailTemplate = '';
            switch on daysDifference {
                when 5 {
                    selectedEmailTemplate = Constants.EMAIL_TEMPLATE_DUE_DATE_5;
                }
                when 3 {
                    selectedEmailTemplate = Constants.EMAIL_TEMPLATE_DUE_DATE_3;
                }
                when 2 {
                    selectedEmailTemplate = Constants.EMAIL_TEMPLATE_DUE_DATE_2;
                }
                when 1 {
                    selectedEmailTemplate = Constants.EMAIL_TEMPLATE_DUE_DATE_1;
                }
                when 0 {
                    selectedEmailTemplate = Constants.EMAIL_TEMPLATE_DUE_DATE_DAY;
                }
                when -3 {
                    selectedEmailTemplate = Constants.EMAIL_TEMPLATE_DUE_DATE_LATE_SCENARIO;
                }
            }
            
            System.debug('Debug** getEmailRenderedTemplate recordId ' + recordId); 
            if(String.isNotBlank(recordId) && String.valueOf(Id.valueOf(recordId).getSObjectType()) == 'inscor__Customer_Exchange_Summary__c') 
            {
                Id emailTemplateId = [SELECT Id FROM EmailTemplate 
                                    // WHERE DeveloperName =: CORE_UNIT_EXCHANGE_PPW_REQUEST_TEMPLATE 
                                    //WHERE DeveloperName =: Constants.EMAIL_TEMPLATE_DUE_DATE_5 
                                    WHERE DeveloperName =: selectedEmailTemplate 
                                    LIMIT 1]?.Id;

                if(emailTemplateId == NULL) 
                {
                    LogService.createErrorLog('FollowUpEmailCtrl.cls', NULL, NULL, selectedEmailTemplate+ ' Email template does not exist.');
                    throw new AuraHandledException('Email template does not exist.');
                }
                inscor__Customer_Exchange_Summary__c summary = [SELECT inscor__Original_Product__c, inscor__Original_Product__r.inscor__Description__c 
                                                                    FROM inscor__Customer_Exchange_Summary__c 
                                                                    WHERE Id =:recordId];
                System.debug(summary);
                EmailBody emailBody = new EmailBody(Messaging.renderStoredEmailTemplate(emailTemplateId, NULL, recordId));
                if (summary.inscor__Original_Product__c != null) {
                    emailBody.HtmlBody = emailBody.HtmlBody.replace('inscor__Description__c', summary.inscor__Original_Product__r.inscor__Description__c);
                } else {
                    emailBody.HtmlBody = emailBody.HtmlBody.replace('inscor__Description__c', '');
                }
                return emailBody;
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

    @AuraEnabled(cacheable=false)
    public static Boolean checkDueDateForNext5Day(Id recordId) 
    {
        Date next5Date = System.Today().addDays(5);
        List<inscor__Customer_Exchange_Summary__c> customerExchangeSummary = new List<inscor__Customer_Exchange_Summary__c>(
                                                                                        [SELECT Id 
                                                                                        FROM inscor__Customer_Exchange_Summary__c
                                                                                        WHERE Id =:recordId 
                                                                                        AND inscor__Exchange_Status__c =: SHIPPED
                                                                                        AND inscor__Original_Core_Due_Date__c =: next5Date
                                                                                        AND Is_Customer_Email_Notified_D_5__c = FALSE
                                                                                        LIMIT 1]);
        return customerExchangeSummary != NULL && !customerExchangeSummary.isEmpty();
    }

    @AuraEnabled(cacheable=false)
    public static Boolean checkDueDateForNext1Day(Id recordId) 
    {
        Date todayDate = System.Today();
        List<inscor__Customer_Exchange_Summary__c> customerExchangeSummary = new List<inscor__Customer_Exchange_Summary__c>(
                                                                                        [SELECT Id 
                                                                                        FROM inscor__Customer_Exchange_Summary__c
                                                                                        WHERE Id =:recordId 
                                                                                        AND inscor__Exchange_Status__c =: SHIPPED
                                                                                        AND inscor__Original_Core_Due_Date__c =:todayDate
                                                                                        AND Is_Customer_Email_Notified_D__c = FALSE
                                                                                        LIMIT 1]);
        return customerExchangeSummary != NULL && !customerExchangeSummary.isEmpty();
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
            System.debug('Debug*** sendFollowUpEmail emailBodyObj' + emailBodyObj);

            String status = sendEmailFollowUpWithEmailBody(recordId, emailBodyObj);
            System.debug('Debug*** sendFollowUpEmail status' + status);
            
            if(status == SUCCESS) 
            {   

                inscor__Customer_Exchange_Summary__c customerExchangeSummary = [SELECT  inscor__Original_Core_Due_Date__c
                                                                                FROM inscor__Customer_Exchange_Summary__c
                                                                                WHERE Id =:recordId];
                // Date next5Date = System.Today().addDays(5);
                // Date todayDate = System.Today();
                Integer daysDifference = System.Today().daysBetween(customerExchangeSummary.inscor__Original_Core_Due_Date__c);
                
                switch on daysDifference {
                    when 5 {
                        customerExchangeSummary.Is_Customer_Email_Notified_D_5__c = true;  }
                    when 3 {
                        customerExchangeSummary.Is_Customer_Email_Notified_D_3__c = true;  }
                    when 2 {
                        customerExchangeSummary.Is_Customer_Email_Notified_D_2__c = true;  }
                    when 1 {
                        customerExchangeSummary.Is_Customer_Email_Notified_D_1__c = true;  }
                    when 0 {
                        customerExchangeSummary.Is_Customer_Email_Notified_D__c = true;  }
                    when -3 {
                        customerExchangeSummary.Is_Customer_Email_Notified_D_3_Late__c = true;  }
                }
                
                return performSave(customerExchangeSummary);
            } 
            else if(status == NO_DUE_RECORDS_FOUND)
            {
                return status;
            } 
            else 
            {
                return ERROR;
            }
        } 
        catch (Exception e) 
        {
            LogService.createErrorLog('FollowUpEmailCtrl.apxc', NULL, e, NULL);
            System.debug('Debug** Error :  ' + e.getStackTraceString());
            throw new AuraHandledException('Failure ' + e.getMessage());
        }
    }

    public static String performSave(inscor__Customer_Exchange_Summary__c customerExchangeSummary)
    {
        List<Database.SaveResult> saveResults = Database.update(new List<inscor__Customer_Exchange_Summary__c>{customerExchangeSummary}, false);
        LogService.logInsertUpdateFailures('FollowUpEmailCtrl.cls', new List<inscor__Customer_Exchange_Summary__c>{customerExchangeSummary}, saveResults);
        
        for (Database.SaveResult sr : saveResults) 
        {
            if (!sr.isSuccess()) 
            {
                for(Database.Error err : sr.getErrors()) 
                {
                    System.debug('Error'+err.getMessage()+err.getFields());   
                    throw new AuraHandledException('Error'+err.getMessage()+err.getFields());                 
                }
            }
        }
        return SUCCESS;
    }

    public static String sendEmailFollowUpWithEmailBody(Id recordId, EmailBody emailBodyObj)
    {
        
        String objectType = String.valueOf(Id.valueOf(recordId).getSObjectType());
        String query;
        if(objectType == 'inscor__Customer_Exchange_Summary__c')
        {
                query = 'SELECT Id,inscor__Original_Core_Due_Date__c, inscor__Original_SO_ID__c,';
                query+= ' inscor__Original_SO_ID__r.inscor__Contact__r.Email, inscor__Original_SO_ID__r.inscor__Assigned_To__r.Email, inscor__Original_SO_ID__r.inscor__Dropship_ATTN__r.Email ';
                query+= ' FROM inscor__Customer_Exchange_Summary__c';
                query+= ' WHERE Id = \''+ recordId + '\'';
                query+= ' LIMIT 1'; 
        
        }
        if(String.isNotBlank(query))
        {
            return getSendEmailResponse(query, emailBodyObj); 
        }
        return NO_DUE_RECORDS_FOUND;
    }

    private static String getSendEmailResponse(String query, EmailBody emailBodyObj)
    {
        System.debug('Debug** getSendEmailResponse query ' + query);
        List<inscor__Customer_Exchange_Summary__c> cseList = Database.query(query);
        System.debug('Debug** getSendEmailResponse cseList ' + cseList);

        if(!cseList.isEmpty()) 
        {   
            inscor__Customer_Exchange_Summary__c iceRec = cseList[0];
            /* Assumption : Only one record will come because we have recordId Check in Query */
            
            Map<Id, List<String>> cseIdtoTOAddressMap = new Map<Id, List<String>>();
            Map<Id, List<String>> objIdtoCCAddress = new Map<Id, List<String>>();
            List<String> ccEmailAddresses = new List<String>{Label.Core_Exchange_Customer_CC_EmailAddress};
            if(String.isNotBlank(iceRec.inscor__Original_SO_ID__c))
            {
                if(!cseIdtoTOAddressMap.containsKey(iceRec.Id))
                {
                    if((iceRec.inscor__Original_SO_ID__r.inscor__Contact__r != NULL && iceRec.inscor__Original_SO_ID__r.inscor__Contact__r.Email != NULL) || 
                    (iceRec.inscor__Original_SO_ID__r.inscor__Assigned_To__r != NULL && iceRec.inscor__Original_SO_ID__r.inscor__Assigned_To__r.Email != NULL) ||
                    (iceRec.inscor__Original_SO_ID__r.inscor__Dropship_ATTN__r != NULL && iceRec.inscor__Original_SO_ID__r.inscor__Dropship_ATTN__r.Email != NULL))
                    {
                        cseIdtoTOAddressMap.put(iceRec.Id, new List<String>());
                        objIdtoCCAddress.put(iceRec.Id, ccEmailAddresses);
                    }
                }
            
                if(iceRec.inscor__Original_SO_ID__r.inscor__Contact__r != NULL && iceRec.inscor__Original_SO_ID__r.inscor__Contact__r.Email != NULL){
                    cseIdtoTOAddressMap.get(iceRec.Id)
                        .add(iceRec.inscor__Original_SO_ID__r.inscor__Contact__r.Email);
                }else if (iceRec.inscor__Original_SO_ID__r.inscor__Dropship_ATTN__r != NULL && iceRec.inscor__Original_SO_ID__r.inscor__Dropship_ATTN__r.Email != NULL) {
                    cseIdtoTOAddressMap.get(iceRec.Id)
                        .add(iceRec.inscor__Original_SO_ID__r.inscor__Dropship_ATTN__r.Email);
                }
                
                if(iceRec.inscor__Original_SO_ID__r.inscor__Assigned_To__r != NULL && iceRec.inscor__Original_SO_ID__r.inscor__Assigned_To__r.Email != NULL)
                    cseIdtoTOAddressMap.get(iceRec.Id)
                        .add(iceRec.inscor__Original_SO_ID__r.inscor__Assigned_To__r.Email);
                
                System.debug('cseIdtoTOAddressMap->' + cseIdtoTOAddressMap);
                System.debug('Debug** getSendEmailResponse cseList ' + cseList);
                CommonUtility.sendEmailWithEmailBody(emailBodyObj, cseIdtoTOAddressMap, objIdtoCCAddress, NULL); 
                return SUCCESS;
            }    
        }
        return NO_DUE_RECORDS_FOUND;
    }

    public class FollowUpWrapper{
        @AuraEnabled public Boolean isValid{get; set;}
        @AuraEnabled public Integer Day{get; set;}
        @AuraEnabled public String errorMessage{get; set;}

        public FollowUpWrapper(){
            isValid = true;
            errorMessage = '';
            Day = 0;
        }
    }
}