public class PartNumberController {

    @AuraEnabled
    public static List<inscor__Customer_Quote_Line__c> getCustomerQuotesLineItem(Integer pageSize, Integer pageNumber, String recordId, String searchKey){
        List<inscor__Customer_Quote_Line__c> customerLines = new List<inscor__Customer_Quote_Line__c>();
        try{
            Integer offset = (pageNumber - 1) * pageSize;
            Opportunity oppRec = [Select Id,Name,Customer_Quote__c From Opportunity Where Id =: recordId];
            String recId = oppRec.Customer_Quote__c;
            
            String query = 'Select Id,Name,inscor__Product__c,inscor__Product__r.Name, inscor__Customer_Quote__c,inscor__Business_Category__c,inscor__Quantity__c From inscor__Customer_Quote_Line__c Where inscor__Customer_Quote__c =: recId';
    
            if(searchKey != null){
                searchKey = '%' + searchKey + '%';
                query += ' AND inscor__Product__r.Name LIKE: searchKey' ;
            }    
            query += ' LIMIT :pageSize OFFSET :offset';
            customerLines = Database.query(query);
            
        } catch(Exception error) {
            LogService.createErrorLog('CustomerQuoteTriggerHelper.apxc', NULL, error, NULL);
        }
        return customerLines;
    }
}