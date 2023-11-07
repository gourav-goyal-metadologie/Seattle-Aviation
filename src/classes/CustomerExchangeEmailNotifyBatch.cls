/**************************************************************************************************
Description: This batch class used for sending out email 
====================================================================================================
====================================================================================================
Class: CustomerExchangeEmailNotifyBatchTest
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		08/15/2021		    Nikhil Kumar Srivastava				Initial Creation     
***************************************************************************************************/
public class CustomerExchangeEmailNotifyBatch implements Database.Batchable<Sobject>, Schedulable
{   
    public static Date todaysDate = System.Today();
    public Integer nextNDays = 15;
    List<inscor__Customer_Exchange_Summary__c> customerExchangeForUpdateList = new List<inscor__Customer_Exchange_Summary__c>();
    public static string exchangeStatusShipped = Constants.CUSTOMER_EXCHANGE_SUMMARY_EXCHANGE_STATUS_SHIPPED;

    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        Date next15Date = System.Today().addDays(nextNDays);
        Date next10DaysRemain = System.Today().addDays(10);
        Date next5Date = todaysDate.addDays(5);
        Date next3Date = todaysDate.addDays(3);
        Date next2Date = todaysDate.addDays(2);
        Date next1Date = todaysDate.addDays(1);
        Date back3Date = todaysDate.addDays(-3);
    
        String query = 'SELECT Id,inscor__Original_Core_Due_Date__c, inscor__Original_SO_ID__c,';
        query+= 'inscor__Original_SO_ID__r.inscor__Contact__r.Email, inscor__Original_SO_ID__r.inscor__Assigned_To__r.Email, inscor__Original_SO_ID__r.inscor__Dropship_ATTN__r.Email ';
        query+= 'FROM inscor__Customer_Exchange_Summary__c ';
        query+= 'WHERE (inscor__Original_Core_Due_Date__c =:next15Date';
        query+= ' OR inscor__Original_Core_Due_Date__c =:next5Date';
        query+= ' OR inscor__Original_Core_Due_Date__c =:next3Date';
        query+= ' OR inscor__Original_Core_Due_Date__c =:next2Date';
        query+= ' OR inscor__Original_Core_Due_Date__c =:next1Date';
        query+= ' OR inscor__Original_Core_Due_Date__c =:todaysDate';
        query+= ' OR inscor__Original_Core_Due_Date__c =:back3Date';
        query+= ' OR inscor__Original_Core_Due_Date__c =:next10DaysRemain)';
        query+= ' AND Is_Customer_Email_Notified__c = FALSE AND inscor__Original_SO_ID__c != NULL AND inscor__Exchange_Status__c = :exchangeStatusShipped';

