@isTest
private class BatchUpdateShipmentStatusTest {
	
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
        insert accRec;
        
        inscor__Company__c  company = new inscor__Company__c(inscor__Address_1__c = '1111', 
                                                             inscor__City__c = '1111', 
                                                             inscor__Company_Name__c = '1111', 
                                                             inscor__Zip_Code__c = '1111');
        insert company;

        inscor__Customer_Quote__c customerQuoteRec = new inscor__Customer_Quote__c();
        customerQuoteRec.inscor__Customer__c = accRec.Id;
        customerQuoteRec.inscor__Status__c = 'New';
        customerQuoteRec.inscor__Company__c = company.Id;
        insert customerQuoteRec;
        
        inscor__Sales_Order__c salesOrderRec = new inscor__Sales_Order__c();
        salesOrderRec.inscor__Quote_Number__c = customerQuoteRec.Id;
        salesOrderRec.inscor__Customer__c = accRec.Id;
        salesOrderRec.inscor__Company__c = company.Id;
        insert salesOrderRec;
                
        inscor__Account_Ship_Address__c addRec = new inscor__Account_Ship_Address__c();
        insert addRec;
        
        inscor__Release__c releaseRec = new inscor__Release__c();
        releaseRec.inscor__Ship_To_Address__c = addRec.Id;
        releaseRec.inscor__Sales_Order__c = salesOrderRec.Id;
        releaseRec.Compliance_Status__c = 'Upload Successful';
        insert releaseRec;
    }    
    
    @isTest
    static void batchWithParamTest() {
        Test.setMock(HttpCalloutMock.class, new ComplianceMockResponseGenerator());
        Test.startTest();
        	List<inscor__Release__c> inscorList = [SELECT Id from inscor__Release__c];
        
        Database.executeBatch(new BatchUpdateShipmentStatus(new Set<Id>{inscorList[0].Id}), 200);
        Test.stopTest();
        inscorList = [SELECT Id, Compliance_Response__c from inscor__Release__c where Id =: inscorList[0].Id];
       //system.assertNotEquals(null, inscorList[0].Compliance_Response__c);
    } 

	@isTest
    static void batchWithParamTest02() {
        Test.setMock(HttpCalloutMock.class, new ComplianceMockResponseGenerator());
        Test.startTest();
        	List<inscor__Release__c> inscorList = [SELECT Id from inscor__Release__c];
        Integer intervalMinutes = 1;
        DateTime now  = DateTime.now();
        DateTime nextRunTime = now.addMinutes(intervalMinutes);
        String cronString = '' + nextRunTime.second() + ' ' + nextRunTime.minute() + ' ' + 
            nextRunTime.hour() + ' ' + nextRunTime.day() + ' ' + 
            nextRunTime.month() + ' ? ' + nextRunTime.year(); 
        System.schedule('BatchUpdateShipmentStatus -' + now.format(), cronString, new BatchUpdateShipmentStatus());
        Test.stopTest();
        inscorList = [SELECT Id, Compliance_Response__c from inscor__Release__c where Id =: inscorList[0].Id];
       //system.assertNotEquals(null, inscorList[0].Compliance_Response__c);
    }     
    
}