public with sharing class GetPreferredShipAccountNumber {
    @AuraEnabled(cacheable=true)
    public static String getPreferredShipAccountNumberDetails(){
        String preferredShipAccount = '';
        try {
            String userId = UserInfo.getUserId();
            List<User> userDetails = [Select AccountId,Contact.AccountId from user where id= :userId];
            if(userDetails!=null && !userDetails.isEmpty()) {
                String accountId = userDetails[0].AccountId;
                if(accountId!=null && accountId != ''){
                    system.debug('accountId: '+accountId);
                    List<Account> accountList = [Select id,inscor__Preferred_Ship_Account__c from Account where id= :accountId];
                    system.debug('accountList: '+accountList);
                    if(accountList!=null && !accountList.isEmpty()){
                        preferredShipAccount = accountList[0].inscor__Preferred_Ship_Account__c;
                    }
                }
            }
            return preferredShipAccount;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}