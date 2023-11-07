/**************************************************************************************************
Description: Trigger Helper class for Product2 that will handle all types of trigger events.
====================================================================================================
====================================================================================================
TestClass: -
Code Coverage: -
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		06/02/2021		    Gourav Goyal				Initial Creation    
***************************************************************************************************/
public class ProductTriggerHelper implements TriggerHandler {
    
    /*Allows unit tests (or other code) to disable this trigger for the transaction */
    
    public static Boolean TriggerDisabled = false;
    
    /*Checks to see if the trigger has been disabled either by custom setting or by running code*/

    public static Boolean skipDuplicatePartNumberCheck = false;

    public Boolean IsDisabled() {
        /*Use the option below if you set up Custom Settings to controll Triggers*/
        Trigger_Configuration__c configSetting = Trigger_Configuration__c.getInstance();   
        if(configSetting.Product_Trigger_Disable__c == true) {
            return true;
        } else {
            return TriggerDisabled;
        }
    }
    
    /* CALLING */
    public void BeforeInsert(SObject[] newList) {
        setDefaultFields(newList);
    }
    
    public void BeforeUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {
        populateDefaultValuesOnUpdate((List<Product2>)newMap.values(), (Map<Id, Product2>)oldMap);
    }
    
    public void BeforeDelete(Map<Id, SObject> oldMap) {}
    
    public void AfterInsert(Map<Id, SObject> newMap) {
        if(!skipDuplicatePartNumberCheck) {
            //ProductUtility.checkForExistingPartNumber((Map<Id, Product2>)newMap);
        }
        sendProductForComplianceCheck((List<Product2>)newMap.values(), NULL);
    }
    
    public void AfterUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {
        if( !(system.isBatch() || system.isFuture()) ){
            sendProductForComplianceCheck((List<Product2>)newMap.values(), (Map<Id, Product2>)oldMap );
        }
    	
    }
    
    public void AfterDelete(Map<Id, SObject> oldMap) {
        
    }
    
    public void AfterUndelete(Map<Id, SObject> oldMap) {
        
    }    
    
    public static void sendProductForComplianceCheck(List<Product2> newList, Map<Id, Product2> oldMap){
       
        Compliance_Configuration__c config = Compliance_Configuration__c.getOrgDefaults();
        list<Product2> filteredProduct2List = new list<Product2>();
        
        try {
            //For filter products.
            for(Product2 product : newList){
                if(Trigger.isInsert){
                    filteredProduct2List.add(product);
                }else if( Trigger.isUpdate ){
                    if( ( product.Name != oldMap.get( product.Id ).Name ) ||
                      ( product.inscor__Keyword__c != oldMap.get( product.Id ).inscor__Keyword__c ) ||
                      ( product.inscor__Description__c != oldMap.get( product.Id ).inscor__Description__c ) ||
                      ( product.inscor__Country_of_Origin__c != oldMap.get( product.Id ).inscor__Country_of_Origin__c ) ||
                      ( product.inscor__HazMat__c != oldMap.get( product.Id ).inscor__HazMat__c ) ||
                      ( product.inscor__HazMat_Id__c != oldMap.get( product.Id ).inscor__HazMat_Id__c ) ||
                      ( product.IsActive != oldMap.get( product.Id ).IsActive ) ){
                          filteredProduct2List.add(product);
                    }
                }
            }
            
            Set<Id> validProductIds = new Set<Id>();
            //for getting only valid products to processs.
            for(Product2 product : filteredProduct2List){
                validProductIds.add(product.Id);
            }
            //System.assert( false, validProductIds );
            if(validProductIds.size() > 0){
                if( config.Is_Integration_Enable__c ){
                    Database.executeBatch(new BatchProcessProductToItems(validProductIds), 20);
                }
            }
            if(Test.isRunningTest())
                Integer i = 1/0; 
        } catch (Exception error) {	
            LogService.createErrorLog('ProductTriggerHandler.apxc', NULL, error, NULL);	
        }  
        
    }
    
    
    public static void setDefaultFields(List<Product2> newList){
        String alphaNumericRegEx = '[^a-zA-Z0-9]';
        
        for(Product2 product : newList){
            if(String.isBlank(product.inscor__Country_of_Manufacture__c)){
                product.inscor__Country_of_Manufacture__c = 'US';
            }
            if(String.isBlank(product.inscor__Country_of_Origin__c)){
                product.inscor__Country_of_Origin__c = 'US';
            }
            
            // Set the Unique Part Number by removing the special characters
            product.Unique_Part_Number__c = product.Name.replaceAll(alphaNumericRegEx, '');
        }
    }
    
    public static void populateDefaultValuesOnUpdate(List<Product2> newList, Map<Id, Product2> oldMap) {
        String alphaNumericRegEx = '[^a-zA-Z0-9]';
        
        for(Product2 product : newList){
            if(product.Unique_Part_Number__c == null
               || (product.Name != oldMap.get(product.Id).Name)
            )
            // Set the Unique Part Number by removing the special characters
            product.Unique_Part_Number__c = product.Name.replaceAll(alphaNumericRegEx, '');
        }
    }
    
}