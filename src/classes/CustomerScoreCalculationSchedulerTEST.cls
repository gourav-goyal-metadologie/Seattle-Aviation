@IsTest
private class CustomerScoreCalculationSchedulerTEST {

    @IsTest
    static void testCustomerScoreCalculationScheduler(){
        
        Test.startTest();
        CustomerScoreCalculationScheduler scheduler = new CustomerScoreCalculationScheduler();
        String cronExpression = '0 0 23 * * ?';
        System.schedule('Test Customer Score Calculation Scheduler', cronExpression, scheduler);
        Test.stopTest();
        
    }
}