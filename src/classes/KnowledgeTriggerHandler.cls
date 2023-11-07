public class KnowledgeTriggerHandler {

    public static void updateDefaultProfiles(List<Knowledge__c> newList){
        List<String> profiles = new list<String> { 'Analytics Cloud Integration User','Analytics Cloud Security User','B2BMA Integration User',
                                                    'Chatter External User','Chatter Free User','Chatter Moderator User','Contract Manager',
                                                    'Customer Community Plus Login User','Custom Test Profile','Identity User','Marketing User',
                                                    'Minimum Access - Salesforce','Partner Community User','SalesforceIQ Integration User',
                                                    'Sales Insights Integration User','SAS - Finance User','SAS - Operation User',
                                                    'SAS - Purchasing User','SAS-Shipping User','SAS Standard User','Solution Manager',
                                                    'Standard Platform User','Standard User','System Admin Clone','System Administrator'};
        for(Knowledge__c newKB:newList){
            if(String.isEmpty(newKB.Select_Profile__c)){
                newKB.Select_Profile__c = String.join(profiles,';');
            }
        }
    }
}