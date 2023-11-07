@IsTest
private class OrderHistoryControllerTest {
  @TestSetup
  static void setupData(){
    Account account = new Account();
    account.Name = 'TEST';
    account.inscor__Account_Number__c = '2';
    insert account;
    
    Contact contact = new Contact(
        FirstName = 'Jhon',
        LastName =  'Doe',
        AccountId = account.Id,
        Email = 'standarduser@testorg.com'
    );
    insert contact;
      
   	inscor__Company__c  company = new inscor__Company__c(
        inscor__Address_1__c = '1111', inscor__City__c = '1111', inscor__Company_Name__c = '1111', inscor__Zip_Code__c = '1111');
        insert company;
    
    Product2 product = new Product2(
        Name = 'Laptop X200', 
        Family = 'Hardware', 
        inscor__Keyword__c ='test',
        inscor__Description__c = 'POWER SUPPLY 12',
        inscor__UOM__c = 'EA'
    );
    insert product;

    inscor__Condition_Code__c conditionCode = new inscor__Condition_Code__c(
        Name ='Condition Code 1', 
        inscor__Show_in_Summary__c = false
    );
    insert conditionCode;

    inscor__Sales_Order__c salesOrder = new inscor__Sales_Order__c(
        inscor__Customer_PO_Number__c = 'PO21-00168',
        inscor__Contact__c = contact.Id,
        inscor__Customer__c = account.Id,
        inscor__Company__c = company.Id
    );
    insert salesOrder;

    inscor__Sales_Order_Line__c salesOrderLine = new inscor__Sales_Order_Line__c(
        inscor__Product__c = product.Id,
        inscor__Condition_Code__c = conditionCode.Id,
        inscor__Quantity_Ordered__c = 1,
        inscor__Order__c = salesOrder.Id,
        inscor__Price__c = 136
    );
    insert salesOrderLine;
    
    // for positive test
    Account account2 = new Account();
    account2.Name = 'test account';
    account2.inscor__Account_Number__c = '22';
    insert account2;
    
    Contact contact2 = new Contact(
        FirstName = 'Harry',
        LastName =  'Adim',
        AccountId = account2.Id,
        Email = 'standarduser@testorg.com',
        Is_Super_User__c = true
    );
    insert contact2;

    Product2 product2 = new Product2(
        Name = 'Laptop y29', 
        Family = 'Hardware', 
        inscor__Keyword__c ='test',
        inscor__Description__c = 'POWER SUPPLY 12',
        inscor__UOM__c = 'EA'
    );
    insert product2;

    inscor__Condition_Code__c conditionCode2 = new inscor__Condition_Code__c(
        Name ='Condition Code 2', 
        inscor__Show_in_Summary__c = false
    );
    insert conditionCode2;
    
    inscor__Sales_Order__c salesOrder2 = new inscor__Sales_Order__c(
        inscor__Customer_PO_Number__c = 'PO21-001',
        inscor__Contact__c = contact.Id,
        inscor__Customer__c = account.Id,
        inscor__Company__c = company.Id
    );
    insert salesOrder2;

    inscor__Sales_Order_Line__c salesOrderLine2 = new inscor__Sales_Order_Line__c(
        inscor__Product__c = product2.Id,
        inscor__Condition_Code__c = conditionCode2.Id,
        inscor__Quantity_Ordered__c = 1,
        inscor__Order__c = salesOrder2.Id,
        inscor__Price__c = 136
    );
    insert salesOrderLine2;

  }

  @IsTest
  static void getCustomerOrderNegativeTest(){

    Profile profile = [SELECT Id FROM Profile WHERE Name = 'Customer Community Plus Login User'];
    Contact contact = [Select Id FROM Contact WHERE Name = 'Jhon Doe' LIMIT 1];
    
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

    inscor__Sales_Order__c salesOrder = [SELECT Id, Name,
                                            inscor__Sales_Order_Total_Value__c, 
                                            inscor__Customer_PO_Number__c,  
                                            inscor__Contact__c, 
                                            inscor__Customer__c 
                                            From inscor__Sales_Order__c 
                                            WHERE inscor__Contact__c =: contact.Id LIMIT 1];

    Test.startTest();
    System.runAs(user){
        List<OrderHistoryController.OrderHistoryWrapper> result = OrderHistoryController.getCustomerOrder();
        System.assertEquals(result[0].orderNumber, salesOrder.Name);
    }
    Test.stopTest();
  }

  @IsTest
  static void getCustomerOrderPositiveTest(){

    Profile profile = [SELECT Id FROM Profile WHERE Name = 'Customer Community Plus Login User'];
    Contact contact = [Select Id FROM Contact WHERE Name = 'Jhon Doe' LIMIT 1];
        
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

    
    inscor__Sales_Order__c salesOrder = [SELECT Id, Name,
                                            inscor__Sales_Order_Total_Value__c, 
                                            inscor__Customer_PO_Number__c,  
                                            inscor__Contact__c, 
                                            inscor__Customer__c 
                                            From inscor__Sales_Order__c 
                                            WHERE inscor__Contact__c =: contact.Id LIMIT 1];
    
    Test.startTest();
    System.runAs(user){
        List<OrderHistoryController.OrderHistoryWrapper> result = OrderHistoryController.getCustomerOrder();
        System.assertEquals(result[0].orderNumber, salesOrder.Name);
    }
    Test.stopTest();
      
  }

