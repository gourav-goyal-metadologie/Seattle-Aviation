/**
 * @author - Keykloud
 * @description - Class created for the lwc component name as orderHistory
 * @TestClass - pending
 * @createdDate - 12/20/2021
 * @lastModifiedDate - 12/27/2021
 * @lastModifiedBy - KeyKloud
 */
public without sharing class OrderHistoryController {

    
    @AuraEnabled(cacheable=true)
    public static List<OrderHistoryWrapper> getCustomerOrder(){

        List<OrderHistoryWrapper> OrderHistoryWrapperList = new List<OrderHistoryWrapper>();
        List<inscor__Sales_Order__c> orders = new List<inscor__Sales_Order__c>();
        User usr = getLoggedInUser();
        if (usr.Contact.Is_Super_User__c && usr.Contact.AccountId != null) {
            orders = [SELECT Id, Name, inscor__Sales_Order_Total_Value__c,
                        inscor__Create_Date__c, inscor__Customer_PO_Number__c,
                        inscor__Contact__c, inscor__Contact__r.Name
                        FROM inscor__Sales_Order__c 
                        WHERE inscor__Customer__c = :usr.Contact.AccountId
                        LIMIT 10000];
        }else if(!usr.Contact.Is_Super_User__c && usr.ContactId != null) {
            orders = [SELECT Id, Name, inscor__Sales_Order_Total_Value__c,
                        inscor__Create_Date__c, inscor__Customer_PO_Number__c,
                        inscor__Contact__c, inscor__Contact__r.Name
                        FROM inscor__Sales_Order__c
                        WHERE inscor__Contact__c = :usr.ContactId
                        LIMIT 10000];
        }


        for(inscor__Sales_Order__c order : orders){
            OrderHistoryWrapperList.add(createOrderHistoryWrapper(order));
        }
                                                        
        return OrderHistoryWrapperList;
    }

    @AuraEnabled
    public static List<OrderHistoryWrapper> getOrderBySearch(string orderName, string orderAmount, string orderDate, string orderType, string customerPO, string partNumber){
        try {
            Decimal orderAmountDecimal = (orderAmount != null && orderAmount != '') ? decimal.valueOf(orderAmount) : null;
            Date cDate = (orderDate != null && orderDate != '') ? Date.valueOf(orderDate) : null;
            orderName = (orderName != null && orderName != '') ? orderName + '%' : null;
            customerPO = (customerPO != null && customerPO != '') ? customerPO + '%' : null;
            List<OrderHistoryWrapper> OrderHistoryWrapperList = new List<OrderHistoryWrapper>();
            String query = 'SELECT id, Name, inscor__Sales_Order_Total_Value__c, inscor__Create_Date__c,inscor__Customer_PO_Number__c, inscor__Contact__c, inscor__Contact__r.Name ';
            query += 'FROM inscor__Sales_Order__c '; 
            User usr = getLoggedInUser();
            String customerId = usr.Contact.AccountId;
            String contactId = usr.ContactId;
            //Boolean isConditionAdded = false;
            if (contactId != null) {
                query += 'WHERE';
                if (usr.Contact.Is_Super_User__c) {
                    query = query + ' inscor__Customer__c = :customerId AND';
                }else {     
                    query = query + ' inscor__Contact__c = :contactId AND';
                }
                if (orderName != null &&  orderName != '') {
                    query += ' Name LIKE :orderName AND';
                    //isConditionAdded = true;
                }
                if (orderAmountDecimal != null) {
                    query += ' inscor__Sales_Order_Total_Value__c =:orderAmountDecimal AND';
                    //isConditionAdded = true;
                }
                if (customerPO != null) {
                    query += ' inscor__Customer_PO_Number__c LIKE :customerPO AND';
                    //isConditionAdded = true;
                }
                if (cDate != null) {
                    query += ' DAY_ONLY(inscor__Create_Date__c) =: cDate AND';
                    //isConditionAdded = true;
                }
                if (partNumber != null &&  partNumber != '') {
                    query += ' Id IN (SELECT inscor__Order__c FROM inscor__Sales_Order_Line__c WHERE inscor__Product__r.Name =:partNumber ';
                    if (orderType != null) {
                        query += 'AND inscor__Order_Type__c =: orderType';
                    }
                    query +=') ';
                    //isConditionAdded = true;
                }else if (orderType != null) {
                    query += ' Id IN (SELECT inscor__Order__c FROM inscor__Sales_Order_Line__c WHERE inscor__Order_Type__c =: orderType) ';
                    //isConditionAdded = true;
                }
    
                query = query.removeEnd('AND');
                query+= ' LIMIT 10000';
            }else {
                query+= ' LIMIT 0';
            }
            System.debug(query);
            List<inscor__Sales_Order__c> orders = Database.Query(query);
            for(inscor__Sales_Order__c order : orders){
                OrderHistoryWrapperList.add(createOrderHistoryWrapper(order));
            }
                                                            
            return OrderHistoryWrapperList;
        } catch (Exception e) {
            System.debug(e.getStackTraceString());
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<orderLineWrapper> getOrderLinesById(String orderId){

        try {
            List<orderLineWrapper> orderLineWrappers = new List<orderLineWrapper>();
            Integer count = 1;
            for(inscor__Sales_Order_Line__c lineItem : [SELECT id, inscor__Product__r.Name, inscor__Product__r.inscor__Description__c, inscor__Condition_Code__r.Name, 
                            inscor__Quantity_Ordered__c,inscor__Quantity_Shipped__c, inscor__Product__r.inscor__UOM__c, inscor__Price__c, inscor__Line_Total__c 
                            FROM inscor__Sales_Order_Line__c 
                            WHERE inscor__Order__c =:orderId]){
                orderLineWrappers.add(createOrderLineWrapper(lineItem, count));
                count++;
            }
            return orderLineWrappers;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }


    /**
     * @description : method used to create instance of Order History wrapper as per Sales order
     * @createdDate : 12.23.2021
     */
    public static OrderHistoryWrapper createOrderHistoryWrapper(inscor__Sales_Order__c order) {

        OrderHistoryWrapper OrderHistoryWrapperInstance = new OrderHistoryWrapper();
        OrderHistoryWrapperInstance.id = order.Id;
        OrderHistoryWrapperInstance.orderType = ''; 
        OrderHistoryWrapperInstance.orderNumber = order.Name;
        OrderHistoryWrapperInstance.orderAmount = order.inscor__Sales_Order_Total_Value__c == null ? 0 : order.inscor__Sales_Order_Total_Value__c;
        OrderHistoryWrapperInstance.orderDate = order.inscor__Create_Date__c;
        OrderHistoryWrapperInstance.customerPO = order.inscor__Customer_PO_Number__c == null ? '-' : order.inscor__Customer_PO_Number__c;
        OrderHistoryWrapperInstance.contactName = order.inscor__Contact__r.Name == null ? '-' : order.inscor__Contact__r.Name;
        OrderHistoryWrapperInstance.isShowLines = false;

        return OrderHistoryWrapperInstance;
    }

    /**
     * @description : method used to create instance of order line wrapper as per sales order line
     * @createdDate : 12.23.2021
     */
    public static orderLineWrapper createOrderLineWrapper(inscor__Sales_Order_Line__c lineItem, Integer count) {

        orderLineWrapper lineWrapper = new orderLineWrapper();
        lineWrapper.rowNumber = count;
        lineWrapper.partNumber = lineItem.inscor__Product__r.Name == null ? '-' : lineItem.inscor__Product__r.Name;
        lineWrapper.description = lineItem.inscor__Product__r.inscor__Description__c == null ? '-' : lineItem.inscor__Product__r.inscor__Description__c;
        lineWrapper.conditionCode = lineItem.inscor__Condition_Code__r.Name == null ? '-' : lineItem.inscor__Condition_Code__r.Name;
        lineWrapper.orderQty = lineItem.inscor__Quantity_Ordered__c == null ? 0 : lineItem.inscor__Quantity_Ordered__c;
        lineWrapper.shipQty = lineItem.inscor__Quantity_Shipped__c == null ? 0 : lineItem.inscor__Quantity_Shipped__c;  
        lineWrapper.um = lineItem.inscor__Product__r.inscor__UOM__c == null ?  '-' : lineItem.inscor__Product__r.inscor__UOM__c;
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
            pickList.orderTypes = getPickListValueHelper('inscor__Sales_Order_Line__c', 'inscor__Order_Type__c');
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



    public class OrderHistoryWrapper{
        @AuraEnabled public String id {get; set;}
        @AuraEnabled public String orderNumber {get; set;}
        @AuraEnabled public Decimal orderAmount {get; set;}
        @AuraEnabled public DateTime orderDate {get; set;}
        @AuraEnabled public String orderType {get; set;}
        @AuraEnabled public String customerPO {get; set;}
        @AuraEnabled public String contactName {get; set;}
        @AuraEnabled public Boolean isShowLines {get; set;}
    }

    public class orderLineWrapper{
        @AuraEnabled public Integer rowNumber{get;set;}
        @AuraEnabled public string partNumber{get;set;}
        @AuraEnabled public string description{get;set;}
        @AuraEnabled public string conditionCode{get;set;}
        @AuraEnabled public Decimal orderQty{get;set;}
        @AuraEnabled public Decimal shipQty{get;set;}
        @AuraEnabled public string um{get;set;}
        @AuraEnabled public Decimal price{get;set;}
        @AuraEnabled public Decimal total{get;set;}
    }

    public class Picklist{
       // @AuraEnabled public List<String> customerPO{get;set;}
        @AuraEnabled public List<String> orderTypes{get;set;}
    }

}