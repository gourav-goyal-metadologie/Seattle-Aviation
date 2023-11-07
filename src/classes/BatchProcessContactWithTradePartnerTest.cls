@isTest
private class BatchProcessContactWithTradePartnerTest {
	
    @testSetup()
    private static void setup(){

        Compliance_Configuration__c complianceConfigSetting = Compliance_Configuration__c.getOrgDefaults();   
        complianceConfigSetting.EndPoint__c = 'https://text-azservices.ecustoms.com/edwinimport/EdwinImportPortal.asmx';
        complianceConfigSetting.Shipment_Status_Action__c = 'http://test-tempuri.org/GetShipmentStatus';
        complianceConfigSetting.Upload_File_Action__c = 'http://test-tempuri.org/Uploadfile';
        upsert complianceConfigSetting;
        
        //Create a Account for Customer
        Account accRec = new Account();
        accRec.Name = 'TEST';
        accRec.inscor__Account_Number__c = '2';  
        accRec.ShippingStreet = '2';  
        accRec.ShippingCity = 'Test';  
        accRec.ShippingCountry = 'US';  
        accRec.ShippingState = 'State';  
        accRec.ShippingPostalCode = '111111';  
        accRec.Phone = '8888888888';  
        insert accRec;

      	Contact conRec = new Contact();
        conRec.LastName ='Test Contact';
        conRec.AccountId =accRec.Id;
        conRec.Phone = '8888888';
        conRec.Email ='test@fgjg.com';
        conRec.Title ='Test Contact Title';
        conRec.LastName ='Test Contact';
        conRec.LastName ='Test Contact';
        insert conRec;
    }    
    
    @isTest
    static void batchWithParamTest() {
        Test.setMock(HttpCalloutMock.class, new ComplianceMockResponseGenerator());
        Test.startTest();
        	List<Contact> contactList = [SELECT Id from Contact];
        Database.executeBatch(new BatchProcessContactWithTradePartner(new Set<Id>{contactList[0].Id}), 200);
        Test.stopTest();
        contactList = [SELECT Id, Compliance_Response__c from Contact where Id =: contactList[0].Id];
        system.assertNotEquals(null, contactList[0].Compliance_Response__c);
    } 
    
    
    @isTest
    static void batchWithoutParamTest() {
        Test.startTest();
        	Database.executeBatch(new BatchProcessContactWithTradePartner(), 200);
        Test.stopTest();
        List<Contact> contactList = [SELECT Id, Compliance_Status__c from Contact];
        system.assertNotEquals(null, contactList[0].Compliance_Status__c);
    }
}