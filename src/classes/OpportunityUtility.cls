public class OpportunityUtility {
    Public static Decimal ProbablityPartMultiplier = 75;
    Public static Decimal ProbablityConversionMultiplier = 25;

    
    public static void calculateOpportunityProbablity(Set<String> accIds){
        System.debug('OpportunityUtility.calculateOpportunityProbablity.accIds:' + accIds);
        
        List<inscor__Customer_Quote__c> customerQuotes = [Select Id,inscor__Customer__c,inscor__Status__c,
                                                          (Select Id,inscor__Quantity__c,inscor__Business_Category__c from inscor__Customer_Quote_Lines__r LIMIT 200),
                                                          (Select Id,Winning_Probablity__c,accountId,Customer_Quote__c from Opportunities__r)
                                                          FROM inscor__Customer_Quote__c 
                                                          WHERE inscor__Customer__c IN : accIds AND CreatedDate = LAST_N_DAYS:30 AND inscor__Status__c = 'Closed - Won'];
        if (!customerQuotes.isEmpty()) {
            List<Opportunity> oppList = new List<Opportunity>();
            Map<Id,Decimal> accConvertionMap = new Map<Id,Decimal>();
            Map<Id, Integer> noOfCustomreQuotesByAccountId = new Map<Id, Integer>();
            for (AggregateResult result : [SELECT COUNT(Id) noOfQuotes, inscor__Customer__c accountId FROM inscor__Customer_Quote__c 
                                            WHERE inscor__Customer__c IN :accIds AND CreatedDate = LAST_N_DAYS:30
                                            GROUP BY inscor__Customer__c]) {
                noOfCustomreQuotesByAccountId.put((Id)result.get('accountId'), (Integer)result.get('noOfQuotes'));
            }
    
            for (AggregateResult result : [SELECT COUNT(Id) noOfSalesOrders, inscor__Customer__c accountId FROM inscor__Sales_Order__c 
                                            WHERE inscor__Customer__c IN :accIds AND CreatedDate = LAST_N_DAYS:30
                                            GROUP BY inscor__Customer__c]) {
                Id accountId = (Id)result.get('accountId');
                Decimal quoteCount = noOfCustomreQuotesByAccountId.containsKey(accountId) ? noOfCustomreQuotesByAccountId.get(accountId) : 0;
                Decimal salesCount = (Integer)result.get('noOfSalesOrders');
                if (quoteCount != 0) {
                    accConvertionMap.put(accountId, ((salesCount/quoteCount) * ProbablityConversionMultiplier));
                }
                System.debug(accConvertionMap);
            }
    
            for(inscor__Customer_Quote__c quoteRec : customerQuotes){
                Decimal categoryParts = 0;
                Decimal totalParts = 0;
                if(quoteRec.inscor__Customer_Quote_Lines__r.size() > 0){
                    for(inscor__Customer_Quote_Line__c quoteLine : quoteRec.inscor__Customer_Quote_Lines__r){
                        if(quoteLine.inscor__Business_Category__c != null && quoteLine.inscor__Quantity__c != null){
                            if(quoteLine.inscor__Business_Category__c == 'Surplus'){
                                categoryParts += quoteLine.inscor__Quantity__c * 1;
                            }else if(quoteLine.inscor__Business_Category__c == 'Distribution'){
                                categoryParts += quoteLine.inscor__Quantity__c * 0.7;
                            }else if(quoteLine.inscor__Business_Category__c == 'Broker'){
                                categoryParts += quoteLine.inscor__Quantity__c * 0.4;
                            }
                            totalParts += quoteLine.inscor__Quantity__c;
                        }
                    } 
                    Decimal PartNumberValue = totalParts == 0 ? null :  ((categoryParts/totalParts) * ProbablityPartMultiplier);
                    System.debug('PartNumberValue:' + PartNumberValue);
                    for(Opportunity opp : quoteRec.Opportunities__r){
                        opp.Winning_Probablity__c = (PartNumberValue != null ? PartNumberValue : 0) + (accConvertionMap.containsKey(opp.AccountId) ? accConvertionMap.get(opp.AccountId) : 0);
                        opp.Winning_Probablity__c = opp.Winning_Probablity__c != null ? (opp.Winning_Probablity__c > 100 ? 100 : opp.Winning_Probablity__c) : 0;
                        if(opp.Winning_Probablity__c != 0)    oppList.add(opp);
                    }
                }else {
                    for(Opportunity opp : quoteRec.Opportunities__r){
                        opp.Winning_Probablity__c = 0 + (accConvertionMap.containsKey(opp.AccountId) ? accConvertionMap.get(opp.AccountId) : 0);
                        oppList.add(opp);
                    }
                }
            }
            if(oppList.size() > 0)    update oppList;
        }
    } 
}