public with sharing class YayPayOtherChargesController {
 
    @AuraEnabled
    public static List<String> getOtherCharges(){
        try {
            List<String> OtherCharges = new List<String>();
             
            List<YayPay_Other_Charges_Configuration__mdt> YayPayOtherCharges = [ SELECT Id, DeveloperName, MasterLabel 
                                                                            FROM YayPay_Other_Charges_Configuration__mdt ];
             
            for( YayPay_Other_Charges_Configuration__mdt meta : YayPayOtherCharges ){
                OtherCharges.add( meta.MasterLabel);
            }
            return OtherCharges;
        } catch (Exception e) {
            System.debug('Exception: '+e.getMessage());
            return null;
        }
    }
    
    @AuraEnabled
    public static AcctSeed__Billing__c getRecord( String recordId ){
        try {
            if( !String.isEmpty(recordId) ){
                AcctSeed__Billing__c relatedBilling = [ SELECT Id, AcctSeed__Billing_Comment__c 
                                                       FROM AcctSeed__Billing__c WHERE Id = :recordId];
                return relatedBilling;
            }
            return null;
        } catch (Exception e) {
            System.debug('Exception: '+e.getMessage());
            return null;
        }
    }
    
    @AuraEnabled
    public static AcctSeed__Billing__c updateBillingComment( String recordId, String selectedCommentValue){
        AcctSeed__Billing__c billingObj = new AcctSeed__Billing__c( Id =recordId, AcctSeed__Billing_Comment__c =selectedCommentValue  );
        update billingObj;
        return billingObj;
    }
}