global class BatchProcessInvoicePDF implements Database.Batchable<sObject>,Database.AllowsCallouts,Database.Stateful, Schedulable {
	
    Public Set<Id> invoiceIds;
    
    global BatchProcessInvoicePDF(Set<Id> Ids ){
        invoiceIds = Ids; 
    }
    global BatchProcessInvoicePDF( ){
        invoiceIds = new Set<Id>(); 
    }
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'Select Id, Name, Is_PDF_Generated__c FROM inscor__Invoice__c WHERE Id != null';
        if(invoiceIds.size() > 0){
            query += ' AND Id IN: invoiceIds';
        }else{
            query += ' AND Is_PDF_Generated__c = FALSE';
        }
        query += ' ORDER BY LastModifiedDate ASC';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext bc, List<inscor__Invoice__c> invoices){
        List<contentDocumentLink> contentDocumentLinksToInsert = new List<contentDocumentLink>();
        List<inscor__Invoice__c> invoicesToUpdate = new List<inscor__Invoice__c>();
        for( inscor__Invoice__c inv : invoices ){
            string fileName = 'Seattle Aviation Solutions ' +inv.Name+ '.pdf' ;
            PageReference PDf =  Page.InvoicePDFSaveAsFile;
            PDf.getParameters().put('Id',inv.Id);
            PDf.setRedirect(true);
            Blob b ;
            
            if(Test.isRunningTest()) { 
                b = blob.valueOf('Unit.Test');
            }else{
                b = PDf.getContent();
            }
            String contentDocumentId = createContentVersion(fileName, b);
            ContentDocumentLink contentDocLinkObj = createContentDocumentLink(contentDocumentId,inv.Id );
            contentDocumentLinksToInsert.add(contentDocLinkObj);
            
            //Update invoice Flag
            inv.Is_PDF_Generated__c = true;
            invoicesToUpdate.add(inv);
        }
        if( invoicesToUpdate.size()>0 ){
           update invoicesToUpdate; 
        }
        if( contentDocumentLinksToInsert.size() > 0 ){
        	insert contentDocumentLinksToInsert;   
        }
    }
    
    public String createContentVersion(String name, Blob body){
        ContentVersion contentVersion = new ContentVersion();
        contentVersion.ContentLocation = 'S'; // S = Stored in Salesforce
        contentVersion.PathOnClient = name;
        contentVersion.Title = name;
        contentVersion.Origin = 'H';
        contentVersion.VersionData = body;
        insert contentVersion;
        contentVersion cv = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id= :contentVersion.Id limit 1];
        return cv.ContentDocumentId;
    }
    
    public ContentDocumentLink createContentDocumentLink(Id contentDocumentId, Id parentId){
        ContentDocumentLink contentDocumentLink = new ContentDocumentLink();
        contentDocumentLink.ContentDocumentId = contentDocumentId;
        contentDocumentLink.LinkedEntityId = parentId;
        contentDocumentLink.ShareType = 'V'; // Inferred permission
        contentDocumentLink.Visibility = 'InternalUsers';
        return contentDocumentLink;
    }
    
   	global void finish(Database.BatchableContext bc){
    }
    global void execute(SchedulableContext sc) {
        Database.executeBatch(new BatchProcessInvoicePDF(), 10 );
    }
}