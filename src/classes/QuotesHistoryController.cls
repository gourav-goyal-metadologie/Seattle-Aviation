/**
 * @author - Keykloud
 * @description - Class created for the lwc component name as quoteHistory
 * @TestClass - pending
 * @createdDate - 12/17/2021
 * @lastModifiedDate - 12/22/2021
 * @lastModifiedBy - KeyKloud
 */
public without sharing class QuotesHistoryController {

    
    @AuraEnabled(cacheable=true)
    public static List<QuotesHistoryWrapper> getCustomerQuote(){

        List<QuotesHistoryWrapper> quotesHistoryWrapperList = new List<QuotesHistoryWrapper>();
        User usr = getLoggedInUser();
        if (usr.Contact.Is_Super_User__c && usr.Contact.AccountId != null) {
            List<inscor__Customer_Quote__c> quotes = [SELECT id, Name, inscor__Quote_Total__c, inscor__Create_Date__c, inscor__Status__c, 
                            inscor__Contact__c, inscor__Contact__r.Name 
                            FROM inscor__Customer_Quote__c WHERE  inscor__Customer__c = :usr.Contact.AccountId ORDER BY inscor__Create_Date__c DESC LIMIT 10000];
            for(inscor__Customer_Quote__c quote : quotes){
                quotesHistoryWrapperList.add(createQuoteHistoryWrapper(quote));
            }
        }else if (!usr.Contact.Is_Super_User__c && usr.ContactId != null) {
            List<inscor__Customer_Quote__c> quotes = [SELECT id, Name, inscor__Quote_Total__c, inscor__Create_Date__c, inscor__Status__c, 
                            inscor__Contact__c, inscor__Contact__r.Name 
                            FROM inscor__Customer_Quote__c WHERE  inscor__Contact__c = :usr.ContactId ORDER BY inscor__Create_Date__c DESC LIMIT 10000];

            for(inscor__Customer_Quote__c quote : quotes){
                quotesHistoryWrapperList.add(createQuoteHistoryWrapper(quote));
            }
        }
        return quotesHistoryWrapperList;
    }

    @AuraEnabled
    public static List<QuotesHistoryWrapper> getQuotesBySearch(string quoteName, string quoteAmount, string quoteDate, string quoteType, string status, string partNumber){
        try {
            Decimal quoteAmountDecimal = (quoteAmount != null && quoteAmount != '') ? decimal.valueOf(quoteAmount) : null;
            Date cDate = (quoteDate != null && quoteDate != '') ? Date.valueOf(quoteDate) : null;
            quoteName = (quoteName != null && quoteName != '') ? quoteName + '%' : null;
            List<QuotesHistoryWrapper> quotesHistoryWrapperList = new List<QuotesHistoryWrapper>();
            String query = 'SELECT id, Name, inscor__Quote_Total__c, inscor__Create_Date__c, inscor__Status__c, inscor__Contact__c, inscor__Contact__r.Name ';
            query += 'FROM inscor__Customer_Quote__c ';
            query += 'WHERE';
            User usr = getLoggedInUser();
            String customerId = usr.Contact.AccountId;
            String contactId = usr.ContactId;
            if (contactId != null ) {
                if (usr.Contact.Is_Super_User__c) {
                    query += ' inscor__Customer__c = :customerId AND';
                }else {
                    query += ' inscor__Contact__c = :contactId AND';
                }
                // Boolean isConditionAdded = false;
                if (quoteName != null &&  quoteName != '') {
                    query += ' Name LIKE :quoteName AND';
                    // isConditionAdded = true;
                }
                if (quoteAmountDecimal != null) {
                    query += ' inscor__Quote_Total__c =:quoteAmountDecimal AND';
                    // isConditionAdded = true;
                }
                if (status != null &&  status != '') {
                    query += ' inscor__Status__c =:status AND';
                    // isConditionAdded = true;
                }
                if (cDate != null) {
                    query += ' DAY_ONLY(inscor__Create_Date__c) =: cDate AND';
                    // isConditionAdded = true;
                }
                if (partNumber != null &&  partNumber != '') {
                    query += ' Id IN (SELECT inscor__Customer_Quote__c FROM inscor__Customer_Quote_Line__c WHERE inscor__Product__r.Name =:partNumber ';
                    if (quoteType != null) {
                        query += 'AND inscor__Quote_Type__c =: quoteType';
                    }
                    query +=') ';
                    // isConditionAdded = true;
                }else if (quoteType != null) {
                    query += ' Id IN (SELECT inscor__Customer_Quote__c FROM inscor__Customer_Quote_Line__c WHERE inscor__Quote_Type__c =: quoteType) ';
                    // isConditionAdded = true;
                }
    
                query = query.removeEnd('AND');
                query+= ' ORDER BY inscor__Create_Date__c DESC LIMIT 10000';
    
                System.debug(query);
    
                List<inscor__Customer_Quote__c> quotes = Database.Query(query);
                system.debug('quotes >> '+ quotes);
                for(inscor__Customer_Quote__c quote : quotes){
                    system.debug('inside for loop >>');
                    quotesHistoryWrapperList.add(createQuoteHistoryWrapper(quote));
                }
            }
                                                            
            return quotesHistoryWrapperList;
        } catch (Exception e) {
            System.debug(e.getStackTraceString());
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<QuoteLineWrapper> getQuoteLinesById(String quoteId){
        try {
            List<QuoteLineWrapper> quoteLineWrappers = new List<QuoteLineWrapper>();
            Integer count = 1;
            for(inscor__Customer_Quote_Line__c lineItem : [SELECT id, inscor__Product__r.Name, inscor__Product__r.inscor__Description__c, inscor__Condition_Code__r.Name, 
                            inscor__Quantity__c, inscor__Part_Number_UOM__c, inscor__Price__c, inscor__Line_Total__c 
                            FROM inscor__Customer_Quote_Line__c 
                            WHERE inscor__Customer_Quote__c =:quoteId]){
                quoteLineWrappers.add(createQuoteLineWrapper(lineItem, count));
                count++;
            }
            return quoteLineWrappers;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }


    /**
     * @description : method used to create instance of quote History wrapper as per customer quote
     * @createdDate : 12.20.2021
     */
    public static QuotesHistoryWrapper createQuoteHistoryWrapper(inscor__Customer_Quote__c quote) {
        QuotesHistoryWrapper QuotesHistoryWrapperInstance = new QuotesHistoryWrapper();
        QuotesHistoryWrapperInstance.id = quote.Id;
        QuotesHistoryWrapperInstance.quoteType = ''; //customerQuoteLine.inscor__Quote_Type__c;
        QuotesHistoryWrapperInstance.quoteNumber = quote.Name;
        QuotesHistoryWrapperInstance.quoteAmount = quote.inscor__Quote_Total__c == null ? 0 : quote.inscor__Quote_Total__c;
        QuotesHistoryWrapperInstance.quoteDate = quote.inscor__Create_Date__c;
        QuotesHistoryWrapperInstance.status = quote.inscor__Status__c;
        QuotesHistoryWrapperInstance.contactName = quote.inscor__Contact__r.Name == null ? '-' : quote.inscor__Contact__r.Name;
        QuotesHistoryWrapperInstance.isShowLines = false;

        return QuotesHistoryWrapperInstance;
    }

    /**
     * @description : method used to create instance of quote line wrapper as per customer quote line
     * @createdDate : 12.20.2021
     */
    public static QuoteLineWrapper createQuoteLineWrapper(inscor__Customer_Quote_Line__c lineItem, Integer count) {
        QuoteLineWrapper lineWrapper = new QuoteLineWrapper();
        lineWrapper.rowNumber = count;
        lineWrapper.partNumber = lineItem.inscor__Product__r.Name == null ? '-' : lineItem.inscor__Product__r.Name;
        lineWrapper.description = lineItem.inscor__Product__r.inscor__Description__c == null ? '-' : lineItem.inscor__Product__r.inscor__Description__c;
        lineWrapper.conditionCode = lineItem.inscor__Condition_Code__r.Name == null ? '-' : lineItem.inscor__Condition_Code__r.Name;
        lineWrapper.orderQty = lineItem.inscor__Quantity__c == null ? 0 : lineItem.inscor__Quantity__c;
        lineWrapper.shipQty = '';
        lineWrapper.um = lineItem.inscor__Part_Number_UOM__c == null ?  '-' : lineItem.inscor__Part_Number_UOM__c;
        lineWrapper.price = lineItem.inscor__Price__c == null ? 0 : lineItem.inscor__Price__c;
        lineWrapper.total = lineItem.inscor__Line_Total__c;
        return lineWrapper;
    }

    @AuraEnabled(cacheable=true)
    public static List<String> getPickListValueHelper(String objectType, String selectedField){
        List<String> picklistValues = new List<String>();
        Schema.SObjectType sObjectType = Schema.getGlobalDescribe().get(objectType);
        Schema.DescribeSObjectResult sObjectResult = sObjectType.getDescribe();
        Schema.DescribeFieldResult fieldResult = sObjectResult.fields.getMap().get(selectedField).getDescribe();
        List<Schema.PicklistEntry> picklistEntries = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListEntry : picklistEntries){
            picklistValues.add(pickListEntry.getLabel());
        }     
        return picklistValues;
    }

    @AuraEnabled
    public static Picklist getPicklistValueWrapper(){
        try {
            Picklist pickList = new Picklist();
            pickList.quoteTypes = getPickListValueHelper('inscor__Customer_Quote_Line__c', 'inscor__Quote_Type__c');
            pickList.status = getPickListValueHelper('inscor__Customer_Quote__c', 'inscor__Status__c');
            return pickList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    private static User getLoggedInUser() {
        Id userId = UserInfo.getUserId();
        User usr = [SELECT Id, ContactId, Contact.AccountId, Contact.Is_Super_User__c FROM User WHERE Id = :userId];
        return usr;
    }



    public class QuotesHistoryWrapper{
        @AuraEnabled public String id {get; set;}
        @AuraEnabled public String quoteNumber {get; set;}
        @AuraEnabled public Decimal quoteAmount {get; set;}
        @AuraEnabled public DateTime quoteDate {get; set;}
        @AuraEnabled public String quoteType {get; set;}
        @AuraEnabled public String status {get; set;}
        @AuraEnabled public String contactName {get; set;}
        @AuraEnabled public Boolean isShowLines {get; set;}
    }

    public class QuoteLineWrapper{
        @AuraEnabled public Integer rowNumber{get;set;}
        @AuraEnabled public string partNumber{get;set;}
        @AuraEnabled public string description{get;set;}
        @AuraEnabled public string conditionCode{get;set;}
        @AuraEnabled public Decimal orderQty{get;set;}
        @AuraEnabled public string shipQty{get;set;}
        @AuraEnabled public string um{get;set;}
        @AuraEnabled public Decimal price{get;set;}
        @AuraEnabled public Decimal total{get;set;}
    }

    public class Picklist{
        @AuraEnabled public List<String> status{get;set;}
        @AuraEnabled public List<String> quoteTypes{get;set;}
    }

}