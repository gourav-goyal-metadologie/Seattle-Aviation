public with sharing class AlternateController {
    @AuraEnabled(cacheable=true)
    public static List<inscor__Alternate__c> AlternateProduct(string ProductId) {
        system.debug('ProductId'+ ProductId);
        List<inscor__Alternate__c> AlternateProductList = New List<inscor__Alternate__c>([SELECT Name, Id, inscor__Primary_Product__c,inscor__Primary_Product__r.Name FROM 
        inscor__Alternate__c where inscor__Alternate_Product__c= :ProductId]);
        system.debug('AlternateProductList' + AlternateProductList);
        return AlternateProductList;
    }
}