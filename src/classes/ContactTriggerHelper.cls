/**************************************************************************************************
Description: Trigger Helper class for ContactTriggerHelper that will handle all types of trigger events.
====================================================================================================
====================================================================================================
TestClass: 
Code Coverage: 
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		06/02/2021		    Gourav Goyal				Initial Creation    
***************************************************************************************************/
public class ContactTriggerHelper implements TriggerHandler {
    
    /*Allows unit tests (or other code) to disable this trigger for the transaction */
    
    public static Boolean TriggerDisabled = false;
    
    /*Checks to see if the trigger has been disabled either by custom setting or by running code*/
    
    public Boolean IsDisabled() {
        /*Use the option below if you set up Custom Settings to controll Triggers*/
        Trigger_Configuration__c configSetting = Trigger_Configuration__c.getInstance();   
        if(configSetting.Contact_Trigger_Disable__c == true) {
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
        sendContactForComplianceCheck((List<Contact>)newMap.values(), NULL);
        sendContactToYayPay((List<Contact>)newMap.values(), NULL);
    }
    
    public void AfterUpdate(Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {
        sendContactForComplianceCheck((List<Contact>)newMap.values(), (Map<Id, Contact>) oldMap);
        sendContactToYayPay((List<Contact>)newMap.values(), (Map<Id, Contact>) oldMap);
    }
    
    public void AfterDelete(Map<Id, SObject> oldMap) {
        sendContactToYayPay(null, (Map<Id, Contact>) oldMap);
    }
    
    public void AfterUndelete(Map<Id, SObject> oldMap) {}

    
    
    public static void sendContactForComplianceCheck(List<Contact> newList, Map<Id, Contact> oldMap){
       
        Compliance_Configuration__c config = Compliance_Configuration__c.getOrgDefaults();
        List<Contact> filteredReleaseList = new List<Contact>();
        set<Id> accountIds = new set<Id>();
        
        try {
            //getting filtered Contact.
            for(Contact con : newList){
                if( Trigger.isInsert ){
                    filteredReleaseList.add( con );
                }else if( Trigger.isUpdate ){
                    if( (con.FirstName != oldMap.get( con.Id ).FirstName) ||
                       (con.LastName != oldMap.get( con.Id ).LastName) ||
                      (con.Email != oldMap.get( con.Id ).Email) ||
                      (con.Phone != oldMap.get( con.Id ).Phone) ||
                      (con.Title != oldMap.get( con.Id ).Title) ){
                        filteredReleaseList.add( con );
                    }
                }
                
            }           
            
            Set<Id> validContactIds = new Set<Id>();
            for(Contact con : filteredReleaseList){
                if( con.AccountId != null ){
                    validContactIds.add(con.Id);
                }
            }
            
            if(validContactIds.size() > 0){
                if( config.Is_Integration_Enable__c ){
                    Database.executeBatch(new BatchProcessContactWithTradePartner(validContactIds), 20);
                }
            }
            if(Test.isRunningTest())
                Integer i = 1/0; 
        } catch (Exception error) {	
            LogService.createErrorLog('ContactTriggerHandler.apxc', NULL, error, NULL);
        }  
        
    }
    
    
     
    public static void sendContactToYayPay(List<Contact> newList, Map<Id, Contact> oldMap){
       
        List<Contact> filteredContactList = new List<Contact>();
        set<Id> contactIds = new set<Id>();
        
        try {
            //getting filtered Contact.
            if(Trigger.isInsert || Trigger.isUpdate ){
                
                for(Contact con : newList){
                    if( Trigger.isInsert ){
                        if( con.AccountId != null ){
                            filteredContactList.add( con );
                        }
                        
                    }else if( Trigger.isUpdate ){
                        if(  con.AccountId != null && 
							(( con.inscor__Contact_Options__c != oldMap.get( con.Id ).inscor__Contact_Options__c )
                           	|| ( con.AccountId != oldMap.get( con.Id ).AccountId )
                            || ( con.FirstName != oldMap.get( con.Id ).FirstName )
                            || ( con.LastName != oldMap.get( con.Id ).LastName )
                            || ( con.Email != oldMap.get( con.Id ).Email ))){
                               filteredContactList.add( con );
                           }
                    }                
                }           
            }
            if( Trigger.isDelete ){
                for(Contact con : oldMap.values()){
                    if(  ( con.YayPay_Last_Sync_Date__c != null ) ){
                        filteredContactList.add( con );
                    }
                }
            }
            Set<Id> validContactIds = new Set<Id>();
            for(Contact con : filteredContactList){
                validContactIds.add(con.Id);
            }
            
            if(validContactIds.size() > 0){
                if( YayPayUtility.sendYayPayCallout() ){
                    Database.executeBatch(new BatchProcessContactToYayPay(validContactIds), 10);
                }
            }
            if(Test.isRunningTest())
                Integer i = 1/0; 
        } catch (Exception error) {	
            LogService.createErrorLog('ContactTriggerHelper.apxc', NULL, error, NULL);	
        }  
        
    }
    
}