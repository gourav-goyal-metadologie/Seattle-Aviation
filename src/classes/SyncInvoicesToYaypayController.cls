public class SyncInvoicesToYaypayController {
    public List<inscor__Invoice__c> invoices{get;private set;}
    public SyncInvoicesToYaypayController(ApexPages.StandardSetController stdSetController){
        // Returns all selected records
        invoices = (List<inscor__Invoice__c>) stdSetController.getSelected();
    }
    
    public PageReference SyncInvoicesToYayPay(){
        // Some fancy stuff here.
        try{
            if(!invoices.isEmpty()){
                Set<Id> validInvoiceIds = new Set<Id>();
                for( inscor__Invoice__c inv: invoices){
                    validInvoiceIds.add(inv.Id);
                }
                Database.executeBatch(new BatchProcessInvoiceToYayPay( validInvoiceIds, true ), 1);
            }
        } catch(Exception e){
            System.debug('Exception: ' + e);
        }
        Schema.DescribeSObjectResult result = inscor__Invoice__c.SObjectType.getDescribe(); 
        PageReference pageRef = new PageReference('/' + result.getKeyPrefix()); 
        pageRef.setRedirect(true); 
        return pageRef; 
    }
}