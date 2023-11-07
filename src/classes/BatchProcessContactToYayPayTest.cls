@isTest
private class BatchProcessContactToYayPayTest {
	
    @testSetup()
    private static void setup(){
        Test.setMock(HttpCalloutMock.class, new YayPayMockResponseGenerator());
		Account acc = new Account();
        acc.Name ='Test Account 10 August';
        insert acc;
        
        Contact con = new Contact();
        con.FirstName ='Test';
        con.LastName ='Contact';
        con.AccountId = acc.Id;
        con.Email ='test@etst.com';
        con.inscor__Contact_Options__c ='Receive Invoice';
        insert con;
        
        YayPay_Configuration__c yayPayConfigSetting = YayPay_Configuration__c.getOrgDefaults();   
        yayPayConfigSetting.EndPoint__c = 'https://developer.yaypay.com/api/v1/token';
        yayPayConfigSetting.Transaction_End_Time__c = 10;
        yayPayConfigSetting.Records_To_Query_Batch__c = '10';
        yayPayConfigSetting.Batch_Interval_Minutes__c = 10;
        yayPayConfigSetting.Is_Integration_Enable__c = true;
        yayPayConfigSetting.Client_Key__c = '45q70fmc8n1agi258vhnaoh99e';
        yayPayConfigSetting.Client_Secret__c = '1mqaafklenu997svqlcv8j7u5cifhchdbifd4fdopc759lejmj0';
        upsert yayPayConfigSetting;
        
    }    
    
    @isTest
    static void batchWithoutParamTest() {
       
        Account acc = [ SELECT Id FROM Account LIMIT 1];
        Contact con = [ SELECT Id FROM Contact LIMIT 1];
       
        Test.setMock(HttpCalloutMock.class, new YayPayMockResponseGenerator());
        Test.startTest();
        BatchProcessContactToYayPay  batchObj = new BatchProcessContactToYayPay();
        Database.executeBatch( batchObj );
        Test.stopTest();
    } 
    
    @isTest
    static void batchWithParamTest() {
        
        Account acc = [ SELECT Id FROM Account LIMIT 1];
        Contact con = [ SELECT Id FROM Contact LIMIT 1];
        
        Test.setMock(HttpCalloutMock.class, new YayPayMockResponseGenerator());
        Test.startTest();
        BatchProcessContactToYayPay  batchObj = new BatchProcessContactToYayPay(  new set<Id>{ con.Id });
        Database.executeBatch( batchObj );
        Test.stopTest();
    } 
    @isTest
    static void batchWithUpdateParamTest() {
        
        Account acc = [ SELECT Id FROM Account LIMIT 1];
        Contact con = [ SELECT Id FROM Contact LIMIT 1];
        
        Account acc02 = new Account();
        acc02.Name ='Batch With Param';
        insert acc02;
        
        Test.setMock(HttpCalloutMock.class, new YayPayMockResponseGenerator());
        con.AccountId = acc02.Id;
        update con;
        Test.startTest();
        Test.stopTest();
    } 
    @isTest
    static void batchWithDeleteParamTest02() {
        
        Account acc = [ SELECT Id FROM Account LIMIT 1];
        Contact con = [ SELECT Id FROM Contact LIMIT 1];
        
        Test.setMock(HttpCalloutMock.class, new YayPayMockResponseGenerator());
        delete con;
        Test.startTest();
        
        Test.stopTest();
    } 
    @isTest
    static void batchWithDeleteParamTest() {
        
        Account acc = [ SELECT Id FROM Account LIMIT 1];
        Contact con = [ SELECT Id FROM Contact LIMIT 1];
        
        Test.setMock(HttpCalloutMock.class, new YayPayMockResponseGenerator());
        Test.startTest();
        try{
            YayPayRequestHelper.deleteItemRequestJSON( New List<String>{ con.Id }, 'CONTACTS' );
        }
        catch( exception e ){
            system.assert( false, e );
        }
        
        Test.stopTest();
    } 
}