@isTest
public class CreateSOTest {
	@isTest
    public static void invokeSO(){
        
         Salesforce_Auth__c objSalesforceAuth = new Salesforce_Auth__c(
            Client_Id__c='test',
            Client_Secret__c='test',
            Login_Url__c='https://test.salesforce.com',
            Password__c='test',
            Security_Token__c='test',
            UserName__c='test');
        insert objSalesforceAuth;
        
        Account objAcc = new Account();
        objAcc.Name = 'Test';
        insert objAcc;
        
        inscor__Account_Ship_Address__c newShippingAddress = new inscor__Account_Ship_Address__c();
        newShippingAddress.inscor__Account__c = objAcc.Id;
        newShippingAddress.inscor__City__c = 'City';
        newShippingAddress.inscor__Country__c = 'country';
        newShippingAddress.inscor__Postal_Code__c = '411HK';
        newShippingAddress.inscor__State__c = 'MH';
        newShippingAddress.inscor__Street__c = 'street';
        newShippingAddress.Name = 'SHIPPING';
        newShippingAddress.Shipping__c = true;
        insert newShippingAddress; 
        
        List<ID> orderList = new List<ID>();
        Order objOrder = new Order();
        objOrder.Status = 'Draft';
        objOrder.AccountId =objAcc.Id;
        objOrder.EffectiveDate = System.today();
        insert objOrder;
        
        Product2 pr = new Product2(Name ='#16',inscor__Keyword__c = 'SCREW',inscor__UOM__c='EA');
        insert pr;
        
        inscor__Company__c  company = new inscor__Company__c(
            inscor__Address_1__c = '1111', inscor__City__c = '1111', inscor__Company_Name__c = '1111', inscor__Zip_Code__c = '1111');
        insert company;
        inscor__Company_Location__c companyLoc = new inscor__Company_Location__c( inscor__Company__c =company.Id );
        insert companyLoc;
        
        inscor__Inventory_Location__c invLocation  = new inscor__Inventory_Location__c(
            inscor__Company_Location__c = companyLoc.Id );
        insert invLocation;
        
        inscor__Owner_Code__c ownerCode = new inscor__Owner_Code__c(inscor__Company__c =company.Id);
        insert ownerCode;
        
        inscor__Warehouse__c warehouse = new inscor__Warehouse__c( 
            inscor__Company_Location__c = companyLoc.Id, inscor__Warehouse_Code__c ='1111' );
        insert warehouse; 
        
        
        inscor__Condition_Code__c code = new inscor__Condition_Code__c();
        code.Name='NE';
        code.inscor__Show_in_Summary__c=false;
        insert code;
        
        orderItem oi = new OrderItem();
        oi.Product2ID = pr.id;
        oi.Condition_Code__c = code.id;
        oi.OrderId = objOrder.Id;
        oi.UnitPrice = 10;
		oi.ListPrice = 10;
		oi.Quantity = 1;  
        oi.Price_Type__c = 'Cost Plus';
        insert oi;
        
        objOrder.Status='Activated';
        update objOrder;
        
        System.debug('oi -> '+oi);
        orderList.add(objOrder.Id);
        String jsonSTR = '{"OrderId":'+JSON.serialize(objOrder)+'}';
        InvokeSOcreationFlow.invokeFlow(orderList);
        CreateSO.justIncrement();
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/CreateSO'; 
        req.httpMethod = 'POST';
        req.addHeader('Content-Type', 'application/json'); 
        //req.requestBody = Blob.valueOf(jsonSTR);
        RestContext.request = req;
        RestContext.response = res;
        test.startTest();
        	Test.setMock(HttpCalloutMock.class, new CustomerquoteTestcontroller());
        	CreateSO.doPost();
        
        test.stopTest();
        /*List<User> uList = new List<User>([SELECT ID FROM User WHERE IsActive = true AND Profile.Name = 'System Admin Clone' Limit 1]);
        System.runAs(uList[0]){        
            test.startTest();
            Test.setMock(HttpCalloutMock.class, new CustomerquoteTestcontroller());            	
                CreateSO.doPost();
            test.stopTest();
        }*/
    }
    
    /*@isTest
    public static void testRestClass(){
        
        
        Account objAcc = new Account();
        objAcc.Name = 'Test';
        insert objAcc;
        
        inscor__Account_Ship_Address__c newShippingAddress = new inscor__Account_Ship_Address__c();
        newShippingAddress.inscor__Account__c = objAcc.Id;
        newShippingAddress.inscor__City__c = 'City';
        newShippingAddress.inscor__Country__c = 'country';
        newShippingAddress.inscor__Postal_Code__c = '411HK';
        newShippingAddress.inscor__State__c = 'MH';
        newShippingAddress.inscor__Street__c = 'street';
        newShippingAddress.Name = 'SHIPPING';
        newShippingAddress.Shipping__c = true;
        insert newShippingAddress; 
        
        List<ID> orderList = new List<ID>();
        Order objOrder = new Order();
        objOrder.Status = 'Draft';
        objOrder.AccountId =objAcc.Id;
        objOrder.EffectiveDate = System.today();
        insert objOrder;
        
        Product2 pr = new Product2(Name ='#16',inscor__Keyword__c = 'SCREW',inscor__UOM__c='EA');
        insert pr;
        
        inscor__Company__c  company = new inscor__Company__c(
            inscor__Address_1__c = '1111', inscor__City__c = '1111', inscor__Company_Name__c = '1111', inscor__Zip_Code__c = '1111');
        insert company;
        inscor__Company_Location__c companyLoc = new inscor__Company_Location__c( inscor__Company__c =company.Id );
        insert companyLoc;
        
        inscor__Inventory_Location__c invLocation  = new inscor__Inventory_Location__c(
            inscor__Company_Location__c = companyLoc.Id );
        insert invLocation;
        
        inscor__Owner_Code__c ownerCode = new inscor__Owner_Code__c();
        insert ownerCode;
        
        inscor__Warehouse__c warehouse = new inscor__Warehouse__c( 
            inscor__Company_Location__c = companyLoc.Id, inscor__Warehouse_Code__c ='1111' );
        insert warehouse; 
        
        
        inscor__Condition_Code__c code = new inscor__Condition_Code__c();
        code.Name='NE';
        code.inscor__Show_in_Summary__c=false;
        insert code;
        
        orderItem oi = new OrderItem();
        oi.Product2ID = pr.id;
        oi.Condition_Code__c = code.id;
        oi.OrderId = objOrder.Id;
        oi.UnitPrice = 10;
		oi.ListPrice = 10;
		oi.Quantity = 1;        
        insert oi;
        
        objOrder.Status='Activated';
        update objOrder;
        
        System.debug('objOrder -> '+objOrder);
        orderList.add(objOrder.Id);
        
        List<User> uList = new List<User>([SELECT ID FROM User WHERE IsActive = true AND Profile.Name = 'System Admin Clone' Limit 1]);
        System.runAs(uList[0]){        
            test.startTest();
            Test.setMock(HttpCalloutMock.class, new CustomerquoteTestcontroller());
                CreateSO.doPost();
            test.stopTest();
        }
    }*/
}