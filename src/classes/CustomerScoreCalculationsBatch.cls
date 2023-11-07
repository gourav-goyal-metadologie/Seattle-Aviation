global class CustomerScoreCalculationsBatch implements Database.Batchable<sObject>, Schedulable {

    global CustomerScoreCalculationsBatch() {}

    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT Id FROM Account');
    }
     
    global void execute(Database.BatchableContext BC, List<Account> accList) {
        accList = populateSalesOrderLines(accList);
        accList = populateCustomerQuoteLines(accList);
        accList = populateTotalSales(accList);
        accList = populateAvgMarginPercent(accList);
        accList = customerScoreCalculations(accList);
        update accList;
    }   
     
    global void finish(Database.BatchableContext BC) {}
    
    global void execute(SchedulableContext sc) {
      Database.executeBatch(new CustomerScoreCalculationsBatch(), 200);
   }

    private static List<Account> populateSalesOrderLines(List<Account> accList){
        Map<Id, Integer> accountIdToNumberOfSOLMap = new Map<Id, Integer>();
        List<inscor__Sales_Order__c> salesOrderList = [SELECT Id FROM inscor__Sales_Order__c WHERE inscor__Customer__c IN :accList];
        for(AggregateResult aggregateResult : [SELECT COUNT(Id) NumbersOfSOL, inscor__Order__r.inscor__Customer__c AccountId FROM inscor__Sales_Order_Line__c WHERE CreatedDate = LAST_N_DAYS:30 AND inscor__Order__c IN :salesOrderList GROUP BY inscor__Order__r.inscor__Customer__c]) {
            accountIdToNumberOfSOLMap.put((Id)aggregateResult.get('AccountId'), (Integer)aggregateResult.get('NumbersOfSOL'));
        }
        
        for(Account acc : accList){
            if(accountIdToNumberOfSOLMap.containsKey(acc.Id)) {
                acc.Sales_Orders_Lines_Received__c = accountIdToNumberOfSOLMap.get(acc.Id);
            } else {
                acc.Sales_Orders_Lines_Received__c = 0;
            }
        }
        return accList;
    }

    private static List<Account> populateCustomerQuoteLines(List<Account> accList){
        Map<Id, Decimal> accountIdToNumbersOfCQLMap = new Map<Id, Decimal>();
        List<inscor__Customer_Quote__c> customerQuoteList = [SELECT Id FROM inscor__Customer_Quote__c WHERE inscor__Customer__c IN :accList];
        for(AggregateResult aggregateResult : [SELECT COUNT(Id) NumbersOfCQL, inscor__Customer_Quote__r.inscor__Customer__c AccountId FROM inscor__Customer_Quote_Line__c WHERE CreatedDate = LAST_N_DAYS:30 AND inscor__Customer_Quote__c IN :customerQuoteList GROUP BY inscor__Customer_Quote__r.inscor__Customer__c]) {
            accountIdToNumbersOfCQLMap.put((Id)aggregateResult.get('AccountId'), (Decimal)aggregateResult.get('NumbersOfCQL'));
        }

        for(Account acc : accList){
            if(accountIdToNumbersOfCQLMap.containsKey(acc.Id)) {
                acc.Customer_Quotes_Lines_Received__c = accountIdToNumbersOfCQLMap.get(acc.Id);
            } else {
                acc.Customer_Quotes_Lines_Received__c = 0;
            }
        }
        return accList;
    }

    private static List<Account> populateTotalSales(List<Account> accList) {
        Map<Id, Decimal> accountIdToTotalSalesMap = new Map<Id, Decimal>();
        for(AggregateResult aggregateResult : [SELECT SUM(inscor__Sales_Order_Total_Value__c) TotalSales, inscor__Customer__c AccountId FROM inscor__Sales_Order__c WHERE inscor__Customer__c IN :accList GROUP BY inscor__Customer__c]) {
            accountIdToTotalSalesMap.put((Id)aggregateResult.get('AccountId'), (Decimal)aggregateResult.get('TotalSales'));
        }

        for(Account acc : accList){
            if(accountIdToTotalSalesMap.containsKey(acc.Id)) {
                acc.Total_Sales__c = accountIdToTotalSalesMap.get(acc.Id);
            } else {
                acc.Total_Sales__c = 0;
            }
        }
        return accList;
    }

    private static List<Account> populateAvgMarginPercent(List<Account> accList) {
        Map<Id, Decimal> accountIdToAvgMarginPercentMap = new Map<Id, Decimal>();
        for(AggregateResult aggregateResult : [SELECT AVG(inscor__Margin_Percent__c) AverageMarginPercent, inscor__Account__c AccountId FROM inscor__Invoice__c WHERE inscor__Account__c IN :accList GROUP BY inscor__Account__c]) {
            accountIdToAvgMarginPercentMap.put((Id)aggregateResult.get('AccountId'), (Decimal)aggregateResult.get('AverageMarginPercent'));
        }

        for(Account acc : accList) {
            if(accountIdToAvgMarginPercentMap.containsKey(acc.Id)) {
                acc.Average_Margin__c = accountIdToAvgMarginPercentMap.get(acc.Id);
            } else {
                acc.Average_Margin__c = 0;
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