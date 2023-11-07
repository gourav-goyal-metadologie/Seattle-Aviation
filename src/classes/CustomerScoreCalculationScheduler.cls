/**************************************************************************************************
Description: Scheduler to schedule CustomerScoreCalcVerBatc
====================================================================================================
====================================================================================================
====================================================================================================
testClass : CustomerScoreCalculationSchedulerTEST
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		11/09/2021		   Vinod Kumar Sharma				Initial Creation    
***************************************************************************************************/
global class CustomerScoreCalculationScheduler implements Schedulable {
    global void execute(SchedulableContext sc) {
        Id batchJobId = Database.executeBatch(new CustomerScoreCalcVerSecondBatch(), 100);
        System.debug('------> batchJobId ----------> ' + batchJobId);
    }
}