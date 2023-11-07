@isTest
private class BatchProcessReleaseToShipmentTest {
	
    @testSetup()
    private static void setup(){
		
        Test.setMock(HttpCalloutMock.class, new ComplianceMockResponseGenerator());
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
        
        inscor__Company__c companyInstance = new inscor__Company__c();
        companyInstance.inscor__Company_Name__c = 'inscor Company' ;
        companyInstance.inscor__Address_1__c = 'address';
        companyInstance.inscor__City__c = 'xyz';
        companyInstance.inscor__Zip_Code__c = '21321';
        insert companyInstance;
        
        inscor__Customer_Quote__c customerQuoteRec = new inscor__Customer_Quote__c();
        customerQuoteRec.inscor__Customer__c = accRec.Id;
        customerQuoteRec.inscor__Status__c = 'New';
        customerQuoteRec.inscor__Company__c = companyInstance.Id;
        insert customerQuoteRec;
        
        inscor__Sales_Order__c salesOrderRec = new inscor__Sales_Order__c();
        salesOrderRec.inscor__Quote_Number__c = customerQuoteRec.Id;
        salesOrderRec.inscor__Customer__c = accRec.Id;
        salesOrderRec.inscor__Company__c = companyInstance.Id;
        insert salesOrderRec;
        
        Product2 productRec = new Product2(Name = 'Laptop X200', 
                                     Family = 'Hardware', inscor__Keyword__c ='test');
        insert productRec;
        
        inscor__Condition_Code__c conditionCode = new inscor__Condition_Code__c(Name ='Condition Code 1', inscor__Show_in_Summary__c = false);
		insert conditionCode;
        
        inscor__Sales_Order_Line__c salesOrderLineRec = new inscor__Sales_Order_Line__c();
        salesOrderLineRec.inscor__Order__c = salesOrderRec.Id;
        salesOrderLineRec.inscor__Condition_Code__c = conditionCode.Id;
        salesOrderLineRec.inscor__Quantity_Ordered__c = 10;
        salesOrderLineRec.inscor__Product__c = productRec.Id;
        insert salesOrderLineRec;
        
        inscor__Account_Ship_Address__c addRec = new inscor__Account_Ship_Address__c();
        insert addRec;
        
        inscor__Release__c releaseRec = new inscor__Release__c();
        releaseRec.inscor__Ship_To_Address__c = addRec.Id;
        releaseRec.inscor__Sales_Order__c = salesOrderRec.Id;
        
        insert releaseRec;
        
        inscor__Release_Line__c releaseLineRec = new inscor__Release_Line__c();
        releaseLineRec.inscor__Release__c = releaseRec.Id;
        releaseLineRec.inscor__Sales_Order_Line__c = salesOrderLineRec.Id;
        insert releaseLineRec;
    }    
    
    @isTest
    static void batchWithParamTest() {
        Test.setMock(HttpCalloutMock.class, new ComplianceMockResponseGenerator());
        Test.startTest();
        	List<inscor__Release__c> inscorList = [SELECT Id from inscor__Release__c];
        Database.executeBatch(new BatchProcessReleaseToShipment(new Set<Id>{inscorList[0].Id}), 200);
        Test.stopTest();
        inscorList = [SELECT Id, Compliance_Response__c from inscor__Release__c where Id =: inscorList[0].Id];
        system.assertNotEquals(null, inscorList[0].Compliance_Response__c);
    } 
    
    @isTest
    static void batchWithoutParamTest() {
        Test.setMock(HttpCalloutMock.class, new ComplianceMockResponseGenerator());
        Test.startTest();
        	Database.executeBatch(new BatchProcessReleaseToShipment(), 200);
        Test.stopTest();
        List<inscor__Release__c> inscorList = [SELECT Id, Shipment_Response__c from inscor__Release__c];
        //system.assertNotEquals(null, inscorList[0].Shipment_Response__c);
    }
    @isTest
    static void batchWithoutParamFailedScenerioTest() {
        Test.setMock(HttpCalloutMock.class, new ComplianceMockResponseGenerator());
        inscor__Release__c inscorRelease = [SELECT Id, Shipment_Response__c, inscor__Sales_Order__c,
                                           	inscor__Sales_Order__r.inscor__Customer__c FROM inscor__Release__c LIMIT 1];
        inscor__Account_Ship_Address__c addRec = new inscor__Account_Ship_Address__c( inscor__Account__c = inscorRelease.inscor__Sales_Order__r.inscor__Customer__c,
                                                                                    inscor__Country__c = 'india');
        insert addRec;
        
        inscorRelease.inscor__Dropship_Site__c = addRec.Id;
        inscorRelease.inscor__Dropship_to_Account__c= inscorRelease.inscor__Sales_Order__r.inscor__Customer__c;
        inscorRelease.inscor__Ship_To_Address__c =null;
        update inscorRelease;
        Test.startTest();
        	Database.executeBatch(new BatchProcessReleaseToShipment(), 200);
        Test.stopTest();
        //system.assertNotEquals(null, inscorList[0].Shipment_Response__c);
    }
    @isTest
    static void pushReleaseToEDMControllerTest() {
        Test.setMock(HttpCalloutMock.class, new ComplianceMockResponseGenerator());
        Test.startTest();
        List<inscor__Release__c> inscorList = [SELECT Id from inscor__Release__c];
        PushReleaseToEDMController.pushReleaseToEDM(inscorList[0].Id);
        Test.stopTest();
    } 
}