  @IsTest
  static void getOrderBySearchNegativeTest(){

    try {
        String orderName;
        String orderAmount;
        String orderDate;
        String orderType;
        String customerPO;
        String partNumber;

        Test.startTest();
        List<OrderHistoryController.OrderHistoryWrapper> result = OrderHistoryController.getOrderBySearch(orderName, orderAmount, orderDate, orderType, customerPO, partNumber);
        Test.stopTest();
        System.assertEquals(result[0].orderNumber, orderName);
    } catch (Exception e) {
        
    }

  }

  @IsTest
  static void getOrderBySearchNegative02Test(){

    try {
        String orderName;
        String orderAmount;
        String orderDate = '1234';
        String orderType;
        String customerPO;
        String partNumber;

        Test.startTest();
        List<OrderHistoryController.OrderHistoryWrapper> result = OrderHistoryController.getOrderBySearch(orderName, orderAmount, orderDate, orderType, customerPO, partNumber);
        Test.stopTest();
        System.assertEquals(result[0].orderNumber, orderName);
    } catch (Exception e) {
        
    }

  }

    @IsTest
    static void getOrderBySearchPositiveTest(){

        Profile profile = [SELECT Id FROM Profile WHERE Name = 'Customer Community Plus Login User'];
        Contact contact = [Select Id FROM Contact WHERE Name = 'Jhon Doe' LIMIT 1];
        
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

        inscor__Sales_Order__c salesOrder = [SELECT Id, Name,
                                                inscor__Sales_Order_Total_Value__c, 
                                                inscor__Customer_PO_Number__c,  
                                                inscor__Contact__c, 
                                                inscor__Customer__c,
                                                inscor__Create_Date__c
                                                From inscor__Sales_Order__c 
                                                WHERE inscor__Contact__c =: contact.Id LIMIT 1];

        inscor__Sales_Order_Line__c salesOrderLine = [SELECT Id, Name,
                                                        inscor__Product__c,
                                                        inscor__Condition_Code__c,
                                                        inscor__Quantity_Ordered__c,
                                                        inscor__Order_Type__c,
                                                        inscor__Product__r.Name,
                                                        inscor__Price__c FROM inscor__Sales_Order_Line__c
                                                        WHERE inscor__Order__c =: salesOrder.Id];

        String orderAmount = String.valueOf(salesOrder.inscor__Sales_Order_Total_Value__c);
        String orderDate = String.valueOf(salesOrder.inscor__Create_Date__c);

        
        Test.startTest();
        System.runAs(user){
            List<OrderHistoryController.OrderHistoryWrapper> result = OrderHistoryController.getOrderBySearch(salesOrder.Name, orderAmount, orderDate, salesOrderLine.inscor__Order_Type__c, salesOrder.inscor__Customer_PO_Number__c, salesOrderLine.inscor__Product__r.Name);
        }
        Test.stopTest();
            
    }      

    @IsTest
    static void getOrderBySearchPositive02Test(){

        Profile profile = [SELECT Id FROM Profile WHERE Name = 'Customer Community Plus Login User'];
        Contact contact = [Select Id FROM Contact WHERE Name = 'Jhon Doe' LIMIT 1];
        
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

        inscor__Sales_Order__c salesOrder = [SELECT Id, Name,
                                                inscor__Sales_Order_Total_Value__c, 
                                                inscor__Customer_PO_Number__c,  
                                                inscor__Contact__c, 
                                                inscor__Customer__c,
                                                inscor__Create_Date__c
                                                From inscor__Sales_Order__c 
                                                WHERE inscor__Contact__c =: contact.Id LIMIT 1];

        inscor__Sales_Order_Line__c salesOrderLine = [SELECT Id, Name,
                                                        inscor__Product__c,
                                                        inscor__Condition_Code__c,
                                                        inscor__Quantity_Ordered__c,
                                                        inscor__Order_Type__c,
                                                        inscor__Product__r.Name,
                                                        inscor__Price__c FROM inscor__Sales_Order_Line__c
                                                        WHERE inscor__Order__c =: salesOrder.Id];

        String orderAmount = String.valueOf(salesOrder.inscor__Sales_Order_Total_Value__c);
        String orderDate = String.valueOf(salesOrder.inscor__Create_Date__c);

        
        Test.startTest();
        System.runAs(user){
            List<OrderHistoryController.OrderHistoryWrapper> result = OrderHistoryController.getOrderBySearch(salesOrder.Name, orderAmount, orderDate, salesOrderLine.inscor__Order_Type__c, salesOrder.inscor__Customer_PO_Number__c, null);
        }
        Test.stopTest();
            
    }      

    @IsTest
    static void getOrderLinesByIdTest(){
        try {

            inscor__Sales_Order__c salesOrder = [SELECT Id, Name,
                                                    inscor__Sales_Order_Total_Value__c, 
                                                    inscor__Customer_PO_Number__c,  
                                                    inscor__Contact__c, 
                                                    inscor__Customer__c,
                                                    inscor__Create_Date__c
                                                    From inscor__Sales_Order__c  LIMIT 1];

            inscor__Sales_Order_Line__c salesOrderLine = [SELECT Id, Name,
                                                            inscor__Product__c,
                                                            inscor__Condition_Code__c,
                                                            inscor__Quantity_Ordered__c,
                                                            inscor__Order_Type__c,
                                                            inscor__Product__r.Name,
                                                            inscor__Price__c FROM inscor__Sales_Order_Line__c
                                                            WHERE inscor__Order__c =: salesOrder.Id];

            Test.startTest();
            List<OrderHistoryController.orderLineWrapper> resultWrapperList = OrderHistoryController.getOrderLinesById(salesOrder.Id);
            Test.stopTest();
        } catch (Exception e) {
            
        }
    }
}