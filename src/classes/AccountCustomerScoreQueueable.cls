/**
 * This class created for replacement of future method
 */
public class AccountCustomerScoreQueueable implements Queueable{
    public Set<String> accountIds;
    public String objectType;
    public AccountCustomerScoreQueueable(Set<String> accountIds, String objectType){
        this.accountIds = accountIds;
        this.objectType = objectType;
    }

    public void execute(QueueableContext context) {
        switch on objectType {
            when 'customer quote' {
                updateCustomerQuoteOrderLineCount(this.accountIds);
            }
            when 'sales order' {
                updateCustomerSalesOrderValues(this.accountIds);
            }
            when 'invoice' {
                updateCustomeMargin(this.accountIds);
            }
            when else {
                System.debug('Object Type not defined in queueable class');
            }
        }
    }

    /**
     * description : used when customer quote will trigger
     */
    public void updateCustomerQuoteOrderLineCount(Set<String> accountIds) {
        try{
            Set<String> accIdSet = accountIds;
            if(accIdSet.size() > 0) {
                Map<Id, Decimal> accountIdToNumberOfCQLMap = new Map<Id, Decimal>();
                for(AggregateResult aggregateResult : [SELECT COUNT(Id) NumbersOfCQL, inscor__Customer_Quote__r.inscor__Customer__c AccountId FROM inscor__Customer_Quote_Line__c WHERE CreatedDate = LAST_N_DAYS:30 AND inscor__Customer_Quote__r.inscor__Customer__c IN :accIdSet GROUP BY inscor__Customer_Quote__r.inscor__Customer__c]) {
                    accountIdToNumberOfCQLMap.put((Id)aggregateResult.get('AccountId'), (Decimal)aggregateResult.get('NumbersOfCQL'));
                }
                List<Account> accUpdateList = new List<Account>();
                List<Account> accounts = new List<Account>([SELECT Id, Customer_Quotes_Lines_Received__c, Sales_Orders_Lines_Received__c, Total_Sales__c, Average_Margin__c 
                                                                FROM Account WHERE Id IN :accountIds FOR UPDATE]);
                for(Account acc : accounts){
                    if(accountIdToNumberOfCQLMap.containsKey(acc.Id)) {
                        acc.Customer_Quotes_Lines_Received__c = accountIdToNumberOfCQLMap.get(acc.Id);
                    } else {
                        acc.Customer_Quotes_Lines_Received__c = 0;
                    }
                }
                // for(String accId : accIdSet){
                //     Account acc = new Account(Id = accId);
                //     if(accountIdToNumberOfCQLMap.containsKey(acc.Id)) {
                //         acc.Customer_Quotes_Lines_Received__c = accountIdToNumberOfCQLMap.get(acc.Id);
                //     } else {
                //         acc.Customer_Quotes_Lines_Received__c = 0;
                //     }
                //     accUpdateList.add(acc);
                // }
                //update accUpdateList;
                update accounts;
            }
        } catch(Exception error) {
            System.debug('error:' + error.getMessage());
            LogService.createErrorLog('AccountCustomerScoreQueueable.apxc', NULL, error, NULL);	
        } 
    }

    /**
     * description : method used to when sales order will trigger
     */
    public static void updateCustomerSalesOrderValues(Set<String> accountIds) {
        try{
            //Set<String> accIdSet = getAccountIds(salesOrders);
            if(accountIds.size() > 0) {
                Map<Id, Decimal> accountIdToNumberOfSOLMap = new Map<Id, Decimal>();
                Map<Id, Decimal> accountIdToTotalSalesMap = new Map<Id, Decimal>();
                for(AggregateResult aggregateResult : [SELECT COUNT(Id) NumbersOfSOL, 
                                                       SUM(inscor__Line_Total__c) TotalSales,
                                                       inscor__Order__r.inscor__Customer__c AccountId 
                                                       FROM inscor__Sales_Order_Line__c 
                                                       WHERE CreatedDate = LAST_N_DAYS:30 
                                                       AND inscor__Order__r.inscor__Customer__c IN :accountIds 
                                                       GROUP BY inscor__Order__r.inscor__Customer__c]) {
                    accountIdToNumberOfSOLMap.put((Id)aggregateResult.get('AccountId'), (Integer)aggregateResult.get('NumbersOfSOL'));
                    accountIdToTotalSalesMap.put((Id)aggregateResult.get('AccountId'), (Decimal)aggregateResult.get('TotalSales'));
                }
                
                List<Account> accounts = new List<Account>([SELECT Id, Customer_Quotes_Lines_Received__c, Sales_Orders_Lines_Received__c, Total_Sales__c, Average_Margin__c 
                                                                FROM Account WHERE Id IN :accountIds FOR UPDATE]);
                for(Account acc : accounts){
                    if(accountIdToNumberOfSOLMap.containsKey(acc.Id)) {
                        acc.Sales_Orders_Lines_Received__c = accountIdToNumberOfSOLMap.get(acc.Id);
                        acc.Total_Sales__c = accountIdToTotalSalesMap.get(acc.Id);
                    } else {
                        acc.Sales_Orders_Lines_Received__c = 0;
                        acc.Total_Sales__c = 0;
                    }
                }
                update accounts;
                // for(String accId : accIdSet){
                //     Account acc = new Account(Id = accId);
                //     if(accountIdToNumberOfSOLMap.containsKey(acc.Id)) {
                //         acc.Sales_Orders_Lines_Received__c = accountIdToNumberOfSOLMap.get(acc.Id);
                //         acc.Total_Sales__c = accountIdToTotalSalesMap.get(acc.Id);
                //     } else {
                //         acc.Sales_Orders_Lines_Received__c = 0;
                //         acc.Total_Sales__c = 0;
                //     }
                //     accUpdateList.add(acc);
                // }
                // update accUpdateList;
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
                for(AggregateResult aggregateResult : [SELECT AVG(inscor__Margin_Percent__c) AverageMarginPercent, inscor__Account__c AccountId FROM inscor__Invoice__c WHERE CreatedDate = LAST_N_DAYS:30 AND inscor__Account__c IN :accIdSet GROUP BY inscor__Account__c]) {
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