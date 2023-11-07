public class AccountUtility {
    /**
     * description : used when customer quote will trigger
     */
    public static void updateCustomerQuoteOrderLineCount(Set<String> accountIds) {
        try{
            Set<String> accIdSet = accountIds;
            if(accIdSet.size() > 0) {
                Map<Id, Decimal> accountIdToNumberOfCQLMap = new Map<Id, Decimal>();
                Map<Id, Decimal> accountIdToNumberOfPartsRequestedMap = new Map<Id, Decimal>();
                for(AggregateResult aggregateResult : [SELECT COUNT(Id) NumbersOfCQL, Sum(inscor__Quantity__c) partsRequested, inscor__Customer_Quote__r.inscor__Customer__c AccountId 
                                                        FROM inscor__Customer_Quote_Line__c 
                                                        WHERE CreatedDate = LAST_N_DAYS:365 AND inscor__Customer_Quote__r.inscor__Customer__c IN :accIdSet 
                                                        GROUP BY inscor__Customer_Quote__r.inscor__Customer__c]) {
                    accountIdToNumberOfCQLMap.put((Id)aggregateResult.get('AccountId'), (Decimal)aggregateResult.get('NumbersOfCQL'));
                    accountIdToNumberOfPartsRequestedMap.put((Id)aggregateResult.get('AccountId'), (Decimal)aggregateResult.get('partsRequested'));
                }

                List<Account> accUpdateList = new List<Account>();
                List<Account> accountsToUpdate = new List<Account>();
                for(String accountId : accountIds){
                    Account acc = new Account(Id = accountId);
                    if (accountIdToNumberOfPartsRequestedMap.containsKey(acc.Id)) {
                        acc.Number_of_Parts_Requested__c = accountIdToNumberOfPartsRequestedMap.get(acc.Id);
                    }
                    if(accountIdToNumberOfCQLMap.containsKey(acc.Id)) {
                        acc.Customer_Quotes_Lines_Received__c = accountIdToNumberOfCQLMap.get(acc.Id);
                    } else {
                        acc.Customer_Quotes_Lines_Received__c = 0;
                    }
                    accountsToUpdate.add(acc);
                }
                update accountsToUpdate;
            }
        } catch(Exception error) {
            System.debug('error:' + error.getMessage());
            LogService.createErrorLog('AccountUtility.apxc', NULL, error, NULL);	
        } 
    }

    /**
     * description : method used to update account fields when Sales Order Line Item Changed or Inserted
     */
    public static void updateCustomerSalesOrderValues(Set<String> accountIds) {
        try{
            //Set<String> accIdSet = getAccountIds(salesOrders);
            if(accountIds.size() > 0) {
                Map<Id, Decimal> accountIdToNumberOfSOLMap = new Map<Id, Decimal>();
                Map<Id, Decimal> accountIdToTotalSalesMap = new Map<Id, Decimal>();
                Map<Id, Decimal> accountIdToNumberOfPartsRequestedMap = new Map<Id, Decimal>();
                for(AggregateResult aggregateResult : [SELECT COUNT(Id) NumbersOfSOL, Sum(inscor__Quantity_Ordered__c) partsRequested,
                                                       SUM(inscor__Line_Total__c) TotalSales,
                                                       inscor__Order__r.inscor__Customer__c AccountId 
                                                       FROM inscor__Sales_Order_Line__c 
                                                       WHERE CreatedDate = LAST_N_DAYS:365 
                                                       AND inscor__Order__r.inscor__Customer__c IN :accountIds
                                                       GROUP BY inscor__Order__r.inscor__Customer__c]) {
                    accountIdToNumberOfSOLMap.put((Id)aggregateResult.get('AccountId'), (Integer)aggregateResult.get('NumbersOfSOL'));
                    accountIdToTotalSalesMap.put((Id)aggregateResult.get('AccountId'), (Decimal)aggregateResult.get('TotalSales'));
                    accountIdToNumberOfPartsRequestedMap.put((Id)aggregateResult.get('AccountId'), (Decimal)aggregateResult.get('partsRequested'));
                }
                List<Account> accountsToUpdate = new List<Account>();
                for(String accountId : accountIds){
                    if (accountIdToNumberOfSOLMap.containsKey(accountId)) {
                        Account acc = new Account(Id = accountId);
                        acc.Number_of_Parts_Ordered__c = accountIdToNumberOfPartsRequestedMap.get(acc.Id);
                        acc.Sales_Orders_Lines_Received__c = accountIdToNumberOfSOLMap.get(acc.Id);
                        acc.Total_Sales__c = accountIdToTotalSalesMap.get(acc.Id);
                        accountsToUpdate.add(acc);
                    }  
                }
                update accountsToUpdate;
            }
        } catch(Exception error) {
            LogService.createErrorLog('SalesOrdersTriggerHelper.apxc', NULL, error, NULL);	
        } 
    }

    /**
     * description : method used when Invoice will trigger
     */
    public static void updateCustomeMargin(Set<String> accIdSet) {
        try{
            //Set<String> accIdSet = getAccountIds(invoices);
            if(accIdSet.size() > 0) {
                Map<Id, Decimal> accountIdToAvgMarginPercentMap = new Map<Id, Decimal>();
                for(AggregateResult aggregateResult : [SELECT AVG(inscor__Margin_Percent__c) AverageMarginPercent, inscor__Account__c AccountId 
                                                        FROM inscor__Invoice__c 
                                                        WHERE CreatedDate = LAST_N_DAYS:365 AND inscor__Account__c IN :accIdSet GROUP BY inscor__Account__c]) {
                    accountIdToAvgMarginPercentMap.put((Id)aggregateResult.get('AccountId'), (Decimal)aggregateResult.get('AverageMarginPercent'));
                }
                List<Account> accUpdateList = new List<Account>();
                for(String accId : accIdSet){
                    Account acc = new Account(Id = accId);
                    if(accountIdToAvgMarginPercentMap.containsKey(acc.Id)) {
                        acc.Average_Margin__c = accountIdToAvgMarginPercentMap.get(acc.Id);
                    } else {
                        acc.Average_Margin__c = 0;
                    }
                    accUpdateList.add(acc);
                }
                update accUpdateList;
            }
        } catch(Exception error) {
            LogService.createErrorLog('InvoiceTriggerHandler.apxc', NULL, error, NULL);	
        } 
    }
}