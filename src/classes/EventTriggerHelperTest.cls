@isTest
public class EventTriggerHelperTest {
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
        List<Event> eventListToInsert = new List<Event>();
        for(Integer i = 0; i < COUNT_LIMIT; i++){
            Event eventRec = new Event();
            eventRec.WhoId = leadListToInsert[i].Id;
            eventRec.DurationInMinutes = 2;
            eventRec.ActivityDateTime = DateTime.now();
            eventListToInsert.add(eventRec);
        }
        if(eventListToInsert.size() > 0){
            insert eventListToInsert;
        }   
    }
    
    @isTest
    private static void updateLeadProbablityOnInsertTest(){
        Test.startTest();
        List<Event> eventListToQry = new List<Event>([SELECT Id,WhoId FROM Event]);
        system.assertEquals(eventListToQry.size(), COUNT_LIMIT);
        for(Event eventRec : eventListToQry){
            system.assert(eventRec.WhoId != NULL);
        }
        Test.stopTest();
    }
    
    @isTest
    private static void updateLeadProbablityOnUpdateTest(){
        Test.startTest();
        List<Event> eventListToQry = new List<Event>([SELECT Id,WhoId FROM Event]);
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
        system.assertEquals(eventListToQry.size(), COUNT_LIMIT);
        Integer i = 0;
        for(Event eventRec : eventListToQry){
            eventRec.WhoId = leadListToInsert[i].Id;
            i++;
        }
        update eventListToQry;
        system.assertEquals(eventListToQry.size(), COUNT_LIMIT);
        for(Event eventRec : eventListToQry){
            system.assert(eventRec.WhoId != NULL);
        } 
        Test.stopTest();
    }
    
    @isTest
    private static void updateLeadProbablityOnDeleteTest(){
        Test.startTest();
        List<Event> eventListToQry = new List<Event>([SELECT Id,WhoId FROM Event]);
        system.assertEquals(eventListToQry.size(), COUNT_LIMIT);
        delete eventListToQry;
        List<Event> eventListAfterDelete = new List<Event>([SELECT Id,WhoId FROM Event]);
        system.assertEquals(eventListAfterDelete.size(), 0); 
        Test.stopTest();
    }
}