global class AuthorizeDotNetAmountSettlementBatch implements Database.Batchable<sObject>,Database.AllowsCallouts {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id,Name FROM Account limit 2';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Account> scope) {
        try {
            AmountSettlementAuthorizeDotNet.getUnsettledTransactions();
        } catch(Exception e) {
            System.debug('Mera error: '+e.getMessage());
        }
        
    }   
    
    global void finish(Database.BatchableContext BC) {
        // execute any post-processing operations
    }
}