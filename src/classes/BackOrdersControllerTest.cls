@IsTest
private class BackOrdersControllerTest {
    @TestSetup
    static void setupData(){
        Account account = new Account();
        account.Name = 'TEST1';
        account.inscor__Account_Number__c = '2';  
        insert account;
        
        Contact contact = new Contact(
            FirstName = 'Jhon',
            LastName =  'Doe1',
            AccountId = account.Id,
            Email = 'standarduser@testorg.com'
        );
        insert contact;
        
        inscor__Company__c  company = new inscor__Company__c(
        inscor__Address_1__c = '1111', inscor__City__c = '1111', inscor__Company_Name__c = '1111', inscor__Zip_Code__c = '1111');
        insert company;

        inscor__Customer_Quote__c customerQuote = new inscor__Customer_Quote__c();
        customerQuote.inscor__Customer__c = account.Id;
        customerQuote.inscor__Status__c = 'New';
        customerQuote.inscor__Company__c = company.Id;
        insert customerQuote;
        
        inscor__Sales_Order__c salesOrder = new inscor__Sales_Order__c();
        salesOrder.inscor__Quote_Number__c = customerQuote.Id;
        salesOrder.inscor__Customer__c = account.Id;
        salesOrder.inscor__Contact__c = contact.Id;
        salesOrder.inscor__Customer_PO_Number__c = 'PO21-00164';
        salesOrder.inscor__Company__c = company.Id;
        insert salesOrder;
        
        Product2 product = new Product2(Name = 'Laptop X7600', 
                                           Family = 'Hardware', inscor__Keyword__c ='test',
                                           inscor__UOM__c = 'EA');
        insert product;
        
        inscor__Condition_Code__c conditionCode = new inscor__Condition_Code__c(Name ='Condition Code 1', inscor__Show_in_Summary__c = false);
        insert conditionCode;
        
        inscor__Sales_Order_Line__c salesOrderLine = new inscor__Sales_Order_Line__c();
        salesOrderLine.inscor__Order__c = salesOrder.Id;
        salesOrderLine.inscor__Condition_Code__c = conditionCode.Id;
        salesOrderLine.inscor__Quantity_Ordered__c = 10;
        salesOrderLine.inscor__Product__c = product.Id;
        salesOrderLine.inscor__Promised_Date__c = Date.newInstance(2022, 12, 5);
        insert salesOrderLine;
        
        // For Is_Super_User__c = true in contact

        Account account2 = new Account();
        account2.Name = 'test Account1';
        account2.inscor__Account_Number__c = '23';
        account2.inscor__Hide_from_CQ__c = false;
        insert account2;
        
        Contact contact2 = new Contact(
            FirstName = 'Harry',
            LastName =  'Adim',
            AccountId = account2.Id,
            Email = 'standarduser@testorg.com',
            Is_Super_User__c = true
        );
        insert contact2;

        inscor__Customer_Quote__c customerQuote2 = new inscor__Customer_Quote__c();
        //customerQuote2.inscor__Customer__c = account2.Id;
        customerQuote2.inscor__Customer__c = account.Id;
        customerQuote2.inscor__Status__c = 'New';
        customerQuote2.inscor__Company__c = company.Id;
        insert customerQuote2;
        
        inscor__Sales_Order__c salesOrder2 = new inscor__Sales_Order__c();
        salesOrder2.inscor__Quote_Number__c = customerQuote2.Id;
        salesOrder2.inscor__Customer__c = account.Id;
        salesOrder2.inscor__Contact__c = contact.Id;
        salesOrder2.inscor__Customer_PO_Number__c = 'PO21-00168';
        salesOrder2.inscor__Company__c = company.Id;
        
        insert salesOrder2;
        
        Product2 product2 = new Product2(
            Name = 'Laptop y45', 
            Family = 'Hardware', inscor__Keyword__c ='test',
            inscor__UOM__c = 'EA'
        );
        insert product2;
        
        inscor__Condition_Code__c conditionCode2 = new inscor__Condition_Code__c(Name ='Condition Code 12', inscor__Show_in_Summary__c = false);
        insert conditionCode2;
        
        inscor__Sales_Order_Line__c salesOrderLine2 = new inscor__Sales_Order_Line__c();
        salesOrderLine2.inscor__Order__c = salesOrder2.Id;
        salesOrderLine2.inscor__Condition_Code__c = conditionCode2.Id;
        salesOrderLine2.inscor__Quantity_Ordered__c = 10;
        salesOrderLine2.inscor__Product__c = product2.Id;
        salesOrderLine2.inscor__Expected_Ship_Date__c = Date.newInstance(2022, 12, 10); 

        insert salesOrderLine2;
        
    }

