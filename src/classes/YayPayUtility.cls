public class YayPayUtility {

    Public Static String nullStringRemoval( String str ){
        return str != null ? str : '';
    }
    
    Public Static Boolean sendYayPayCallout(){
        YayPay_Configuration__c config = YayPay_Configuration__c.getOrgDefaults();
        return config.Is_Integration_Enable__c;
    }
}