/**************************************************************************************************
Description: Trigger class for Task that will handle all types of trigger events Test Methods.
====================================================================================================
====================================================================================================
Class: TaskTriggerHelperTest
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		05/20/2021		    Gourav Goyal				Initial Creation     
***************************************************************************************************/
@isTest
public class TaskTriggerHelperTest {
    
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
            leadRec.Customer_Conversion_Probablity__c = NULL;
            leadListToInsert.add(leadRec); 
        }
        if(leadListToInsert.size() > 0){
            insert leadListToInsert;
        }
        //Event Insertion
        List<Task> taskListToInsert = new List<Task>();
        for(Integer i = 0; i < COUNT_LIMIT; i++){
            Task taskRec = new Task();
            taskRec.WhoId = leadListToInsert[i].Id;
            taskListToInsert.add(taskRec);
        }
        if(taskListToInsert.size() > 0){
            insert taskListToInsert;
        }   
    }
    
    @isTest
    private static void updateLeadProbablityOnInsertTest(){
        Test.startTest();
        List<Task> taskListToQry = new List<Task>([SELECT Id,WhoId FROM Task]);
        system.assertEquals(taskListToQry.size(), COUNT_LIMIT);
        for(Task taskRec : taskListToQry){
            system.assert(taskRec.WhoId != NULL);
        } 
        Test.stopTest();
    }
    
    @isTest
    private static void updateLeadProbablityOnUpdateTest(){
        Test.startTest();
        List<Task> taskListToQry = new List<Task>([SELECT Id,WhoId FROM Task]);
        List<Lead> leadListToInsert = new List<Lead>();
        for(Integer i = 0; i < COUNT_LIMIT; i++){
            Lead leadRec = new Lead();
            leadRec.FirstName = 'New TEST ' + i;
            leadRec.LastName = 'New Name';
            leadRec.Company = 'New TEST ' + i + ' New Company';
            leadRec.Customer_Conversion_Probablity__c = NULL;
            leadListToInsert.add(leadRec); 
        }
        if(leadListToInsert.size() > 0){
            insert leadListToInsert;
        }
        system.assertEquals(taskListToQry.size(), COUNT_LIMIT);
        Integer i = 0;
        for(Task taskRec : taskListToQry){
            taskRec.WhoId = leadListToInsert[i].Id;
            i++;
        }
        update taskListToQry;
        system.assertEquals(taskListToQry.size(), COUNT_LIMIT);
        for(Task taskRec : taskListToQry){
            system.assert(taskRec.WhoId != NULL);
        }
        Test.stopTest();
    }
    
    @isTest
    private static void updateLeadProbablityOnDeleteTest(){
        Test.startTest();
        List<Task> taskListToQry = new List<Task>([SELECT Id,WhoId FROM Task]);
        system.assertEquals(taskListToQry.size(), COUNT_LIMIT);
        delete taskListToQry;
        List<Task> taskListAfterDelete = new List<Task>([SELECT Id,WhoId FROM Task]);
        system.assertEquals(taskListAfterDelete.size(), 0);
        Test.stopTest();
    }
    
    @isTest
    public static void triggerMethodsTest() { 
        test.StartTest();
        List<Task> recList = new List<Task>([SELECT id FROM Task]);
        test.stopTest();   
        delete recList;
        List<Task> recListToAssert = new List<Task>([SELECT id FROM Task]);
        system.assertEquals(recListToAssert.size(), 0);
        undelete recList;  
    }
    
    @isTest
    public static void triggerDisabledFlagTest() { 
        test.StartTest();
        //Trigger Disabled Coverage
        Trigger_Configuration__c tc = new Trigger_Configuration__c();
        tc.Task_Trigger_Disable__c  = TRUE;
        insert tc;
        test.stopTest(); 
        List<Task> recList = new List<Task>([SELECT id FROM Task]);
        delete recList;
        List<Task> recListToAssert = new List<Task>([SELECT id FROM Task]);
        system.assertEquals(recListToAssert.size(), 0);
    }
}