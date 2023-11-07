global class CustomerScoreCalcVerSecondBatch implements Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id, Average_Margin__c, Sales_Orders_Lines_Received__c, ' +
            		   'Total_Sales__c, Customer_Quotes_Lines_Received__c FROM Account';
        return Database.getQueryLocator(query);
    }
        
    global void execute(Database.BatchableContext BC, List<Account> accList) {
        accList = populateSalesOrderLines(accList);
        accList = populateCustomerQuoteLines(accList);
        accList = populateCustomerMargin(accList);
        accList = customerScoreCalculations(accList);
        update accList;
    }   
        
    global void finish(Database.BatchableContext BC) {}
    
    private static List<Account> populateSalesOrderLines(List<Account> accList){
        Set<String> accIdSet = new Set<String>();
        for (Account acc : accList) {
            accIdSet.add(acc.Id);
        }
        if(accIdSet.size() > 0) {
            Map<Id, Decimal> accountIdToNumberOfSOLMap = new Map<Id, Decimal>();
            Map<Id, Decimal> accountIdToTotalSalesMap = new Map<Id, Decimal>();
            for(AggregateResult aggregateResult : [SELECT COUNT(Id) NumbersOfSOL, 
                                                    SUM(inscor__Line_Total__c) TotalSales,
                                                    inscor__Order__r.inscor__Customer__c AccountId 
                                                    FROM inscor__Sales_Order_Line__c 
                                                    WHERE CreatedDate = LAST_N_DAYS:30 
                                                    AND inscor__Order__r.inscor__Customer__c IN :accIdSet 
                                                    GROUP BY inscor__Order__r.inscor__Customer__c]) {
                accountIdToNumberOfSOLMap.put((Id)aggregateResult.get('AccountId'), (Integer)aggregateResult.get('NumbersOfSOL'));
                accountIdToTotalSalesMap.put((Id)aggregateResult.get('AccountId'), (Decimal)aggregateResult.get('TotalSales'));
            }
            for (Account acc : accList) {
                if(accountIdToNumberOfSOLMap.containsKey(acc.Id)) {
                    acc.Sales_Orders_Lines_Received__c = accountIdToNumberOfSOLMap.get(acc.Id);
                    acc.Total_Sales__c = accountIdToTotalSalesMap.get(acc.Id);
                } else {
                    acc.Sales_Orders_Lines_Received__c = 0;
                    acc.Total_Sales__c = 0;
                }
            }
        }
        return accList;
    }

    private static List<Account> populateCustomerQuoteLines(List<Account> accList){
        Set<String> accIdSet = new Set<String>();
        for (Account acc : accList) {
            accIdSet.add(acc.Id);
        }

        if(accIdSet.size() > 0) {
            Map<Id, Decimal> accountIdToNumberOfCQLMap = new Map<Id, Decimal>();
            for(AggregateResult aggregateResult : [SELECT COUNT(Id) NumbersOfCQL, inscor__Customer_Quote__r.inscor__Customer__c AccountId 
                                                    FROM inscor__Customer_Quote_Line__c 
                                                    WHERE CreatedDate = LAST_N_DAYS:30 AND inscor__Customer_Quote__r.inscor__Customer__c IN :accIdSet 
                                                    GROUP BY inscor__Customer_Quote__r.inscor__Customer__c]) {
                accountIdToNumberOfCQLMap.put((Id)aggregateResult.get('AccountId'), (Decimal)aggregateResult.get('NumbersOfCQL'));
            }
            for (Account acc : accList) {
                if(accountIdToNumberOfCQLMap.containsKey(acc.Id)) {
                    acc.Customer_Quotes_Lines_Received__c = accountIdToNumberOfCQLMap.get(acc.Id);
                } else {
                    acc.Customer_Quotes_Lines_Received__c = 0;
                }
            }
        }
        return accList;
    }

    private static List<Account> populateCustomerMargin(List<Account> accList) {
        Set<String> accIdSet = new Set<String>();
        for (Account acc : accList) {
            accIdSet.add(acc.Id);
        }
        if(accIdSet.size() > 0) {
            Map<Id, Decimal> accountIdToAvgMarginPercentMap = new Map<Id, Decimal>();
            for(AggregateResult aggregateResult : [SELECT AVG(inscor__Margin_Percent__c) AverageMarginPercent, inscor__Account__c AccountId FROM inscor__Invoice__c WHERE CreatedDate = LAST_N_DAYS:30 AND inscor__Account__c IN :accIdSet GROUP BY inscor__Account__c]) {
                accountIdToAvgMarginPercentMap.put((Id)aggregateResult.get('AccountId'), (Decimal)aggregateResult.get('AverageMarginPercent'));
            }
            for (Account acc : accList) {
                if(accountIdToAvgMarginPercentMap.containsKey(acc.Id)) {
                    acc.Average_Margin__c = accountIdToAvgMarginPercentMap.get(acc.Id);
                } else {
                    acc.Average_Margin__c = 0;
                }
            }
        }
        return accList;
    }
    

    private static List<Account> customerScoreCalculations(List<Account> accList) {
        List<Customer_Score_Factor__mdt> customerScoreFactorList = [SELECT Weightage__c, Starting_Number__c, Ending_Number__c, Type__c FROM Customer_Score_Factor__mdt];        
        Decimal numberOfSOL;
        Decimal numberOfCQL;
        Decimal totalSales;
        Decimal avgMarginPercent;
        for(Account acc : accList) {
            numberOfSOL = acc.Sales_Orders_Lines_Received__c;
            numberOfCQL = acc.Customer_Quotes_Lines_Received__c;
            totalSales = acc.Total_Sales__c;
            avgMarginPercent = acc.Average_Margin__c;
            acc.Customer_Score_2__c = 0;
            for(Customer_Score_Factor__mdt customerScoreFactor : customerScoreFactorList) {
                if(customerScoreFactor.Type__c == 'Sales Orders Lines Received' && customerScoreFactor.Starting_Number__c <= numberOfSOL && (customerScoreFactor.Ending_Number__c == null || customerScoreFactor.Ending_Number__c >= numberOfSOL)) {
                    acc.Customer_Score_2__c += customerScoreFactor.Weightage__c;
                }
                if(customerScoreFactor.Type__c == 'Customer Quotes Lines Received' && customerScoreFactor.Starting_Number__c <= numberOfCQL && (customerScoreFactor.Ending_Number__c == null || customerScoreFactor.Ending_Number__c >= numberOfCQL)) {
                    acc.Customer_Score_2__c += customerScoreFactor.Weightage__c;
                }
                if(customerScoreFactor.Type__c == 'Total Sales' && customerScoreFactor.Starting_Number__c <= totalSales && (customerScoreFactor.Ending_Number__c == null || customerScoreFactor.Ending_Number__c >= totalSales)) {
                    acc.Customer_Score_2__c += customerScoreFactor.Weightage__c;
                }
                if(customerScoreFactor.Type__c == 'Margin' && customerScoreFactor.Starting_Number__c <= avgMarginPercent && (customerScoreFactor.Ending_Number__c == null || customerScoreFactor.Ending_Number__c >= avgMarginPercent)) {
                    acc.Customer_Score_2__c += customerScoreFactor.Weightage__c;
                }
            }
        }
        return accList;
    }
}