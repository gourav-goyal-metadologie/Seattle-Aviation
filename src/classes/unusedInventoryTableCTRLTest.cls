@isTest
public class unusedInventoryTableCTRLTest {
    
    public static final Integer COUNT_LIMIT = 10;
    @testSetup()
    private static void setup(){
        //Create a Account for Customer
        Account accRec = new Account();
        accRec.Name = 'TEST';
        accRec.inscor__Account_Number__c = '2';  
        insert accRec;
        List<Account> accList = new List<Account>([SELECT Id,Name FROM Account LIMIT 1]);
        List<inscor__Customer_Quote__c> customerQuoteToInsertList = new List<inscor__Customer_Quote__c>();
        List<inscor__Customer_Quote_Line__c> customerQuoteLineToInsertList = new List<inscor__Customer_Quote_Line__c>();
        
        inscor__Company__c  company = new inscor__Company__c(
            inscor__Address_1__c = '1111', inscor__City__c = '1111', inscor__Company_Name__c = '1111', inscor__Zip_Code__c = '1111');
        insert company;
        
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Customer_Quote__c customerQuoteRec = new inscor__Customer_Quote__c();
            customerQuoteRec.inscor__Customer__c = accList[0].Id;
            customerQuoteRec.inscor__Status__c = 'New';
            customerQuoteRec.inscor__Company__c = company.Id;
            customerQuoteToInsertList.add(customerQuoteRec);
        }
        insert customerQuoteToInsertList;
        
        Product2 product = new Product2(name = '12345', inscor__Keyword__c = 'test');
        insert product;
        
        inscor__Condition_Code__c conditionCode = new inscor__Condition_Code__c(name = 'test code', inscor__Show_in_Summary__c = false);
        insert conditionCode;
        
        List<Opportunity> oppList = new List<Opportunity>([SELECT Id FROM Opportunity]);
        system.assertEquals(oppList.size(), COUNT_LIMIT);
        for(inscor__Customer_Quote__c quoteRec : customerQuoteToInsertList){
            for(Integer i = 0; i< COUNT_LIMIT; i++) { 
                inscor__Customer_Quote_Line__c qouteLineRec = new inscor__Customer_Quote_Line__c();
                qouteLineRec.inscor__Quote_Type__c = 'Outright';
                qouteLineRec.inscor__Customer_Quote__c = quoteRec.Id;
                qouteLineRec.inscor__Price__c = 0;
                qouteLineRec.inscor__Product__c = product.id;
                qouteLineRec.inscor__Quantity__c = 12;
                qouteLineRec.inscor__Condition_Code__c = conditionCode.id;
                qouteLineRec.inscor__Business_Category__c = 'Distribution';
                customerQuoteLineToInsertList.add(qouteLineRec);
            }  
        }
        insert customerQuoteLineToInsertList;
    }   
    
    
    @isTest
    static void batchWithParamTest() {
        
        Test.setMock(HttpCalloutMock.class, new ComplianceMockResponseGenerator());
        
       List<Product2> products = new List<Product2>();
        products = [select id from product2];
        Test.startTest();
        try{
            unusedInventoryTableCTRL.getunUsedInventory();
            unusedInventoryTableCTRL.deleteSelectedInventory(JSON.serialize(products));
            unusedInventoryTableCTRL.deleteSelectedInventory('test');
        }catch(Exception e){
            
        }
        
        
        Test.stopTest();
    } 

}