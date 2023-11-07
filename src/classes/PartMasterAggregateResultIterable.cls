global without sharing class PartMasterAggregateResultIterable implements Iterable<AggregateResult> {
    private String query;
    private Set<String> uniquePartNumbersToProcess;

    global PartMasterAggregateResultIterable(String soql, Set<String> uniquePartNumbersToProcess){
        query = soql;
        this.uniquePartNumbersToProcess = uniquePartNumbersToProcess;
    }

    global Iterator<AggregateResult> iterator(){
        return new PartMasterAggregateResultIterator(query, uniquePartNumbersToProcess);
    }
}