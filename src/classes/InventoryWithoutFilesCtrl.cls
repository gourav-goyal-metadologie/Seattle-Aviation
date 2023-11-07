/**************************************************************************************************
Description: class used to get report for most part number for customer quotes
====================================================================================================
====================================================================================================
Class: InventoryWithoutFilesCtrl
====================================================================================================
====================================================================================================
History
<Version>       <Date>             <Author Name>                <Brief description of change > 
1.0 -           10/03/2021        Gourav Goyal                      Initial Creation    
***************************************************************************************************/
public class InventoryWithoutFilesCtrl {
    
    //@AuraEnabled(cacheable=true) 
    @AuraEnabled
    public static List<ReportWrapper> getInventoryResults(){
        List<ReportWrapper> reportWrappers = getInventoryResultsHelper();
        return reportWrappers;
    }

    @AuraEnabled
    public static List<ReportWrapper> getInventoryResultsBySearch(String searchKey){
        List<ReportWrapper> reportWrappers = getInventoryResultsHelperBySearchKey(searchKey + '%');
        return reportWrappers;
    }
    
    public static List<ReportWrapper> getInventoryResultsHelper(){
        List<ReportWrapper> reportWrappers = new List<ReportWrapper>();
        for(inscor__Inventory_Line__c result : [SELECT Id, Name, inscor__Condition_Code__r.Name, inscor__Warehouse__r.Name,
                                                inscor__Owner_Code__r.Name, inscor__Serial_Number__c, inscor__Location__r.Name,
                                                inscor__Quantity__c, inscor__Quantity_on_Repair__c, inscor__Quantity_on_Exchange__c,
                                                (SELECT Id from AttachedContentDocuments limit 1) FROM inscor__Inventory_Line__c
                                                WHERE inscor__Quantity__c > 0 AND CreatedDate = LAST_N_DAYS:365 limit 500]){
                                                    if(result.AttachedContentDocuments.size() == 0){
                                                        ReportWrapper reportWrapper = new ReportWrapper();
                                                        reportWrapper.name = String.valueOf(result.name);
                                                        reportWrapper.nameUrl = '/' + result.Id;
                                                        reportWrapper.conditionCode = String.valueOf(result.inscor__Condition_Code__r.Name);
                                                        reportWrapper.warehouse =  String.valueOf(result.inscor__Warehouse__r.Name);
                                                        reportWrapper.ownerCode = String.valueOf(result.inscor__Owner_Code__r.Name);
                                                        reportWrapper.serialNumber = String.valueOf(result.inscor__Serial_Number__c);
                                                        reportWrapper.location = String.valueOf(result.inscor__Location__r.Name);
                                                        reportWrapper.quantity = result.inscor__Quantity__c != null ? Integer.valueOf(result.inscor__Quantity__c) : 0;
                                                        reportWrapper.quantityOnRepair = result.inscor__Quantity_on_Repair__c != null ? Integer.valueOf(result.inscor__Quantity_on_Repair__c) : 0;
                                                        reportWrapper.quantityOnExchange = result.inscor__Quantity_on_Exchange__c != null ? Integer.valueOf(result.inscor__Quantity_on_Exchange__c) : 0;
                                                        reportWrappers.add(reportWrapper);
                                                        
                                                    }                    
                                                    
                                                }
        return reportWrappers;
        
    }

    public static List<ReportWrapper> getInventoryResultsHelperBySearchKey(String searchKey){
        List<ReportWrapper> reportWrappers = new List<ReportWrapper>();
        for(inscor__Inventory_Line__c result : [SELECT Id, Name, inscor__Condition_Code__r.Name, inscor__Warehouse__r.Name,
                                                inscor__Owner_Code__r.Name, inscor__Serial_Number__c, inscor__Location__r.Name,
                                                inscor__Quantity__c, inscor__Quantity_on_Repair__c, inscor__Quantity_on_Exchange__c,
                                                (SELECT Id from AttachedContentDocuments limit 1) FROM inscor__Inventory_Line__c
                                                WHERE inscor__Location__r.Name LIKE :searchKey AND CreatedDate = LAST_N_DAYS:365 limit 200]){
                                                    if(result.AttachedContentDocuments.size() == 0){
                                                        ReportWrapper reportWrapper = new ReportWrapper();
                                                        reportWrapper.name = String.valueOf(result.name);
                                                        reportWrapper.nameUrl = '/' + result.Id;
                                                        reportWrapper.conditionCode = String.valueOf(result.inscor__Condition_Code__r.Name);
                                                        reportWrapper.warehouse =  String.valueOf(result.inscor__Warehouse__r.Name);
                                                        reportWrapper.ownerCode = String.valueOf(result.inscor__Owner_Code__r.Name);
                                                        reportWrapper.serialNumber = String.valueOf(result.inscor__Serial_Number__c);
                                                        reportWrapper.location = String.valueOf(result.inscor__Location__r.Name);
                                                        reportWrapper.quantity = result.inscor__Quantity__c != null ? Integer.valueOf(result.inscor__Quantity__c) : 0;
                                                        reportWrapper.quantityOnRepair = result.inscor__Quantity_on_Repair__c != null ? Integer.valueOf(result.inscor__Quantity_on_Repair__c) : 0;
                                                        reportWrapper.quantityOnExchange = result.inscor__Quantity_on_Exchange__c != null ? Integer.valueOf(result.inscor__Quantity_on_Exchange__c) : 0;
                                                        reportWrappers.add(reportWrapper);
                                                        
                                                    }                    
                                                    
                                                }
        return reportWrappers;
        
    }
    
    public class ReportWrapper{
        @AuraEnabled public String name;
        @AuraEnabled public String nameUrl;
        @AuraEnabled public String conditionCode;
        @AuraEnabled public String warehouse;
        @AuraEnabled public String ownerCode;
        @AuraEnabled public String serialNumber;
        @AuraEnabled public String location;
        @AuraEnabled public Integer quantity;
        @AuraEnabled public Integer quantityOnRepair;
        @AuraEnabled public Integer quantityOnExchange;
    }
}