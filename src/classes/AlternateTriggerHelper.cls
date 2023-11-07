public class AlternateTriggerHelper  implements TriggerHandler{
    public static Boolean TriggerDisabled = false;  
    /*Checks to see if the trigger has been disabled either by custom setting or by running code*/
    
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
    }
    
    public void BeforeUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {}
    
    public void BeforeDelete(Map<Id, SObject> oldMap) {}
    
    public void AfterInsert(Map<Id, SObject> newMap) {
        createConditionCodeOnInsert(newMap.keySet());
    }
    
    public void AfterUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {
        updateConditionCodes(newMap.keySet(), (Map<Id, inscor__Alternate__c>)oldMap);
    }
    
    public void AfterDelete(Map<Id, SObject> oldMap) {
        deleteConditionCodes(oldMap.keySet());
    }
    
    public void AfterUndelete(Map<Id, SObject> oldMap) {}


    public static void createConditionCodeOnInsert(Set<Id> alternateIds) {
        List<Condition_Code__c> conditionCodesToInsert = new List<Condition_Code__c>();
        List<inscor__Alternate__c> alternates = [SELECT Id, 
                                                inscor__Alternate_Product__c,
                                                inscor__Alternate_Product__r.NE__c,
                                                inscor__Alternate_Product__r.OH__c,
                                                inscor__Alternate_Product__r.RD__c,
                                                inscor__Alternate_Product__r.SV__c
                                                FROM inscor__Alternate__c 
                                                WHERE Id IN :alternateIds];
        for (inscor__Alternate__c alternate : alternates) {
            if (alternate.inscor__Alternate_Product__c != null) {
                conditionCodesToInsert.addAll(getConditionCodeInstances(alternate));
            }
        }
        if (!conditionCodesToInsert.isEmpty()) {
            insert conditionCodesToInsert;
        }
    }

    public static void updateConditionCodes(Set<Id> alternateIds, Map<Id, inscor__Alternate__c> oldMap) {
        List<Condition_Code__c> conditionCodesToInsert = new List<Condition_Code__c>();
        Set<Id> alternateIdsToDelete = new Set<Id>();
        List<inscor__Alternate__c> alternates = [SELECT Id, 
                                                inscor__Alternate_Product__c,
                                                inscor__Alternate_Product__r.NE__c,
                                                inscor__Alternate_Product__r.OH__c,
                                                inscor__Alternate_Product__r.RD__c,
                                                inscor__Alternate_Product__r.SV__c
                                                FROM inscor__Alternate__c 
                                                WHERE Id IN :alternateIds];
        for (inscor__Alternate__c alternate : alternates) {
            if (alternate.inscor__Alternate_Product__c != oldMap.get(alternate.Id).inscor__Alternate_Product__c){
                alternateIdsToDelete.add(alternate.Id);
                if(alternate.inscor__Alternate_Product__c != null) {
                    conditionCodesToInsert.addAll(getConditionCodeInstances(alternate));
                }
            }
        }
        if (!alternateIdsToDelete.isEmpty()) {
            List<Condition_Code__c> conditionCodesToDelete = [SELECT Id FROM Condition_Code__c WHERE Alternate__c IN : alternateIdsToDelete];
            if (!conditionCodesToDelete.isEmpty()) {
                delete conditionCodesToDelete;
            }
        }
        if (!conditionCodesToInsert.isEmpty()) {
            insert conditionCodesToInsert;
        }
    }

    public static void deleteConditionCodes(Set<Id> alternateIds) {
        List<Condition_Code__c> conditionCodesToDelete = [SELECT Id FROM Condition_Code__c WHERE Alternate__c IN :alternateIds];
        if (!conditionCodesToDelete.isEmpty()) {
            delete conditionCodesToDelete;
        }
    }

    public static List<Condition_Code__c> getConditionCodeInstances(inscor__Alternate__c alternate) {
        List<Condition_Code__c> newCondtionCodes = new List<Condition_Code__c>();
        if (alternate.inscor__Alternate_Product__r.NE__c == false && alternate.inscor__Alternate_Product__r.OH__c == false && alternate.inscor__Alternate_Product__r.RD__c == false && alternate.inscor__Alternate_Product__r.SV__c == false) {
            newCondtionCodes.add(new Condition_Code__c(Name='NE', Part_Master__c = alternate.inscor__Alternate_Product__r.Id, Alternate__c = alternate.Id));
        }else{
            if (alternate.inscor__Alternate_Product__r.NE__c == true) {
                newCondtionCodes.add(new Condition_Code__c(Name = 'NE', Part_Master__c = alternate.inscor__Alternate_Product__r.Id, Alternate__c = alternate.Id));
            }
            if (alternate.inscor__Alternate_Product__r.OH__c == true) {
                newCondtionCodes.add(new Condition_Code__c(Name = 'OH', Part_Master__c = alternate.inscor__Alternate_Product__r.Id, Alternate__c = alternate.Id));
            }
            if (alternate.inscor__Alternate_Product__r.RD__c == true) {
                newCondtionCodes.add(new Condition_Code__c(Name = 'RD', Part_Master__c = alternate.inscor__Alternate_Product__r.Id, Alternate__c = alternate.Id));
            }
            if (alternate.inscor__Alternate_Product__r.SV__c == true) {
                newCondtionCodes.add(new Condition_Code__c(Name = 'SV', Part_Master__c = alternate.inscor__Alternate_Product__r.Id, Alternate__c = alternate.Id));
            }
        }
        return newCondtionCodes;
    }
}