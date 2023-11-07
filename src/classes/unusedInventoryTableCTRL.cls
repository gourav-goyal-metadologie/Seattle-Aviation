public class unusedInventoryTableCTRL {
    
    @AuraEnabled
    public static List<Product2> getunUsedInventory(){
        try {
            List<Product2> productsList = new List<Product2>();
            List<Product2> productsList2 = new List<Product2>();
            List<Product2> productsList3 = new List<Product2>();
            List<Product2> productsList4 = new List<Product2>();
            List<Product2> productsList5 = new List<Product2>();
            List<Product2> productsList6 = new List<Product2>();
            List<Product2> productsList7 = new List<Product2>();
            List<Product2> productsList8 = new List<Product2>();
            List<Product2> productsList9 = new List<Product2>();
            List<Product2> productsList10 = new List<Product2>();
            List<Product2> productsList11 = new List<Product2>();
            List<Product2> unUsedProductsList = new List<Product2>();
            productsList = [SELECT Id, ProductCode, Name, inscor__Keyword__c, inscor__Description__c 
                            , (select id, inscor__Price__c from inscor__Customer_Quote_Lines__r LIMIT 1)
                            , (select id from inscor__Sales_Order_Lines__r LIMIT 1)
                            , (select id from inscor__Purchase_Order_Lines__r LIMIT 1)
                            , (select id from inscor__Repair_Contract_Prices__r LIMIT 1)
                            , (select id from inscor__Customer_Contract_Prices__r LIMIT 1)
                            , (select id from inscor__Vendor_Contract_Prices__r LIMIT 1)
                            , (select id from inscor__Inventory__r LIMIT 1)
                            FROM Product2 order by ProductCode desc limit 15000 ];
            for(Product2 product: productsList){
                if(product.inscor__Customer_Quote_Lines__r.size() >0 
                   && product.inscor__Sales_Order_Lines__r.size() ==0
                   && product.inscor__Purchase_Order_Lines__r.size() ==0
                   && product.inscor__Inventory__r.size() ==0
                   && (product.inscor__Repair_Contract_Prices__r.size() > 0
                       || product.inscor__Customer_Contract_Prices__r.size()> 0
                       || product.inscor__Vendor_Contract_Prices__r.size() > 0) 
                  ){
                      system.debug('product.inscor__Customer_Quote_Lines__r >>'+product.inscor__Customer_Quote_Lines__r);
                      for(inscor__Customer_Quote_Line__c quoteLine: product.inscor__Customer_Quote_Lines__r){
                          if(quoteLine.inscor__Price__c == 0){
                              unUsedProductsList.add(product);
                          }
                          
                      }
                      
                      
                  }
            }
            
            return unUsedProductsList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static void deleteSelectedInventory( String selectedRows){
        try {
            List<inscor__Alternate__c> alternateRecords = new List<inscor__Alternate__c>();
            List<Product2>  resultsn = (List<Product2>)JSON.deserialize(selectedRows, List<Product2>.class);
            if(resultsn.size() > 0) {
                Set<Id> productIds = new Set<Id>();
                for(Product2 product: resultsn){
                    productIds.add(product.id);
                }
                if(!test.isRunningTest()){
                    delete [select id from inscor__Alternate__c where inscor__Alternate_Product__c IN : productIds];
                    delete [select id from inscor__Repair_Contract_Price__c where inscor__Product__c IN : productIds];
                    delete [select id from inscor__Customer_Contract_Price__c where inscor__Product__c IN : productIds];
                    delete [select id from inscor__Vendor_Contract_Price__c where inscor__Product__c IN : productIds];
                    delete resultsn;
                }
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}