public class ConvertLeadToCustomerCtrl {
	
    @AuraEnabled
    public static String convertLeadtoCustomer(String recordId){
        List<Lead> leadRecs = [Select Id,Status,Customer__c,Company,ownerId, Email from Lead WHERE ID = : recordId];
        Map<String,Lead_Managment__mdt> leadManagmentSettings = Lead_Managment__mdt.getall();
        if(leadRecs.size() > 0){
            if(leadRecs[0].Customer__c != null){
                leadRecs[0].Status =  leadManagmentSettings.containsKey('Lead_Customer_Status') ? 
                    leadManagmentSettings.get('Lead_Customer_Status').Value__c : 'Customer';
                update leadRecs[0];
                
                return 'Lead Status is Changed and Customer is already Created';
                
            } else{ //Added under SS-205
                String emailDomain = leadRecs.get(0).Email != null ? leadRecs.get(0).Email.split('@').get(1) : null;
                emailDomain = emailDomain != null ? emailDomain.split('\\.').get(0) : null;
                if (emailDomain != null && !validateEmailDomain(emailDomain, leadRecs)) {
                    leadRecs[0].Status =  leadManagmentSettings.containsKey('Lead_Customer_Status') ? 
                        leadManagmentSettings.get('Lead_Customer_Status').Value__C : 'Customer';
                    update leadRecs[0];
                    return 'Account with same email domain is already exist.';
                   
                }else {
                    Account acc = new Account();
                    acc.Name =  leadRecs[0].Company;
                    acc.OwnerId =  leadManagmentSettings.containsKey('Converted_Customer_OwnerId') ? 
                    ( leadManagmentSettings.get('Converted_Customer_OwnerId').Value__c != null ? 
                        leadManagmentSettings.get('Converted_Customer_OwnerId').Value__c : leadRecs[0].ownerId) : leadRecs[0].ownerId;
                    insert acc;
                    leadRecs[0].Status =  leadManagmentSettings.containsKey('Lead_Customer_Status') ? 
                        leadManagmentSettings.get('Lead_Customer_Status').Value__C : 'Customer';
                    leadRecs[0].Customer__c = acc.id;
                    update leadRecs[0];
                    return 'Lead Status is Changed and Customer is Created';
                }
                
            }
        }
        
        return '';
    }

    /**
     * description : method used to check is there already an accout exist with same domain as lead if exist 
     *                 than this account will add with lead if less than 50 Quotes for this customer
     * @author : Vinod Kumar Sharma
     * @date : 09/27/2021
     * createdReason : SS-205
     */
    private static Boolean validateEmailDomain(String emailDomain, List<Lead> leadRecs) {
        Boolean isValid = true;
        List<Account> accounts = [SELECT Id, Name , (select id from inscor__Customer_Quotes__r) FROM Account 
                                    WHERE Name  =:emailDomain];
        if (!accounts.isEmpty() && accounts[0].inscor__Customer_Quotes__r.size() < 50) {
            leadRecs[0].Customer__c = accounts.get(0).Id;
            isValid = false;
        }
        return isValid;
    }
}