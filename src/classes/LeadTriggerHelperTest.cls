/**************************************************************************************************
Description: Trigger class for Task that will handle all types of trigger events Test Methods.
====================================================================================================
====================================================================================================
Class: LeadTriggerHelperTest
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		05/20/2021		    Gourav Goyal				Initial Creation     
***************************************************************************************************/
@isTest
public class LeadTriggerHelperTest {
    public static final Integer COUNT_LIMIT = 10; 
    
    @TestSetup
    private static void setup(){
        //Lead Insertion
        List<Lead> leadListToInsert = new List<Lead>();
        for(Integer i = 0; i < COUNT_LIMIT; i++){
            Lead leadRec = new Lead();
            leadRec.FirstName = 'TEST ' + i;
            leadRec.LastName = 'Name';
            leadRec.Company = 'TEST ' + i + ' Company';
            leadRec.Customer_Conversion_Probablity__c = 'Low';
            leadRec.Conversion_Probablity__c = 50;
            leadListToInsert.add(leadRec); 
        }
        if(leadListToInsert.size() > 0){
            insert leadListToInsert;
        }
    }
    
    @isTest
    private static void updateLeadProbablityStatusOnLeadInsertTest(){
        List<Lead> leadListToQry = new List<Lead>([SELECT Id,Customer_Conversion_Probablity__c FROM Lead]);
        system.assertEquals(leadListToQry.size(), COUNT_LIMIT);
        for(Lead leadRec : leadListToQry){
            system.assertEquals(leadRec.Customer_Conversion_Probablity__c, NULL);
        } 
    }
    
    @isTest
    private static void updateLeadProbablityOnLeadMediumTest(){
        List<Lead> leadListToQry = new List<Lead>([SELECT Id,Customer_Conversion_Probablity__c,Conversion_Probablity__c FROM Lead]);
        system.assertEquals(leadListToQry.size(), COUNT_LIMIT);
        for(Lead leadRec : leadListToQry){
            leadRec.Customer_Conversion_Probablity__c = 'Medium';
        }
        update leadListToQry;
        Map<Id, Lead> leadQryMap = new Map<Id, Lead>([SELECT Id, Customer_Conversion_Probablity__c,Conversion_Probablity__c FROM Lead]);
        for(Lead leadRec : leadListToQry){
            if(leadQryMap != NULL && leadQryMap.containsKey(leadRec.Id)){
                system.assertEquals(leadQryMap.get(leadRec.Id).Conversion_Probablity__c, (leadrec.Conversion_Probablity__c + 30 > 100)?  100 : leadrec.Conversion_Probablity__c + 30);
            }
            
        }    
    }
    
    @isTest
    private static void updateLeadProbablityOnLeadHighTest(){
        List<Lead> leadListToQry = new List<Lead>([SELECT Id,Customer_Conversion_Probablity__c,Conversion_Probablity__c FROM Lead]);
        system.assertEquals(leadListToQry.size(), COUNT_LIMIT);
        for(Lead leadRec : leadListToQry){
            leadRec.Customer_Conversion_Probablity__c = 'High';
        }
        update leadListToQry;
        Map<Id, Lead> leadQryMap = new Map<Id, Lead>([SELECT Id, Customer_Conversion_Probablity__c,Conversion_Probablity__c FROM Lead]);
        for(Lead leadRec : leadListToQry){
            if(leadQryMap != NULL && leadQryMap.containsKey(leadRec.Id)){
                system.assertEquals(leadQryMap.get(leadRec.Id).Conversion_Probablity__c, (leadrec.Conversion_Probablity__c + 50 > 100)?  100 : leadrec.Conversion_Probablity__c + 50);
            }
            
        }    
    }
    
    @isTest
    private static void updateLeadProbablityOnLeadLowTest(){
        List<Lead> leadListToQry = new List<Lead>([SELECT Id,Customer_Conversion_Probablity__c,Conversion_Probablity__c FROM Lead]);
        system.assertEquals(leadListToQry.size(), COUNT_LIMIT);
        for(Lead leadRec : leadListToQry){
            leadRec.Customer_Conversion_Probablity__c = 'Low';
        }
        update leadListToQry;
        Map<Id, Lead> leadQryMap = new Map<Id, Lead>([SELECT Id, Customer_Conversion_Probablity__c,Conversion_Probablity__c FROM Lead]);
        for(Lead leadRec : leadListToQry){
            if(leadQryMap != NULL && leadQryMap.containsKey(leadRec.Id)){
                system.assertEquals(leadQryMap.get(leadRec.Id).Conversion_Probablity__c, (leadrec.Conversion_Probablity__c - 10 > 0)?  leadrec.Conversion_Probablity__c - 10 : 0);
            }
            
        }    
    } 
    
    @isTest
    public static void triggerDisabledFlagTest() { 
        test.StartTest();
        //Trigger Disabled Coverage
        Trigger_Configuration__c tc = new Trigger_Configuration__c();
        tc.Lead_Trigger_Disable__c  = TRUE;
        insert tc;
        test.stopTest(); 
        List<Lead> leadList = new List<Lead>([SELECT id FROM Lead]);
        delete leadList;
        List<Lead> leadListToAssert = new List<Lead>([SELECT id FROM Lead]);
        system.assertEquals(leadListToAssert.size(), 0);
        undelete leadList;
    }
    
    @isTest
    public static void triggerMethodsTest() { 
        test.StartTest();
        List<Lead> leadList = new List<Lead>([SELECT id FROM Lead]);
        delete leadList;
        List<Lead> leadListToAssert = new List<Lead>([SELECT id FROM Lead]);
        system.assertEquals(leadListToAssert.size(), 0);
        undelete leadList;
        test.stopTest();   
    } 
}