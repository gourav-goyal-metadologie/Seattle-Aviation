global without sharing class PartMasterAggregateResultIterator implements Iterator<AggregateResult> {
    global List<AggregateResult> results {get;set;}

    // tracks which result item is returned
    global Integer index {get; set;}

    global PartMasterAggregateResultIterator(String query, Set<String> uniquePartNumbersToProcess) {
        index = 0;
        results = Database.query(query);
    }

    global Boolean hasNext(){
        return results != null && !results.isEmpty() && index < results.size();
    }

    global AggregateResult next(){
        return results[index++];
    }
}