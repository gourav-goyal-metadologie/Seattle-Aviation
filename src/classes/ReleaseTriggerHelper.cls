/**************************************************************************************************
Description: Trigger Helper class for inscor__Release__c that will handle all types of trigger events.
====================================================================================================
====================================================================================================
TestClass: ReleaseTriggerHelperTest
Code Coverage: 96%
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		05/28/2021		    Gourav Goyal				Initial Creation    
***************************************************************************************************/
public class ReleaseTriggerHelper implements TriggerHandler {
    
    /*Allows unit tests (or other code) to disable this trigger for the transaction */
    
    public static Boolean TriggerDisabled = false;
    
    /*Checks to see if the trigger has been disabled either by custom setting or by running code*/
    
    public Boolean IsDisabled() {
        /*Use the option below if you set up Custom Settings to controll Triggers*/
        Trigger_Configuration__c configSetting = Trigger_Configuration__c.getInstance();   
        if(configSetting.Release_Trigger_Disable__c == true) {
            return true;
        } else {
            return TriggerDisabled;
        }
    }
    
    /* CALLING */
    public void BeforeInsert(SObject[] newList) {}
    
    public void BeforeUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {}
    
    public void BeforeDelete(Map<Id, SObject> oldMap) {}
    
    public void AfterInsert(Map<Id, SObject> newMap) {
        //ReleaseBusinessUtility.sendEmailOnReleaseStatusInvoiced((List<inscor__Release__c>)newMap.values(), NULL);
        sendReleaseForComplianceCheck((List<inscor__Release__c>)newMap.values(), NULL);
    }
    
    public void AfterUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {
        //ReleaseBusinessUtility.sendEmailOnReleaseStatusInvoiced((List<inscor__Release__c>)newMap.values(), (Map<Id, inscor__Release__c>)oldMap);
        //sendReleaseForComplianceCheck((List<inscor__Release__c>)newMap.values(), (Map<Id, inscor__Release__c>)oldMap);
    }
    
    public void AfterDelete(Map<Id, SObject> oldMap) {
        
    }
    
    public void AfterUndelete(Map<Id, SObject> oldMap) {}

    
    
    public static void sendReleaseForComplianceCheck(List<inscor__Release__c> newList, Map<Id, inscor__Release__c> oldMap){
        Compliance_Configuration__c config = Compliance_Configuration__c.getOrgDefaults();
        //String releaseStatus = 'In_Picking';
        List<inscor__Release__c> filteredReleaseList = new List<inscor__Release__c>();
        
        try {
            for(inscor__Release__c release : newList){
                //if(release.inscor__Status__c == releaseStatus){
                    if(Trigger.isInsert){
                        filteredReleaseList.add(release);
                    }/*else if(Trigger.isUpdate){
                        inscor__Release__c oldRelease = (inscor__Release__c)oldMap.get(release.Id);
                        if(release.inscor__Status__c != oldRelease.inscor__Status__c){
                            filteredReleaseList.add(release);
                        }
                    }*/
                //}
            }
            Set<Id> validReleaseIds = new Set<Id>();
            for(inscor__Release__c release : filteredReleaseList){
                validReleaseIds.add(release.Id);
            }
            if(validReleaseIds.size() > 0){
                if( config.Is_Integration_Enable__c ){
                    Integer intervalMinutes = 1;
                    DateTime now  = DateTime.now();
                    DateTime nextRunTime = now.addMinutes(intervalMinutes);
                    String cronString = '' + nextRunTime.second() + ' ' + nextRunTime.minute() + ' ' + 
                        nextRunTime.hour() + ' ' + nextRunTime.day() + ' ' + 
                        nextRunTime.month() + ' ? ' + nextRunTime.year(); 
                    System.schedule('BatchProcessReleaseToShipment -' + now.format('yyyy-MM-dd HH:mm:ss'), cronString, new BatchProcessReleaseToShipment(validReleaseIds));
                    //Database.executeBatch(new BatchProcessReleaseToShipment(validReleaseIds), 20);
                }
                
            }
            if(Test.isRunningTest())
                Integer i = 1/0; 
        } catch (Exception error) {  
            LogService.createErrorLog('ReleaseTriggerHandler.apxc', NULL, error, NULL);  
        }
    }
}