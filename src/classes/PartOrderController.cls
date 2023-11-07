public class PartOrderController {
   
    @AuraEnabled
    public static List<ResponseWrapper> getCustomerQuotes(String accountId){
		AggregateResult[] groupedResultsAllTime = [SELECT inscor__Product__c Id,inscor__Product__r.name partName,SUM(inscor__Quantity__c), COUNT(inscor__Customer_Quote__c)  
                                                    FROM inscor__Customer_Quote_Line__c 
                                                    WHERE inscor__Customer_Quote__r.inscor__Customer__c = : accountId AND inscor__Product__c != NULL AND inscor__Quantity__c != NULL
                                                    GROUP BY inscor__Product__c,inscor__Product__r.name order by SUM(inscor__Quantity__c) desc limit 5];
        Map<Id, AggregateResult> last365DaysMap = new Map<Id, AggregateResult>(
                                                                        [SELECT inscor__Product__c Id, 
                                                                        COUNT(inscor__Customer_Quote__c)  
                                                                        FROM inscor__Customer_Quote_Line__c 
                                                                        WHERE inscor__Customer_Quote__r.inscor__Customer__c = : accountId AND inscor__Quantity__c != NULL
                                                                        AND createdDate =LAST_N_DAYS:365  AND inscor__Product__c != NULL
                                                                        GROUP BY inscor__Product__c,inscor__Product__r.name order by SUM(inscor__Quantity__c) desc limit 5]
        );
        List<ResponseWrapper> responseWrappers = new List<ResponseWrapper>();
        for (AggregateResult result : groupedResultsAllTime) {
            ResponseWrapper responseWrapper = new ResponseWrapper();
            responseWrapper.partId = (Id)result.get('Id');
            responseWrapper.partName = (String)result.get('partName');
            responseWrapper.Qty = (Decimal)result.get('expr0');
            responseWrapper.last365 = (Decimal)(last365DaysMap.containsKey((Id)result.get('Id')) ? last365DaysMap.get((Id)result.get('Id')).get('expr0') : 0);
            responseWrapper.allTime = (Decimal)result.get('expr1');
            responseWrappers.add(responseWrapper);
        }
        return responseWrappers;
    }
    
    @AuraEnabled
    public static List<ResponseWrapper> getCustomerQuotesLineItem(String accountId){

        AggregateResult[] groupedResultsAllTime = [SELECT inscor__Product__c Id,inscor__Product__r.name partName, SUM(inscor__Quantity__c), COUNT(inscor__Customer_Quote__c)  
                                                    FROM inscor__Customer_Quote_Line__c 
                                                    WHERE inscor__Customer_Quote__r.inscor__Customer__c = : accountId AND inscor__Quantity__c != NULL AND inscor__Product__c != NULL
                                                    GROUP BY inscor__Product__c,inscor__Product__r.name 
                                                    ORDER BY SUM(inscor__Quantity__c) desc];
        Map<Id, AggregateResult> last365DaysMap = new Map<Id, AggregateResult>(
                                                                        [SELECT inscor__Product__c Id, 
                                                                        COUNT(inscor__Customer_Quote__c)  from inscor__Customer_Quote_Line__c 
                                                                        WHERE inscor__Customer_Quote__r.inscor__Customer__c = : accountId AND createdDate =LAST_N_DAYS:365  AND inscor__Product__c != NULL
                                                                        GROUP BY inscor__Product__c,inscor__Product__r.name
                                                                        ORDER BY SUM(inscor__Quantity__c) desc]
        );

        List<ResponseWrapper> responseWrappers = new List<ResponseWrapper>();
        for (AggregateResult result : groupedResultsAllTime) {
            ResponseWrapper responseWrapper = new ResponseWrapper();
            responseWrapper.partId = (Id)result.get('Id');
            responseWrapper.partName = (String)result.get('partName');
            responseWrapper.Qty = (Decimal)result.get('expr0');
            responseWrapper.last365 = (Decimal)(last365DaysMap.containsKey((Id)result.get('Id')) ? last365DaysMap.get((Id)result.get('Id')).get('expr0') : 0);
            responseWrapper.allTime = (Decimal)result.get('expr1');
            responseWrappers.add(responseWrapper);
        }
        return responseWrappers;
    }
     
  
    @AuraEnabled
    public static List<ResponseWrapper> getSalesOrder(String accountId){
        AggregateResult[] groupedResultsAllTime = [SELECT inscor__Product__c Id,inscor__Product__r.name partName,SUM(inscor__Quantity_Ordered__c), COUNT(inscor__Order__C)
                                            FROM inscor__Sales_Order_Line__c 
                                            WHERE inscor__Order__r.inscor__Customer__c =: accountId AND inscor__Quantity_Ordered__c != NULL  AND inscor__Product__c != NULL
                                            GROUP BY inscor__Product__c,inscor__Product__r.name 
                                            ORDER BY SUM(inscor__Quantity_Ordered__c) desc limit 5];
        Map<Id, AggregateResult> last365DaysMap = new Map<Id, AggregateResult>(
                                                                [SELECT inscor__Product__c Id,inscor__Product__r.name,
                                                                COUNT(inscor__Order__C)
                                                                FROM inscor__Sales_Order_Line__c 
                                                                WHERE inscor__Order__r.inscor__Customer__c =: accountId AND inscor__Product__c != NULL AND createdDate =LAST_N_DAYS:365
                                                                GROUP BY inscor__Product__c,inscor__Product__r.name 
                                                                ORDER BY SUM(inscor__Quantity_Ordered__c) desc limit 5]
        );

        List<ResponseWrapper> responseWrappers = new List<ResponseWrapper>();
        for (AggregateResult result : groupedResultsAllTime) {
            ResponseWrapper responseWrapper = new ResponseWrapper();
            responseWrapper.partId = (Id)result.get('Id');
            responseWrapper.partName = (String)result.get('partName');
            responseWrapper.Qty = (Decimal)result.get('expr0');
            responseWrapper.last365 = (Decimal)(last365DaysMap.containsKey((Id)result.get('Id')) ? last365DaysMap.get((Id)result.get('Id')).get('expr0') : 0);
            responseWrapper.allTime = (Decimal)result.get('expr1');
            responseWrappers.add(responseWrapper);
        }
        return responseWrappers;
    }
    
   @AuraEnabled
    public static List<ResponseWrapper> getSalesQuotesLineItem(String accountId){
        AggregateResult[] groupedResultsAllTime = [SELECT inscor__Product__c Id,inscor__Product__r.name partName,SUM(inscor__Quantity_Ordered__c), COUNT(inscor__Order__C)
                                            FROM inscor__Sales_Order_Line__c 
                                            WHERE inscor__Order__r.inscor__Customer__c =: accountId AND inscor__Quantity_Ordered__c != NULL AND inscor__Product__c != NULL
                                            GROUP BY inscor__Product__c,inscor__Product__r.name 
                                            ORDER BY SUM(inscor__Quantity_Ordered__c) desc];
        Map<Id, AggregateResult> last365DaysMap = new Map<Id, AggregateResult>(
                                                                [SELECT inscor__Product__c Id,inscor__Product__r.name,
                                                                COUNT(inscor__Order__C)
                                                                FROM inscor__Sales_Order_Line__c 
                                                                WHERE inscor__Order__r.inscor__Customer__c =: accountId  AND inscor__Product__c != NULL AND createdDate =LAST_N_DAYS:365
                                                                GROUP BY inscor__Product__c,inscor__Product__r.name 
                                                                ORDER BY SUM(inscor__Quantity_Ordered__c) desc]
        );

        List<ResponseWrapper> responseWrappers = new List<ResponseWrapper>();
        for (AggregateResult result : groupedResultsAllTime) {
            ResponseWrapper responseWrapper = new ResponseWrapper();
            responseWrapper.partId = (Id)result.get('Id');
            responseWrapper.partName = (String)result.get('partName');
            responseWrapper.Qty = (Decimal)result.get('expr0');
            responseWrapper.last365 = (Decimal)(last365DaysMap.containsKey((Id)result.get('Id')) ? last365DaysMap.get((Id)result.get('Id')).get('expr0') : 0);
            responseWrapper.allTime = (Decimal)result.get('expr1');
            responseWrappers.add(responseWrapper);
        }
        return responseWrappers;
    }
    
    private static void getResponseWrapperData() {
        
    }

    public class ResponseWrapper{
        @AuraEnabled public Id partId{get; set;} 
        @AuraEnabled public String partName{get; set;} 
        @AuraEnabled public Decimal Qty{get; set;} 
        @AuraEnabled public Decimal last365{get; set;} 
        @AuraEnabled public Decimal allTime{get; set;} 
    }
}