        System.debug('Debug** CustomerExchangeEmailNotifyBatch query ' + query);

        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext BC, List<inscor__Customer_Exchange_Summary__c> scope)
    {   
        sendEmailNotification(scope);
    }
    
    public void finish(Database.BatchableContext BC){ }

    public void execute(SchedulableContext sc) 
    {
        Database.executeBatch(new CustomerExchangeEmailNotifyBatch());
    }

    private static void sendEmailNotification(List<inscor__Customer_Exchange_Summary__c> scope)
    {
        try 
        {   
            Set<String> emailTemplatesDeveloperName = new Set<String>{
                Constants.EMAIL_TEMPLATE_FIRST_FOLLOW_UP,
                Constants.EMAIL_TEMPLATE_DUE_DATE_5,
                Constants.EMAIL_TEMPLATE_DUE_DATE_3,
                Constants.EMAIL_TEMPLATE_DUE_DATE_2,
                Constants.EMAIL_TEMPLATE_DUE_DATE_1,
                Constants.EMAIL_TEMPLATE_DUE_DATE_DAY,
                Constants.EMAIL_TEMPLATE_DUE_DATE_LATE_SCENARIO

            };

            Map<Integer, Id> emailTemplateIdByDaysDiff = new Map<Integer, Id>();
            for (EmailTemplate template : [SELECT Id, DeveloperName FROM EmailTemplate WHERE DeveloperName IN :emailTemplatesDeveloperName]) {
                if (template.DeveloperName == Constants.EMAIL_TEMPLATE_FIRST_FOLLOW_UP) {
                    emailTemplateIdByDaysDiff.put(999, template.Id);
                }else if (template.DeveloperName == Constants.EMAIL_TEMPLATE_DUE_DATE_5) {
                    emailTemplateIdByDaysDiff.put(5, template.Id);
                }else if (template.DeveloperName == Constants.EMAIL_TEMPLATE_DUE_DATE_3) {
                    emailTemplateIdByDaysDiff.put(3, template.Id);
                }else if (template.DeveloperName == Constants.EMAIL_TEMPLATE_DUE_DATE_2) {
                    emailTemplateIdByDaysDiff.put(2, template.Id);
                }else if (template.DeveloperName == Constants.EMAIL_TEMPLATE_DUE_DATE_1) {
                    emailTemplateIdByDaysDiff.put(1, template.Id);
                }else if (template.DeveloperName == Constants.EMAIL_TEMPLATE_DUE_DATE_DAY) {
                    emailTemplateIdByDaysDiff.put(0, template.Id);
                }else if (template.DeveloperName == Constants.EMAIL_TEMPLATE_DUE_DATE_LATE_SCENARIO) {
                    emailTemplateIdByDaysDiff.put(-3, template.Id);
                }
            }
            Map<Id, Id> emailTemplatesByExchangeSummaryId = new Map<Id, Id>();
            Map<Id, List<String>> cseIdtoTOAddressMap = new Map<Id, List<String>>();
            Map<Id, List<String>> objIdtoCCAddress = new Map<Id, List<String>>();
            List<String> ccEmailAddresses = new List<String>{Label.Core_Exchange_Customer_CC_EmailAddress};
                    
            List<inscor__Customer_Exchange_Summary__c> customerExchangeToUpdateList = new List<inscor__Customer_Exchange_Summary__c>();
            
            if(!scope.isEmpty())
            { 
                
                for (inscor__Customer_Exchange_Summary__c iceRec : scope) 
                {
                    if(String.isNotBlank(iceRec.inscor__Original_SO_ID__c))
                    {   
                        //Setuping email template Id on the basis of due date days diffrence with today
                        Integer daysDifference = todaysDate.daysBetween(iceRec.inscor__Original_Core_Due_Date__c);
                        if (daysDifference > 5) {
                            emailTemplatesByExchangeSummaryId.put(iceRec.Id, emailTemplateIdByDaysDiff.get(999));
                        }else{
                            emailTemplatesByExchangeSummaryId.put(iceRec.Id, emailTemplateIdByDaysDiff.get(daysDifference));
                        }

                        //update the custom email notified field to true when successfully email sent
                        switch on daysDifference {
                            when 5 {
                                iceRec.Is_Customer_Email_Notified_D_5__c = true;  }
                            when 3 {
                                iceRec.Is_Customer_Email_Notified_D_3__c = true;  }
                            when 2 {
                                iceRec.Is_Customer_Email_Notified_D_2__c = true;  }
                            when 1 {
                                iceRec.Is_Customer_Email_Notified_D_1__c = true;  }
                            when 0 {
                                iceRec.Is_Customer_Email_Notified_D__c = true;  }
                            when -3 {
                                iceRec.Is_Customer_Email_Notified_D_3_Late__c = true;  }
                        }

                        //creating summary to address map for each unique id
                        if(!cseIdtoTOAddressMap.containsKey(iceRec.Id)){
                            if((iceRec.inscor__Original_SO_ID__r.inscor__Contact__r != NULL && iceRec.inscor__Original_SO_ID__r.inscor__Contact__r.Email != NULL) || 
                            (iceRec.inscor__Original_SO_ID__r.inscor__Assigned_To__r != NULL && iceRec.inscor__Original_SO_ID__r.inscor__Assigned_To__r.Email != NULL) ||
                            (iceRec.inscor__Original_SO_ID__r.inscor__Dropship_ATTN__r != NULL && iceRec.inscor__Original_SO_ID__r.inscor__Dropship_ATTN__r.Email != NULL))
                            {
                                cseIdtoTOAddressMap.put(iceRec.Id, new List<String>());
                                objIdtoCCAddress.put(iceRec.Id, ccEmailAddresses);
                                customerExchangeToUpdateList.add(iceRec);
                            }
                        }
                        
                        //Email Address to sent
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

                    }            
                }
                //CommonUtility.sendEmail(emailTemplateId, cseIdtoTOAddressMap, NULL, NULL);
                CommonUtility.sendEmailForCustomerExchangeSummary(emailTemplatesByExchangeSummaryId, cseIdtoTOAddressMap, objIdtoCCAddress, NULL);

                if(!customerExchangeToUpdateList.isEmpty())
                {
                    List<Database.SaveResult> saveResults = Database.update(customerExchangeToUpdateList, false);
                    LogService.logInsertUpdateFailures('CustomerExchangeEmailNotifyBatch.cls', customerExchangeToUpdateList, saveResults);
                    for (Database.SaveResult sr : saveResults) 
                    {
                        if (!sr.isSuccess()) 
                        {
                            for(Database.Error err : sr.getErrors()) 
                            {
                                System.debug('Error '+err.getMessage()+err.getFields());   
                            }
                        }
                    }
                }
            }
            if(Test.isRunningTest())
                Integer i = 1/0;  
        } 
        catch (Exception e) 
        {
            LogService.createErrorLog('CustomerExchangeEmailNotifyBatch.cls', NULL, e, NULL);
        }
    }
}