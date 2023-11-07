@IsTest
public class AlternateTriggerHelperTest {

    @TestSetup
    static void setupTestData(){
        Product2 product = new Product2(Name = 'Laptop X200', 
                                        Family = 'Hardware', 
                                        inscor__Keyword__c ='test');
        insert product;

        inscor__Company__c  company = new inscor__Company__c(inscor__Address_1__c = '1111', 
                                                            inscor__City__c = '1111', 
                                                            inscor__Company_Name__c = '1111', 
                                                            inscor__Zip_Code__c = '1111');
        insert company;


        List<inscor__Alternate__c> alternates = new List<inscor__Alternate__c>();
        
        for (Integer index = 0; index < 5; index++) {
            inscor__Alternate__c alternate = new inscor__Alternate__c();
            alternate.inscor__Alternate_Product__c = product.id;
            alternate.inscor__Company__c = company.Id;
            alternate.inscor__Relationship_New__c = 'Superseded By';
            alternate.inscor__Relationship_Other_Side__c = 'Superseded By';
            alternate.inscor__Show_both_sides_in_Part_Research__c = true;
            alternates.add(alternate);
        }

        insert alternates;
    }

    @IsTest
    static void testUpdateConditionCodes(){
        
        Test.startTest();
        Product2 product = new Product2(Name = 'Laptop 2 XYS', 
                                        Family = 'Hardware', 
                                        inscor__Keyword__c ='laptop test', OH__c = true, NE__c = true, RD__c = true, SV__c = true);
        insert product;
        List<inscor__Alternate__c> alternates = [SELECT Id, 
                                                inscor__Alternate_Product__c,
                                                inscor__Alternate_Product__r.NE__c,
                                                inscor__Alternate_Product__r.OH__c,
                                                inscor__Alternate_Product__r.RD__c,
                                                inscor__Alternate_Product__r.SV__c
                                                FROM inscor__Alternate__c];
        for(inscor__Alternate__c alternate : alternates){
            if (alternate.inscor__Alternate_Product__c != null) {
                alternate.inscor__Alternate_Product__c = product.Id;
                alternate.inscor__Alternate_Product__r.NE__c = true;
                alternate.inscor__Alternate_Product__r.OH__c = true;
                alternate.inscor__Alternate_Product__r.RD__c = true;
                alternate.inscor__Alternate_Product__r.SV__c = true;
                AlternateTriggerHelper.getConditionCodeInstances(alternate);
            }
        }
        Test.stopTest();
        
    }

    @IsTest
    static void testDeleteCondtionCodes(){
        
        Test.startTest();
        List<inscor__Alternate__c> alternates = [SELECT Id FROM inscor__Alternate__c];
        for (inscor__Alternate__c alternate : alternates) {
            alternate.inscor__Alternate_Product__c = null;
        }
        update alternates;
        delete alternates;
        Test.stopTest();
        
    }

    
}