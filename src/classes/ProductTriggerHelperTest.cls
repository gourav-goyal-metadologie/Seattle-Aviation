@isTest
private class ProductTriggerHelperTest {
	
    @testSetup()
    private static void setup(){

        Compliance_Configuration__c complianceConfigSetting = Compliance_Configuration__c.getOrgDefaults();   
        complianceConfigSetting.EndPoint__c = 'https://text-azservices.ecustoms.com/edwinimport/EdwinImportPortal.asmx';
        complianceConfigSetting.Shipment_Status_Action__c = 'http://test-tempuri.org/GetShipmentStatus';
        complianceConfigSetting.Upload_File_Action__c = 'http://test-tempuri.org/Uploadfile';
        complianceConfigSetting.Is_Integration_Enable__c = true;
        upsert complianceConfigSetting;
        
    }    
    
    @isTest
    static void batchWithParamTest() {
        Product2 prod = new Product2(Name = 'Laptop X200', 
                                     Family = 'Hardware', inscor__Keyword__c ='test');
        
        
        Test.setMock(HttpCalloutMock.class, new ComplianceMockResponseGenerator());
        Test.startTest();
        insert prod;
        Test.stopTest();
        list<Product2> productList = [SELECT Id, Compliance_Response__c from Product2 where Id =: prod.Id];
        system.assertNotEquals(null, productList[0].Compliance_Response__c);
    } 
    
    
    @isTest
    static void batchWithoutParamTest() {
        Product2 prod = new Product2(Name = 'Test Product 2', 
                                     Family = 'Hardware', inscor__Keyword__c ='test');
        
        
        Test.setMock(HttpCalloutMock.class, new ComplianceMockResponseGenerator());
        Test.startTest();
        insert prod;
        Test.stopTest();
        list<Product2> productList = [SELECT Id, Compliance_Response__c from Product2 where Id =: prod.Id];
        system.assertNotEquals(null, productList[0].Compliance_Response__c);
    }

    @IsTest
    static void testConditionCodes(){
        
        Test.startTest();
        Product2 prod = new Product2(Name = 'Laptop X200', 
                                     Family = 'Hardware', inscor__Keyword__c ='test', NE__c = true);
        insert prod;
        String prodId = prod.Id;

        inscor__Company__c  company = new inscor__Company__c(
            inscor__Address_1__c = '1111', inscor__City__c = '1111', inscor__Company_Name__c = '1111', inscor__Zip_Code__c = '1111');
        insert company;

        inscor__Alternate__c alternate = new inscor__Alternate__c();
        alternate.inscor__Alternate_Product__c = prod.id;
        alternate.inscor__Company__c = company.Id;
        alternate.inscor__Relationship_New__c = 'Superseded By';
        alternate.inscor__Relationship_Other_Side__c = 'Superseded By';
        alternate.inscor__Show_both_sides_in_Part_Research__c = true;
        insert alternate;
        prod.OH__c = true;
        update prod;
        List<Condition_Code__c> conditionCodes = [SELECT Id FROM Condition_Code__c WHERE Part_Master__c = :prod.Id];
        //delete prod; //all condition codes related to it should also deleted
        //ProductTriggerHelper.deleteCondtionCodeOnDelete(new Set<Id>{prod.Id});

        conditionCodes = [SELECT Id FROM Condition_Code__c WHERE Part_Master__c = :prodId];
        Test.stopTest();
        
    }
}