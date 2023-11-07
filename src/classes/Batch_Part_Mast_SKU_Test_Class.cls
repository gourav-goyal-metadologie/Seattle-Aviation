@isTest
public class Batch_Part_Mast_SKU_Test_Class {
    
    @isTest
    Private static void testskubatchclass(){
        // Load test data
        // List<Product2> prodcts = [SELECT Id, Name, StockKeepingUnit FROM Product2 WHERE StockKeepingUnit=null ORDER BY CreatedDate DESC LIMIT 2];
        List<Product2> prodList= new List<Product2>();
         for (Integer i=0; i<100; i++){
                Product2 obj = new Product2();
                obj.Name = 'Bulk-Test-'+i;
                //obj.StockKeepingUnit = 'Bulk-Test-'+i;
                obj.IsActive = true;
                obj.inscor__Keyword__c = 'bulktest';
                prodList.add(obj);
            }
         insert prodList;
             
        // Perform the test 
        Test.startTest();
        Batch_Copy_Part_Master_to_SKU BPMSKU = new Batch_Copy_Part_Master_to_SKU();
        Id batchId = Database.executeBatch(BPMSKU);
        // Database.executeBatch(new Batch_Copy_Part_Master_to_SKU(), 1);
        Test.stopTest();
        
        
    }

}