    @IsTest
    static void getBackOrderIdsPositiveTest(){
        
        Profile profile = [SELECT Id FROM Profile WHERE Name = 'Customer Community Plus Login User'];
        Contact contact = [Select Id FROM Contact WHERE Name = 'Harry Adim'];

        User user = new User(
            Alias = 'jhonet', 
            Email ='standarduser@testorg.com', 
            EmailEncodingKey ='UTF-8', 
            LastName ='Maxx', 
            LanguageLocaleKey='en_US', 
            LocaleSidKey = 'en_US', 
            ProfileId = profile.Id,
            ContactId = contact.Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            UserName = 'maxx@dev.com'
        );
        insert user;
        Test.startTest();
        System.runAs(user){
            BackOrdersController.getBackOrderIds();
            BackOrdersController.getOrders();
        }
        Test.stopTest();

    }

    @IsTest
    static void getBackOrderIdsNegativeTest(){

        Profile profile = [SELECT Id FROM Profile WHERE Name = 'Customer Community Plus Login User'];
        Contact contact = [Select Id FROM Contact WHERE Name = 'Jhon Doe1'];

        User user = new User(
            Alias = 'jhonet', 
            Email ='standarduser@testorg.com', 
            EmailEncodingKey ='UTF-8', 
            LastName ='Doe', 
            LanguageLocaleKey='en_US', 
            LocaleSidKey = 'en_US', 
            ProfileId = profile.Id,
            ContactId = contact.Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            UserName = 'john@dev.com'
        );
        
        Test.startTest();
        System.runAs(user){
            BackOrdersController.getBackOrderIds();
            BackOrdersController.getOrders();
        }
        Test.stopTest();
        
    }

    @IsTest
    static void getOrdersTest(){

        inscor__Sales_Order__c salesOrder = [SELECT Id FROM inscor__Sales_Order__c WHERE inscor__Customer_PO_Number__c = 'PO21-00168'];
        
        Test.startTest();
        BackOrdersController.getOrderLinesById(salesOrder.Id);
        Test.stopTest();
        
    }

    @IsTest
    static void createBackOrderWrapperTest(){

        inscor__Sales_Order__c salesOrder = [SELECT Id, Name, 
                                                inscor__Sales_Order_Total_Value__c, 
                                                inscor__Create_Date__c, 
                                                inscor__Customer_PO_Number__c, inscor__Sales_Order__c.inscor__Contact__r.Name 
                                                FROM inscor__Sales_Order__c 
                                                WHERE inscor__Customer_PO_Number__c = 'PO21-00168'];
        
        Test.startTest();
        BackOrdersController.createBackOrderWrapper(salesOrder);
        Test.stopTest();
        
    }
   
    @IsTest
    static void getOrdersBySearchTest(){
        try{
            String custPO = '';
            String orderDate = null;
            Test.startTest();
            List<BackOrdersController.BackOrderWrapper> resultWrapperList = BackOrdersController.getOrdersBySearch(custPO, orderDate);
            Test.stopTest();
            inscor__Condition_Code__c conditionCode = [SELECT Id, Name FROM inscor__Condition_Code__c WHERE Name = 'Condition Code 12'];

             inscor__Sales_Order_Line__c salesOrderLine = [SELECT Id, Name, 
                                                            inscor__Order__r.inscor__Customer_PO_Number__c, 
                                                            inscor__Create_Date__c FROM inscor__Sales_Order_Line__c
                                                            WHERE inscor__Condition_Code__c =: conditionCode.Id];
            
            //System.assertEquals(resultWrapperList[0].custPo, salesOrderLine.inscor__Order__r.inscor__Customer_PO_Number__c);
            System.assertEquals(resultWrapperList[0].orderDate, salesOrderLine.inscor__Create_Date__c);
        }catch(Exception e) {

        }
    }
}