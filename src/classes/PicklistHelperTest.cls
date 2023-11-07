@IsTest
private class PicklistHelperTest {

    @IsTest 
   static void getDependentMapTest() {
       Test.startTest();
       PicklistHelper.getDependentMap(new Knowledge__c(), 'Group_Category__c', 'Article_Category__c');
       Test.stopTest();
   }
}