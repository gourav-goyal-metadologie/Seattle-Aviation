@isTest
public class ApnWebhookTest {
    
  @isTest
    public static void testWebhook() {
    List<Object> data = New List<Object>();
    
    Test.setMock(HttpCalloutMock.class, new ApnMockHttpResponseGenerator());
        
    Webhook.jsonContent(data, data);
   
    String url = 'http://52.91.79.82:8080/trigger/inventory/crud/COMPANY_628ffd10-6edf-4140-b971-d501387795c1';
    String content = '{"new":[{"Id":"a0H5Y00001JpHrOUAV"}],"old":[{"Id":"a0H5Y00001JpHrOUAV"}]}';
    Webhook.callOut(url, content);
 
  }

  @IsTest
  static void testApnInventoryUpdateTrigger(){
    
    Test.startTest();
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
    
    
    inscor__Condition_Code__c conditionalCode  = new inscor__Condition_Code__c( inscor__Show_in_Summary__c = false);
    insert conditionalCode;
    
    //---inscor__Company__c company = [ SELECT Id FROM inscor__Company__c LIMIT 1];
    inscor__Company__c  company = new inscor__Company__c(
        inscor__Address_1__c = '1111', inscor__City__c = '1111', inscor__Company_Name__c = '1111', inscor__Zip_Code__c = '1111');
    insert company;
    inscor__Company_Location__c companyLoc = new inscor__Company_Location__c( inscor__Company__c =company.Id );
    insert companyLoc;
    
    inscor__Inventory_Location__c invLocation  = new inscor__Inventory_Location__c(
        inscor__Company_Location__c = companyLoc.Id );
    insert invLocation;
    
    inscor__Owner_Code__c ownerCode = new inscor__Owner_Code__c();
    ownerCode.inscor__Company__c = companyInstance.Id;
    insert ownerCode;
    
    inscor__Warehouse__c warehouse = new inscor__Warehouse__c( 
        inscor__Company_Location__c = companyLoc.Id, inscor__Warehouse_Code__c ='1111' );
    insert warehouse;       
    
    inscor__Inventory_Line__c invLine = new inscor__Inventory_Line__c(
        
        inscor__Condition_Code__c = conditionalCode.Id , 
        inscor__Location__c  = invLocation.Id, 
        inscor__Owner_Code__c  = ownerCode.Id,
        inscor__Warehouse__c  = warehouse.Id
    );
    
    insert invLine;
    Test.stopTest();
    
  }

}