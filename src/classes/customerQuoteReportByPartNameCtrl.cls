/**************************************************************************************************
Description: class used to get report for most part number for customer quotes
====================================================================================================
====================================================================================================
Class: customerQuoteReportByPartNameCtrl
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		09/23/2021		  Vinod Kumar Sharma				Initial Creation    
***************************************************************************************************/
public  class customerQuoteReportByPartNameCtrl {

    public static Reports_Configuration__c configurationValues = Reports_Configuration__c.getInstance();
    
    @AuraEnabled(cacheable=true) 
    public static List<ReportWrapper> getQuoteReportResults(){
        List<ReportWrapper> reportWrappers = getQuoteResults();
        return reportWrappers;
    }
    
    @AuraEnabled(cacheable=true) 
    public static List<ReportWrapper> getOrderReportResults(){
        List<ReportWrapper> reportWrappers = getOrderResults();
        return reportWrappers;
    }
    
    public static List<ReportWrapper> getOrderResults(){
        Integer orderSize = 0;
        if(configurationValues.Minimum_No_of_Orders__c != null){
            orderSize = Integer.valueOf(configurationValues.Minimum_No_of_Orders__c);
        }
        
        List<ReportWrapper> reportWrappers = new List<ReportWrapper>();
        for(AggregateResult result : [SELECT COUNT(Id) numberOfOrders, inscor__Product__r.Name partName, inscor__Product__r.inscor__Keyword__c	keyword, 
                                        inscor__Order_Type__c orderType, AVG(inscor__Price__c) averagePrice, 
                                        AVG(inscor__Quantity_Ordered__c) averageQty, MAX(inscor__Quantity_Ordered__c) maxQty
                                        FROM inscor__Sales_Order_Line__c
                                        WHERE CreatedDate = LAST_N_DAYS:365 AND inscor__Product__r.Name != null
                                        GROUP BY inscor__Product__r.Name, inscor__Order_Type__c, inscor__Product__r.inscor__Keyword__c
                                        HAVING count(Id) > :orderSize 
                                      	ORDER BY COUNT(Id) desc limit 500]){
                                
            ReportWrapper reportWrapper = new ReportWrapper();
            reportWrapper.partNumber = (String)result.get('partName');
            reportWrapper.pnKeyword = (String)result.get('keyword');
            reportWrapper.totalQuotes = (Integer)result.get('numberOfOrders');
            reportWrapper.averagePrice =  (Decimal)result.get('averagePrice') != null ? ((Decimal)result.get('averagePrice')).round() : 0 ;
            reportWrapper.purchaseType = (String)result.get('orderType');
            reportWrapper.averageQty = (Decimal)result.get('averageQty') != null ? ((Decimal)result.get('averageQty')).round() : 0 ;
            reportWrapper.maxQty = (Decimal)result.get('maxQty') != null ? ((Decimal)result.get('maxQty')).round() : 0 ;
            reportWrappers.add(reportWrapper);
        }
        return reportWrappers;
        
    }
    
    
    public static List<ReportWrapper> getQuoteResults(){
        Integer quoteSize = 0;
        if(configurationValues.Minimum_No_of_Quotes__c != null){
            quoteSize = Integer.valueOf(configurationValues.Minimum_No_of_Quotes__c);
        }
        
        List<ReportWrapper> reportWrappers = new List<ReportWrapper>();
        for(AggregateResult result : [SELECT COUNT(Id) numberOfQuotes, inscor__Product__r.Name partName, inscor__Product__r.inscor__Keyword__c	keyword, 
                                        inscor__Quote_Type__c quoteType, AVG(inscor__Price__c) averagePrice, 
                                        AVG(inscor__Quantity__c) averageQty, MAX(inscor__Quantity__c) maxQty
                                        FROM inscor__Customer_Quote_Line__c
                                        WHERE CreatedDate = LAST_N_DAYS:365 AND inscor__Product__r.Name != null
                                        GROUP BY inscor__Product__r.Name, inscor__Quote_Type__c, inscor__Product__r.inscor__Keyword__c
                                        HAVING count(Id) > :quoteSize 
                                      	ORDER BY COUNT(Id) desc limit 500]){
                                
            ReportWrapper reportWrapper = new ReportWrapper();
            reportWrapper.partNumber = (String)result.get('partName');
            reportWrapper.pnKeyword = (String)result.get('keyword');
            reportWrapper.totalQuotes = (Integer)result.get('numberOfQuotes');
            reportWrapper.averagePrice =  (Decimal)result.get('averagePrice') != null ? ((Decimal)result.get('averagePrice')).round() : 0 ;
            reportWrapper.purchaseType = (String)result.get('quoteType');
            reportWrapper.averageQty = (Decimal)result.get('averageQty') != null ? ((Decimal)result.get('averageQty')).round() : 0 ;
            reportWrapper.maxQty = (Decimal)result.get('maxQty') != null ? ((Decimal)result.get('maxQty')).round() : 0 ;
            reportWrappers.add(reportWrapper);
        }
        return reportWrappers;
        
    }
    
    public class ReportWrapper{
        @AuraEnabled public String partNumber;
        @AuraEnabled public String pnKeyword;
        @AuraEnabled public Integer totalQuotes;
        @AuraEnabled public Decimal averagePrice;
        @AuraEnabled public String purchaseType;
        @AuraEnabled public Decimal averageQty;
        @AuraEnabled public Decimal maxQty;
    }
}