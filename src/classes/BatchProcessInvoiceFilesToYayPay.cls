global class BatchProcessInvoiceFilesToYayPay implements Database.Batchable<sObject>,Database.AllowsCallouts,Database.Stateful {
    
    Public Set<Id> invoiceIds;
    Public Boolean processInvoiceFiles;
    Public DateTime TokenGenerateTime;
    Public DateTime TokenExpiaryTime;
    Public String accessToken;
    Public Integer tokenGenerateCount =0 ;
    Public String transactionId;
    Public List<inscor__Invoice__c> invoicesToUpdate;
    Public map<String, inscor__Invoice__c> mapInvoiceIdToInvoice;
    Public String LimitRecords;
    Public Integer batchRunInterval;
    global BatchProcessInvoiceFilesToYayPay(){
        invoiceIds = new Set<Id>();
        mapInvoiceIdToInvoice = new map<String, inscor__Invoice__c>();
        invoicesToUpdate = new list<inscor__Invoice__c>();
        processInvoiceFiles = TRUE;
        
        YayPay_Configuration__c config = YayPay_Configuration__c.getOrgDefaults();
        LimitRecords = config.Records_To_Query_Batch__c;
        batchRunInterval = (Integer)config.Batch_Interval_Minutes__c;
        
    }
    global BatchProcessInvoiceFilesToYayPay(Set<Id> Ids, Boolean processFiles ){
        invoiceIds = Ids;
        invoicesToUpdate = new list<inscor__Invoice__c>();
        mapInvoiceIdToInvoice = new map<String, inscor__Invoice__c>();
        processInvoiceFiles = processFiles;
        
        YayPay_Configuration__c config = YayPay_Configuration__c.getOrgDefaults();
        LimitRecords = config.Records_To_Query_Batch__c;
        batchRunInterval = (Integer)config.Batch_Interval_Minutes__c;     
    }
  
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = ' SELECT Id, Name, inscor__Account__c, inscor__Billing_Contact__c, inscor__Customer_PO_Number__c,'+
                  'inscor__Billing_Contact__r.Email, inscor__Account__r.Id, inscor__Invoice_Date__c, '+
                  ' inscor__Billing_Contact__r.Id, inscor__Status__c, inscor__Total_Invoice__c, '+
                  ' inscor__Account__r.inscor__Billing_Contact__r.Email, '+
                  ' inscor__Account_Terms__r.inscor__Number_of_Days__c '+
                  ' FROM  inscor__Invoice__c '+
                  ' WHERE Id != null';
        
        if(invoiceIds.size() > 0){
            query += ' AND Id IN: invoiceIds';
        }else{
            query += ' AND Is_Processed__c = TRUE AND YayPay_Last_Sync_Date__c != null AND Is_File_Processed__c = FALSE ';
        }
        query +=' ORDER BY LastModifiedDate ASC LIMIT ' + LimitRecords ;
       
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<inscor__Invoice__c> invoices){
        
        inscor__Invoice__c invObj = invoices.get(0);
        try{            
            if( TokenExpiaryTime == null || TokenExpiaryTime < System.now() ){
                
                //get Access Token for Request API.
                accessToken = YayPayAuthentication.getAccessToken(); 
                TokenExpiaryTime = System.now().addMinutes(50);
                
                //starting transaction.
                transactionId = YayPayTransactionAPIService.startTransaction( accessToken );
            }
            
            //Process Files.
                if( processInvoiceFiles ){
                    List<ContentDocumentLink> contentDocuLinks = [ SELECT ContentDocumentId, LinkedEntityId 
                                                                  FROM ContentDocumentLink 
                                                                  WHERE LinkedEntity.Type='inscor__Invoice__c' 
                                                                 AND LinkedEntityId =: invObj.Id ];
                    
                    Integer responseCodeFiles;
                    if( contentDocuLinks.size() > 0 ){
                        responseCodeFiles = YayPayAPIService.sendFilesToYayPay( contentDocuLinks, accessToken, transactionId );
                    }
                }
            
            invObj.Is_File_Processed__c = TRUE;
            invoicesToUpdate.add( invObj );
            
        }catch( exception error ){
            invObj.Is_Error__c = TRUE;
            if( !(mapInvoiceIdToInvoice.size() > 0 && mapInvoiceIdToInvoice.containsKey( invObj.Id )) ){
                invoicesToUpdate.add( invObj  );
            }
            LogService.createErrorLog('BatchProcessInvoiceFilesToYayPay.execute', NULL, error, NULL);
        }
        
    }
 
    global void finish(Database.BatchableContext bc){
        try{
            //Finish transaction.
            Integer transactionFinishCode = YayPayTransactionAPIService.finishTransaction( accessToken, transactionId ); 
            update invoicesToUpdate;           
            
        }catch( exception error ){
            LogService.createErrorLog('BatchProcessInvoiceFilesToYayPay.finish', NULL, error, NULL);
        }
    }
}