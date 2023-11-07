public class ComplianceUtility {

    public static Map<Id, inscor__Sales_Order__c> getSalesOrderWithLineItems(Set<Id> salesOrderIds){
        Map<Id, inscor__Sales_Order__c> salesOrderMap = 
            new Map<Id, inscor__Sales_Order__c>([SELECT Id, inscor__Customer_PO_Number__c, createdDate,
                                                 (SELECT Id, inscor__Product__r.Name, inscor__Keyword__c,
                                                  inscor__Quantity_Ordered__c, inscor__Price__c, 
                                                  inscor__Line_Total__c, inscor__Product__r.inscor__HazMat__c,
                                                  inscor__Product__r.inscor__HazMat_Id__c, 
                                                  inscor__Product__r.inscor__Country_of_Origin__c,
                                                  inscor__Product__r.Description,
                                                  inscor__Product__r.IsActive,
                                                  inscor__Product__r.inscor__HTS_Code__c
                                                  FROM inscor__Order_Lines__r)
                                                 FROM inscor__Sales_Order__c
                                                 WHERE Id IN : salesOrderIds]);
        
        return salesOrderMap;
    }
    
    public static Map<Id, Account> getAccountWithContacts(Set<Id> customerIds){
        Map<Id, Account> accountMap = new Map<Id, Account>([SELECT Id, Name, ShippingStreet, ShippingCity,
                                                            ShippingPostalCode, ShippingState, ShippingCountry, 
                                                            Phone, inscor__Active__c,
                                                            (SELECT Id, Title, Name, Phone, Email FROM Contacts)
                                                            FROM Account
                                                            WHERE Id IN : customerIds]);
        
        return accountMap;
    }
    
    //This method will return map of requested accounts.
    //R-Added 02June2021 
    public static Map<Id, Account> getAccounts(Set<Id> customerIds){
        Map<Id, Account> accountMap = new Map<Id, Account>([SELECT Id, Name, ShippingStreet, ShippingCity,
                                                            ShippingPostalCode, ShippingState, ShippingCountry, 
                                                            Phone, inscor__Active__c,
                                                            (SELECT Id, Title, Name, Phone, Email FROM Contacts)
                                                            FROM Account
                                                            WHERE Id IN : customerIds]);
        
        return accountMap;
    }
    
    public static String formatDate(Date d){
        if(d != null){
            return d.year()+'-'+(d.month() < 10 ? '0'+d.month() : ''+d.month())+'-'+(d.day() < 10 ? '0'+d.day() : ''+d.day());
        }
        return '';
    }
    
    public static String formatDate(DateTime d){
        if(d != null){
            return d.year()+'-'+(d.month() < 10 ? '0'+d.month() : ''+d.month())+'-'+(d.day() < 10 ? '0'+d.day() : ''+d.day());
        }
        return '';
    }
    
    public static Decimal getDecimalValue(Decimal d){
        return d != null ? d : 0;
    }
    
    public static String getStringValue(String s){
        return s != null ? s : '';
    }
    public static String removeDotSpecialChar(String s){
        if( s != null && s != '' ){
            s = s.replace('.','');
        }
        return s;
    }
    
    public static String formatSpecialCharXML( String xmlString ){
        xmlString = xmlString.replace('&', '&amp;');
        xmlString = xmlString.replace('\'', '&apos;');
        return xmlString;
    }
    public static String formatAccountContactPhone( String xmlString ){
        
        if( xmlString != null ){
            if( xmlString.contains('+')  ){
                xmlString = xmlString.replace('+', '');
            }
            if( xmlString.contains('011')  ){
                xmlString = xmlString.replace('011', '');
            }
            if( xmlString.contains('-')  ){
                xmlString = xmlString.replace('-', '');
            }
            if( xmlString.contains(' ')  ){
                xmlString = xmlString.replace(' ', '');
            }
            if( xmlString.contains(',')  ){
                xmlString = xmlString.replace(',', '');
            }
            if( xmlString.contains('(')  ){
                xmlString = xmlString.replace('(', '');
            }
            if( xmlString.contains(')')  ){
                xmlString = xmlString.replace(')', '');
            }
            
            if( xmlString.contains('.')  ){
                xmlString = xmlString.replace('.','');
            }
            
            // Use this method always in last.
            xmlString = xmlString.replaceAll('[A-Za-z]', '');            
        }
        return xmlString != null ? xmlString : '';
    }
    public static String removeTrademarkSpecialChar(String s){
        if( s != null && s != '' ){
            s = s.replace('®','');
        }
        return s;
    }
}