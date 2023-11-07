@isTest(SeeAllData=True)
public class ApnInventoryTest {
   @isTest 
    static void apnInventoryTriggerTest() {
        try {
                System.debug('inventory');
                inscor__Inventory_Line__c inventory = [SELECT Id, Name, inscor__Quantity__c FROM inscor__Inventory_Line__c LIMIT 1];
                inscor__Inventory_Line__c inventory2 =  new inscor__Inventory_Line__c(Id=inventory.Id, inscor__Quantity__c=inventory.inscor__Quantity__c + 1);
                System.debug(inventory);
                System.debug(inventory2);
        
                Test.setMock(HttpCalloutMock.class, new ApnMockHttpResponseGenerator());
                Test.startTest();
                update inventory2;
                update inventory;
                Test.stopTest();
        }
        catch (Exception  e){
    	    System.debug('The following exception has occurred in Webhook.jsonContent' + e);
      	}
    }
}