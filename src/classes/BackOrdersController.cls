/**
 * @author - Keykloud
 * @description - Class created for the lwc component name as quoteHistory
 * @TestClass - pending
 * @createdDate - 12/18/2021
 * @lastModifiedDate - 12/23/2021
 * @lastModifiedBy - KeyKloud
 */
public without sharing class BackOrdersController {

    @AuraEnabled(cacheable = true)
    public static List<BackOrderWrapper> getOrders(){
        List<BackOrderWrapper> BackOrderWrapperList = new List<BackOrderWrapper>();
        //User usr = getLoggedInUser();
        // if (usr.Contact.Is_Super_User__c && usr.Contact.AccountId != null) {
        //     List<inscor__Sales_Order__c> orders = [SELECT Id, Name, inscor__Sales_Order_Total_Value__c,
        //                                             inscor__Create_Date__c, inscor__Customer_PO_Number__c,
        //                                             inscor__Contact__c, inscor__Contact__r.Name
        //                                             FROM inscor__Sales_Order__c 
        //                                             WHERE Id IN (SELECT inscor__Order__c 
        //                                                         FROM inscor__Sales_Order_Line__c 
        //                                                         // WHERE inscor__Product__r.inscor__Avg_Lead_Time__c > 30 
        //                                                         WHERE inscor__Order__r.inscor__Customer__c = :usr.Contact.AccountId 
        //                                                         AND ((inscor__Expected_Ship_Date__c != NULL AND inscor__Expected_Ship_Date__c > DAY_ONLY(inscor__Create_Date__c))
        //                                                                 OR (inscor__Expected_Ship_Date__c = NULL AND inscor__Promised_Date__c > inscor__Create_Date__c))
        //                                                         )
        //                                             ORDER BY inscor__Create_Date__c DESC
        //                                             LIMIT 10000];
    
        //     for(inscor__Sales_Order__c order : orders){
        //         BackOrderWrapperList.add(createBackOrderWrapper(order));
        //     }
        // }else if (!usr.Contact.Is_Super_User__c && usr.ContactId != null) {
            System.debug('getBackOrderIds >> '+getBackOrderIds());
        List<inscor__Sales_Order__c> orders = [SELECT Id, Name, inscor__Sales_Order_Total_Value__c,
                                                inscor__Create_Date__c, inscor__Customer_PO_Number__c,
                                                inscor__Contact__c, inscor__Contact__r.Name
                                                FROM inscor__Sales_Order__c 
                                                WHERE Id IN :getBackOrderIds()
                                                ORDER BY inscor__Create_Date__c DESC
                                                LIMIT 10000];

        System.debug('orders >> '+ orders);
        for(inscor__Sales_Order__c order : orders){
            System.debug('inside for loop >>>');
            BackOrderWrapperList.add(createBackOrderWrapper(order));
        }
        //}
        System.debug('BackOrderWrapperList >> '+ BackOrderWrapperList);                                               
        return BackOrderWrapperList;
    }

    @AuraEnabled
    public static List<BackOrderLineWrapper> getOrderLinesById(String orderId){

        try {
            List<BackOrderLineWrapper> BackOrderLineWrappers = new List<BackOrderLineWrapper>();
            Integer count = 1;
            for(inscor__Sales_Order_Line__c lineItem : [SELECT id, inscor__Product__r.Name, inscor__Product__r.inscor__Description__c, inscor__Condition_Code__r.Name, 
                            inscor__Quantity_Ordered__c,inscor__Quantity_Shipped__c, inscor__Product__r.inscor__UOM__c, inscor__Price__c, inscor__Line_Total__c 
                            FROM inscor__Sales_Order_Line__c 
                            WHERE inscor__Order__c =:orderId]){
                BackOrderLineWrappers.add(createBackOrderLineWrapper(lineItem, count));
                count++;
            }
            return BackOrderLineWrappers;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public static Set<Id> getBackOrderIds() {
        Set<Id> backOrderIds = new Set<Id>();
        List<inscor__Sales_Order_Line__c> orderLines = new List<inscor__Sales_Order_Line__c>();
        User usr = getLoggedInUser();
        if (usr.Contact.Is_Super_User__c && usr.Contact.AccountId != null){
            orderLines = [SELECT inscor__Order__c, inscor__Expected_Ship_Date__c, inscor__Promised_Date__c, inscor__Create_Date__c FROM inscor__Sales_Order_Line__c
                            WHERE inscor__Order__r.inscor__Customer__c = :usr.Contact.AccountId AND (inscor__Expected_Ship_Date__c != NULL OR inscor__Promised_Date__c != NULL)
                            LIMIT 10000];
        }else if (!usr.Contact.Is_Super_User__c && usr.ContactId != null) {
            orderLines = [SELECT inscor__Order__c, inscor__Expected_Ship_Date__c, inscor__Promised_Date__c, inscor__Create_Date__c FROM inscor__Sales_Order_Line__c 
                            WHERE inscor__Order__r.inscor__Contact__c = :usr.ContactId AND (inscor__Expected_Ship_Date__c != NULL OR inscor__Promised_Date__c != NULL)
                            LIMIT 10000];
        }

        System.debug('orderLines >> '+ orderLines);
        for (inscor__Sales_Order_Line__c orderLine : orderLines) {
            System.debug('inside for loop >>');
            if (orderLine.inscor__Expected_Ship_Date__c != null && orderLine.inscor__Expected_Ship_Date__c > orderLine.inscor__Create_Date__c) {
                backOrderIds.add(orderLine.inscor__Order__c);
            }else if (orderLine.inscor__Expected_Ship_Date__c == null && orderLine.inscor__Promised_Date__c > orderLine.inscor__Create_Date__c) {
                backOrderIds.add(orderLine.inscor__Order__c);
            }
        }
        System.debug('backOrderIds >>' +backOrderIds);
        return backOrderIds;
    }

    /**
     * @description : method used to create instance of Order History wrapper as per Sales order
     * @createdDate : 12.23.2021
     */
    public static BackOrderWrapper createBackOrderWrapper(inscor__Sales_Order__c order) {

        BackOrderWrapper BackOrderWrapperInstance = new BackOrderWrapper();
        BackOrderWrapperInstance.id = order.Id;
        BackOrderWrapperInstance.orderType = ''; 
        BackOrderWrapperInstance.orderNumber = order.Name;
        BackOrderWrapperInstance.orderAmount = order.inscor__Sales_Order_Total_Value__c == null ? 0 : order.inscor__Sales_Order_Total_Value__c;
        BackOrderWrapperInstance.orderDate = order.inscor__Create_Date__c;
        BackOrderWrapperInstance.customerPO = order.inscor__Customer_PO_Number__c == null ? '-' : order.inscor__Customer_PO_Number__c;
        BackOrderWrapperInstance.contactName = order.inscor__Contact__r.Name == null ? '-' : order.inscor__Contact__r.Name;
        BackOrderWrapperInstance.isShowLines = false;

        return BackOrderWrapperInstance;
    }

    /**
     * @description : method used to create instance of order line wrapper as per sales order line
     * @createdDate : 12.23.2021
     */
    public static BackOrderLineWrapper createBackOrderLineWrapper(inscor__Sales_Order_Line__c lineItem, Integer count) {

        BackOrderLineWrapper lineWrapper = new BackOrderLineWrapper();
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

    @AuraEnabled 
    public static List<BackOrderWrapper> getOrdersBySearch(String custPO, String orderDate){
        try {
            String businessCategory_Surpuls = 'Surplus';
            Date cOrderDate = (orderDate != null && orderDate != '') ? Date.valueOf(orderDate) : null;
            custPo = String.isNotBlank(custPo) ? custPo + '%' : null;
            List<BackOrderWrapper> BackOrderWrapperList = new List<BackOrderWrapper>();
            // User usr = getLoggedInUser();
            // String customerId = usr.Contact.AccountId;
            // String contactId = usr.ContactId;
            Set<Id> backOrderIds = getBackOrderIds();
            String query = 'SELECT id, Name, inscor__Sales_Order_Total_Value__c, inscor__Create_Date__c,inscor__Customer_PO_Number__c, inscor__Contact__c, inscor__Contact__r.Name ';
            query += 'FROM inscor__Sales_Order__c ';
            query += 'WHERE Id IN :backOrderIds AND'; 
            if(cOrderDate != null){
                query = query + ' DAY_ONLY(inscor__Create_Date__c) = :cOrderDate AND';
            }
            if(custPo != null && custPo !=''){
                query = query + ' inscor__Customer_PO_Number__c LIKE :custPo AND';
            }
            query = query.removeEnd('AND');
            query = query + ' ORDER BY inscor__Create_Date__c DESC LIMIT 10000';
            //System.debug(query);
            List<inscor__Sales_Order__c> orders = Database.Query(query);
            for(inscor__Sales_Order__c order : orders){
                BackOrderWrapperList.add(createBackOrderWrapper(order));
            }
                                                                
            return BackOrderWrapperList;
        } catch (Exception e) {

            System.debug(e.getStackTraceString());
            throw new AuraHandledException(e.getMessage());
        }

    }

    private static User getLoggedInUser() {
        Id userId = UserInfo.getUserId();
        User usr = [SELECT Id, ContactId, Contact.AccountId, Contact.Is_Super_User__c FROM User WHERE Id = :userId];
        return usr;
    }

    public class BackOrderWrapper{
        @AuraEnabled public String id {get; set;}
        @AuraEnabled public String orderNumber {get; set;}
        @AuraEnabled public Decimal orderAmount {get; set;}
        @AuraEnabled public DateTime orderDate {get; set;}
        @AuraEnabled public String orderType {get; set;}
        @AuraEnabled public String customerPO {get; set;}
        @AuraEnabled public String contactName {get; set;}
        @AuraEnabled public Boolean isShowLines {get; set;}
    }

    public class BackOrderLineWrapper{
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
}