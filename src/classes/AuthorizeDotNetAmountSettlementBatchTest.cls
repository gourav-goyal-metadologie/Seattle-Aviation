@isTest
public class AuthorizeDotNetAmountSettlementBatchTest {
    
    @isTest
    Private static void settledPaymentBatch(){
        Account objAcc = new Account(Name ='Test Batch');
        insert objAcc;
        Test.startTest();
        AuthorizeDotNetAmountSettlementBatch testCall = new AuthorizeDotNetAmountSettlementBatch();
        Database.executeBatch(testCall);
        Database.executeBatch(new Batch_Copy_Part_Master_to_SKU(), 1);
        Test.stopTest();
    }

}