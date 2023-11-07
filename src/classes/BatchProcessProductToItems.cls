global class BatchProcessProductToItems implements Database.Batchable<sObject>,Database.AllowsCallouts,Database.Stateful {

    Public Set<Id> productIds;
    global BatchProcessProductToItems(){
        productIds = new Set<Id>();
    }
    global BatchProcessProductToItems(Set<Id> Ids){
        productIds = Ids;
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        String query = 'SELECT Id, Name, inscor__Keyword__c, '+
            			'inscor__Description__c, inscor__Country_of_Origin__c, '+
            			'inscor__HazMat__c, inscor__HazMat_Id__c, IsActive '+
            			'FROM  Product2 ';
        
        if(productIds.size() > 0){
            query += ' WHERE Id IN: productIds';
        }
        //system.assert(false,query);
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Product2> productList){
        ProductToItemAPIService.sendProductsToCompliance(productList);
    }
    
    global void finish(Database.BatchableContext bc){
    }

}