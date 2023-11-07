global class BatchProcessReleaseToShipment implements Database.Batchable<sObject>,Database.AllowsCallouts,Database.Stateful, Schedulable {
    
    Public Set<Id> releaseIds;
    global BatchProcessReleaseToShipment(){
        releaseIds = new Set<Id>();
    }
    global BatchProcessReleaseToShipment(Set<Id> Ids){
        releaseIds = Ids;
    }
    
    global void execute(SchedulableContext sc) {
    	Database.executeBatch(new BatchProcessReleaseToShipment(releaseIds), 20);
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id, Name, LastModifiedBy.Name, '+
            'inscor__Account_Terms__c, inscor__Account_Terms__r.Name, inscor__Incoterms__c, '+
            'inscor__Sales_Order__c, inscor__Sales_Order__r.inscor__Customer__c, '+
            'inscor__Ship_To_Address__r.inscor__Country__c,'+
            'inscor__Ship_To_Address__r.inscor__State__c, inscor__Dropship_Site__c,'+
            'inscor__Dropship_to_Account__r.ShippingCountry, inscor__Dropship_to_Account__c,'+
            'inscor__Dropship_Site__r.inscor__Street__c, inscor__Dropship_Site__r.inscor__City__c,'+
            'inscor__Dropship_Site__r.inscor__Postal_Code__c,'+
            'inscor__Dropship_Site__r.inscor__Country__c, inscor__Dropship_Site__r.inscor__State__c,'+
            'inscor__Dropship_to_Account__r.ShippingState, '+
            ' inscor__Ship_Method__r.Name, ' +
                    '( SELECT Id, inscor__Quantity__c, inscor__Line_Value__c,  ' +
					'inscor__Sales_Order_Line__c, inscor__Sales_Order_Line__r.Id, ' +
                    ' inscor__Sales_Order_Line__r.inscor__Product__r.Name, ' +
                    ' inscor__Sales_Order_Line__r.inscor__Keyword__c, ' +
                    ' inscor__Sales_Order_Line__r.inscor__Quantity_Ordered__c, '+
                    ' inscor__Sales_Order_Line__r.inscor__Price__c, '+
                    ' inscor__Sales_Order_Line__r.inscor__Line_Total__c, ' +
                    ' inscor__Sales_Order_Line__r.inscor__Product__r.inscor__HazMat__c, ' +
                    ' inscor__Sales_Order_Line__r.inscor__Product__r.inscor__HazMat_Id__c, ' +
                    ' inscor__Sales_Order_Line__r.inscor__Product__r.inscor__Country_of_Origin__c, ' +
                    ' inscor__Sales_Order_Line__r.inscor__Product__r.Description, ' +
                    ' inscor__Sales_Order_Line__r.inscor__Product__r.IsActive, ' +
                    ' inscor__Sales_Order_Line__r.inscor__Product__r.inscor__HTS_Code__c, ' +
            		' inscor__Sales_Order_Line__r.inscor__Product__r.inscor__Non_Inventory_Item__c, ' +
            		' inscor__Sales_Order_Line__r.inscor__Product__r.inscor__ECCN__r.Name, ' +
                    ' inscor__Sales_Order_Line__r.inscor__Order__r.inscor__Customer_PO_Number__c, ' +
                    ' inscor__Sales_Order_Line__r.inscor__Order__r.Id, ' +
                    ' inscor__Sales_Order_Line__r.inscor__Order__r.createdDate, inscor__Quantity_To_Ship__c '+
                    ' FROM inscor__Release_Lines__r '+
            		' WHERE inscor__Sales_Order_Line__r.inscor__Product__r.inscor__Non_Inventory_Item__c = FALSE )' +
            'FROM  inscor__Release__c '+
            'WHERE inscor__Sales_Order__c != null';
        
        if(releaseIds.size() > 0){
            query += ' AND Id IN: releaseIds';
        }
        //system.assert(false,query);
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<inscor__Release__c> releases){
        ReleaseToShipmentAPIService.sendShipmentToCompliance(releases);
    }
    
    global void finish(Database.BatchableContext bc){
        Integer intervalMinutes = 1;
        DateTime now  = DateTime.now();
        DateTime nextRunTime = now.addMinutes(intervalMinutes);
        String cronString = '' + nextRunTime.second() + ' ' + nextRunTime.minute() + ' ' + 
            nextRunTime.hour() + ' ' + nextRunTime.day() + ' ' + 
            nextRunTime.month() + ' ? ' + nextRunTime.year(); 
        System.schedule('BatchUpdateShipmentStatus -' + now.format('yyyy-MM-dd HH:mm:ss'), cronString, new BatchUpdateShipmentStatus());
        //Database.executeBatch(new BatchUpdateShipmentStatus(releaseIds), 20);
    }
}