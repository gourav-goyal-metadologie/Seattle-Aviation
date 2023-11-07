public class YayPayAPIService {
    
    public static Integer sendInvoiceToYayPay(inscor__Invoice__c inv, String accessToken, String transactionId){

        String requestJSON = YayPayRequestHelper.createRequestJSONToInvoice(inv);
        String trId = transactionId ;
        HttpResponse res = YaypayAPIHelper.sendInvoiceDetails(requestJSON, inv, accessToken, trId );
        
        if(res.getStatusCode() == 200){
            String responseBody = res.getBody();
        }else{
            throw new CustomAPIException( res.getBody() );
        } 
        return null;
    }  
    
    public static Integer sendCustomerToYayPay(List<Account> accounts, String accessToken, String transactionId){
        
        String requestJSON = YayPayRequestHelper.createRequestJSONToCustomer(accounts);
        String trId = transactionId;
        HttpResponse res = YaypayAPIHelper.sendCustomerDetails(requestJSON, accounts, accessToken, transactionId );
        
        if(res.getStatusCode() == 200){
            String responseBody = res.getBody();
        }else{
            throw new CustomAPIException( res.getBody() );
        }                
        return null;
    }  
    
    
    public static Integer sendContactToYayPay(List<Contact> contacts, String accessToken, String transactionId){
      
        if( contacts.size() > 0 ){
            String requestJSON = YayPayRequestHelper.createRequestJSONToContacts(contacts);
            String trId = transactionId;
            
            HttpResponse res = YaypayAPIHelper.sendContactsDetails(requestJSON, contacts, accessToken, transactionId );
            
            if(res.getStatusCode() == 200){
                String responseBody = res.getBody();
                return res.getStatusCode();   
            }else{
                throw new CustomAPIException( res.getBody() );
            }      
        }
        return null;
    }  
    
    public static Integer sendPaymentToYayPay(List<inscor__Activity__c> payments, String accessToken, String transactionId){
      
        if( payments.size() > 0 ){
            String requestJSON = YayPayRequestHelper.createRequestJSONToPayments(payments);
            HttpResponse res = YaypayAPIHelper.sendPaymentDetails(requestJSON, payments, accessToken, transactionId );
            
            if(res.getStatusCode() == 200){
                String responseBody = res.getBody();
                return res.getStatusCode();     
            }else{
                throw new CustomAPIException( res.getBody() );
            }    
        }
        return null;
    }
    
    public static Integer sendFilesToYayPay(List<ContentDocumentLink> ContentDocLinks, String accessToken, String transactionId){
      
        if( ContentDocLinks.size() > 0 ){
            String requestJSON = YayPayRequestHelper.createRequestJSONToDocuments(ContentDocLinks);
            HttpResponse res = YaypayAPIHelper.sendDocuments(requestJSON, ContentDocLinks, accessToken, transactionId );
            if(res.getStatusCode() == 200){
                String responseBody = res.getBody();
                
                return res.getStatusCode();     
            }else{
                throw new CustomAPIException( res.getBody() );
            }    
        }
        return null;
    }
    
    
    //Credit Memo Process.
    public static Integer sendBillingToYayPay(List<AcctSeed__Billing__c> customerBilling, String accessToken, String transactionId){
      
        if( customerBilling.size() > 0 ){
            String requestJSON = YayPayRequestHelper.createRequestJSONToBilling(customerBilling);
            HttpResponse res = YaypayAPIHelper.sendBillings(requestJSON, customerBilling, accessToken, transactionId );
            
            if(res.getStatusCode() == 200){
                String responseBody = res.getBody();
                return res.getStatusCode();     
            }else{
                throw new CustomAPIException( res.getBody() );
            }    
        }
        return null;
    }
    
    //Cash Receipt Process.
    public static Integer sendReceiptToYayPay(List<AcctSeed__Cash_Receipt__c> cashReceipts,
                                              String accessToken, String transactionId){
      
        if( cashReceipts.size() > 0 ){
            String requestJSON = YayPayRequestHelper.createRequestJSONToReceipt(cashReceipts);
            HttpResponse res = YaypayAPIHelper.sendReceipts(requestJSON, cashReceipts, accessToken, transactionId );
            
            if(res.getStatusCode() == 200){
                String responseBody = res.getBody();
                return res.getStatusCode();     
            }else{
                throw new CustomAPIException( res.getBody() );
            }    
        }
        return null;
    }
    
    //Cash Receipt Process.
    public static Integer deleteRecordsFromYayPay( List<String> recordIdsToDelete, String objectName,
                                              String accessToken, String transactionId){
      
        if( recordIdsToDelete.size() > 0 ){
            String requestJSON = YayPayRequestHelper.deleteItemRequestJSON( recordIdsToDelete, objectName );
            HttpResponse res = YaypayAPIHelper.deleteItems( requestJSON, objectName, accessToken, transactionId );
            
            if(res.getStatusCode() == 200){
                String responseBody = res.getBody();
                return res.getStatusCode();     
            }else{
                throw new CustomAPIException( res.getBody() );
            }    
        }
        return null;
    }
    public class CustomAPIException extends Exception{
        
    }
}