///////////// Update Existing Part Master SKU Batchable Class By Deb //////////////////////
global class Batch_Copy_Part_Master_to_SKU implements Database.Batchable<sObject> {
    
    global Database.QueryLocator  start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Name, StockKeepingUnit FROM Product2 WHERE StockKeepingUnit=null ORDER BY Id DESC LIMIT 5000');
       
    }
    global void execute(Database.BatchableContext bc, List<Product2> scope){
        System.debug('Product data' + scope); 
        
        // process each batch of records
       for(Product2 p : scope){ 
           p.StockKeepingUnit = p.Name; 
            // add Part number to Part Master SKU to be update
       } 
       update scope; 
    }    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }    
}