@isTest
public class EnableProductForStorefront_Test {
    @isTest
    public static void testProductAssignment(){
        Product2 pr = new Product2(Name ='#162',inscor__Keyword__c = 'SCREW2',inscor__UOM__c='EA');
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
        Test.setMock(HttpCalloutMock.class, new ApnMockHttpResponseGenerator());
        EnableProductForStorefront.justIncrement();
    }
}