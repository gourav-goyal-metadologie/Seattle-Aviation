@isTest
public class CustomerQuoteControllerTest {
    
    @isTest
    public static void CustomerQuoteCheck(){
        list<Map<String, String>> QuoteLineItems = new list<Map<String, String>>();
        Map<String, String> LineItems = new Map<String, String>();

        
        Product2 pr = new Product2(Name ='#101',inscor__Keyword__c = 'SCREW',inscor__UOM__c='EA');
        insert pr;
        LineItems.put('value',pr.name);
        LineItems.put('key',pr.Id);
        LineItems.put('qty','5');
        LineItems.put('code','NE - Flat Rate w/OH Core');
        LineItems.put('code_id','NE - Flat Rate w/OH Core');
        QuoteLineItems.add(LineItems);
        
        //Salesforce_Auth__c objSalesforceAuth = [SELECT Id, Client_Id__c, Client_Secret__c, Login_Url__c, Password__c, Security_Token__c, UserName__c FROM Salesforce_Auth__c];
        Salesforce_Auth__c objSalesforceAuth = new Salesforce_Auth__c(
            Client_Id__c='test',
            Client_Secret__c='test',
            Login_Url__c='https://test.salesforce.com',
            Password__c='test',
            Security_Token__c='test',
            UserName__c='test');
        insert objSalesforceAuth;
        test.startTest();
        Test.setMock(HttpCalloutMock.class, new CustomerquoteTestcontroller());
            CustomerQuoteController.createQuoteAndLine(QuoteLineItems); 
            CustomerQuoteController.ProductName(pr.id);
        test.stopTest();
        //Salesforce_Auth__c objSalesforceAuth = [SELECT Id, Client_Id__c, Client_Secret__c, Login_Url__c, Password__c, Security_Token__c, UserName__c FROM Salesforce_Auth__c];
            
        //List<inscor__Customer_Quote_Line__c> createQuoteLineItems = CustomerQuoteController.createQuoteAndLine(QuoteLineItems);        
        
    }
    
    @isTest
    public static void CustomerQuoteandlinItemCheck(){
        list<Map<String, String>> QuoteLineItems = new list<Map<String, String>>();
        Map<String, String> LineItems = new Map<String, String>();

        //string communityId;// = '0DB6s000000Gmmy';
        //Id ac = [select accountId from User where Profile.name='Customer Community Plus Login User' limit 1].accountId;
        //Id ac = [select id from Account where name='Seattle Account'].id;
        Account ac = new Account(name ='Grazitti') ;
        insert ac; 
        
        Product2 pr = new Product2(Name ='#110',inscor__Keyword__c = 'SCREW',inscor__UOM__c='EA');
        //List<inscor__Condition_Code__c> CondCode =  [SELECT Id, Name FROM inscor__Condition_Code__c limit 1];
        insert pr;
        inscor__Condition_Code__c code = new inscor__Condition_Code__c();
        code.Name='NE';
        code.inscor__Show_in_Summary__c=false;
        insert code;
        system.debug('Condition code Details => '+code);
        
        //Product2 pr = new Product2(Name ='#10',inscor__Keyword__c = 'SCREW',inscor__UOM__c='EA');
        LineItems.put('value',pr.name);
        LineItems.put('key',pr.Id);
        LineItems.put('qty','5');
        LineItems.put('code','NE - Flat Rate w/OH Core');
        LineItems.put('code_id','NE - Flat Rate w/OH Core');
        QuoteLineItems.add(LineItems);
        
        inscor__Customer_Quote__c customerQuote = new inscor__Customer_Quote__c();
        customerQuote.inscor__Customer__c = ac.id;
        customerQuote.inscor__Temp_Quote__c = true;
        customerQuote.inscor__Quote_Source__c = 'Storefront';
        //insert customerQuote;
            
        List<inscor__Customer_Quote_Line__c> lineList = new List<inscor__Customer_Quote_Line__c>(); 
        inscor__Customer_Quote_Line__c eachLine = new inscor__Customer_Quote_Line__c();        
        //String cond_code = customerQuote.get(code_id[0]);
        eachLine.inscor__Customer_Quote__c = customerQuote.Id;
        eachLine.inscor__Customer_Part_Number__c = pr.Id;
        eachLine.inscor__Product__c = pr.Id;            
        eachLine.inscor__Condition_Code__c = code.Id;//row.get('code_id');
        eachLine.inscor__Quote_Type__c = 'Outright';            
        eachLine.inscor__Quantity__c = 2;
        lineList.add(eachLine);
        //insert eachLine;
        string JsonString = '{"Quote":'+JSON.serialize(customerQuote)+',';
        JsonString += '"QuoteLine":'+JSON.Serialize(lineList)+'}' ;
        
        /*RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/CreateCQ'; //Request URL
        req.httpMethod = 'POST';
        //req.setBody(JsonString);
        
        RestContext.request = req;
        RestContext.response= res;*/
        system.debug('JsonString'+JsonString);
        List<User> uList = new List<User>([SELECT ID FROM User WHERE IsActive = true AND Profile.Name = 'System Admin Clone' Limit 1]);
        System.runAs(uList[0]){
            test.startTest();
            Test.setMock(HttpCalloutMock.class, new CustomerquoteTestcontroller());
            //CustomerQuoteController.createQuoteAndLine(QuoteLineItems);
            CreateCustomerQuoteAndItsLine.doPost(); 
            test.stopTest();
        }
        
        
    }
    
    /*@isTest
    public static void ProductNameCheck(){        
        
        Product2 prod = new Product2();
        prod.Name='#10';
        prod.StockKeepingUnit='10';
        prod.inscor__Keyword__c='10';
        insert prod;
        system.debug('product Details => '+prod);

        String productId = prod.Id;//'01t6s000000LVkKAAW';
        String Product_Name = CustomerQuoteController.ProductName(productId);
    }*/
}