global class SettledPaymentBatchScheduler implements Schedulable{

    public static String sched = '0 00 00 * * ?';  //Every Day at Midnight 

    global static String scheduleMe() {
        SettledPaymentBatchScheduler SC = new SettledPaymentBatchScheduler();
        return System.schedule('Settled Payment Batch Scheduler - Authorize.net', sched, SC);
    }

    global void execute(SchedulableContext sc) {
        AuthorizeDotNetAmountSettlementBatch b1 = new AuthorizeDotNetAmountSettlementBatch();
        ID batchprocessid = Database.executeBatch(b1,200);
    }
}