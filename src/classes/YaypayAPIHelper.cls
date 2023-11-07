public class YaypayAPIHelper {

    public static HttpResponse sendCustomerDetails(String requestJSON, list<Account> accounts, String token, String trId ){
        
        String accessToken = token;
        YayPay_Configuration__c config = YayPay_Configuration__c.getOrgDefaults();
        String EndpointURL = config.EndPoint__c;
        String transactionId = trId;
        EndpointURL += '/customers?'+'sync_id=1&'+'transaction_id='+transactionId;
        
        HttpRequest req = new HttpRequest();
        
        req.setEndpoint( EndpointURL );
        req.setMethod('POST');
        req.setTimeout(12000);
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('accept', 'application/json');
        req.setHeader('Authorization', 'Bearer '+ accessToken );
       
        req.setBody(requestJSON);
        Http h = new Http();
        HttpResponse res = h.send(req);

        return res;
    }
    
    public static HttpResponse sendContactsDetails(String requestJSON, list<Contact> contacts, String token, String trId ){
        
        String accessToken = token;
        YayPay_Configuration__c config = YayPay_Configuration__c.getOrgDefaults();
        String EndpointURL = config.EndPoint__c;
        String transactionId = trId;
        EndpointURL += '/contacts?'+'sync_id=1&'+'transaction_id='+transactionId;
        
        HttpRequest req = new HttpRequest();
        
        req.setEndpoint( EndpointURL );
        req.setMethod('POST');
        req.setTimeout(12000);
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('accept', 'application/json');
        req.setHeader('Authorization', 'Bearer '+ accessToken );
       
        req.setBody(requestJSON);
        Http h = new Http();
        HttpResponse res = h.send(req);

        return res;
    }
    
    public static HttpResponse sendInvoiceDetails(String requestJSON, inscor__Invoice__c invoice, String token, String trId ){
        
        String accessToken = token;
        YayPay_Configuration__c config = YayPay_Configuration__c.getOrgDefaults();
        String EndpointURL = config.EndPoint__c;
        String transactionId = trId;
        EndpointURL += '/invoices?'+'sync_id=1&'+'transaction_id='+transactionId;
        
        HttpRequest req = new HttpRequest();
        
        req.setEndpoint( EndpointURL );
        req.setMethod('POST');
        req.setTimeout(12000);
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('accept', 'application/json');
        req.setHeader('Authorization', 'Bearer '+ accessToken );
       
        req.setBody(requestJSON);
        Http h = new Http();
        HttpResponse res = h.send(req);

        return res;
    }
    
    
    public static HttpResponse sendPaymentDetails(String requestJSON, list<inscor__Activity__c> payments, String token, String trId ){
        
        String accessToken = token;
        YayPay_Configuration__c config = YayPay_Configuration__c.getOrgDefaults();
        String EndpointURL = config.EndPoint__c;
        String transactionId = trId;
        EndpointURL += '/payments?'+'sync_id=1&'+'transaction_id='+transactionId;
        
        HttpRequest req = new HttpRequest();
        
        req.setEndpoint( EndpointURL );
        req.setMethod('POST');
        req.setTimeout(12000);
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('accept', 'application/json');
        req.setHeader('Authorization', 'Bearer '+ accessToken );
       
        req.setBody(requestJSON);
        Http h = new Http();
        HttpResponse res = h.send(req);

        return res;
    }
    
    public static HttpResponse sendDocuments(String requestJSON, list<ContentDocumentLink> ContentDocLinks, String token, String trId ){
        
        String accessToken = token;
        YayPay_Configuration__c config = YayPay_Configuration__c.getOrgDefaults();
        String EndpointURL = config.EndPoint__c;
        String transactionId = trId;
        EndpointURL += '/contents?'+'sync_id=1&'+'transaction_id='+transactionId;
        
        HttpRequest req = new HttpRequest();
        
        req.setEndpoint( EndpointURL );
        req.setMethod('POST');
        req.setTimeout(12000);
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('accept', 'application/json');
        req.setHeader('Authorization', 'Bearer '+ accessToken );
       
        req.setBody(requestJSON);
        Http h = new Http();
        HttpResponse res = h.send(req);

        return res;
    }
    
    //Billing records to Process.
    public static HttpResponse sendBillings(String requestJSON, list<AcctSeed__Billing__c> BillingList, String token, String trId ){
        
        String accessToken = token;
        YayPay_Configuration__c config = YayPay_Configuration__c.getOrgDefaults();
        String EndpointURL = config.EndPoint__c;
        String transactionId = trId;
        EndpointURL += '/credit-memo?'+'sync_id=1&'+'transaction_id='+transactionId;
        
        HttpRequest req = new HttpRequest();
        
        req.setEndpoint( EndpointURL );
        req.setMethod('POST');
        req.setTimeout(12000);
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('accept', 'application/json');
        req.setHeader('Authorization', 'Bearer '+ accessToken );
       
        System.debug('requestJSON-->' + requestJSON );
        req.setBody(requestJSON);
        Http h = new Http();
        HttpResponse res = h.send(req);

        return res;
    }
    
    
    //Cash Receipt records to Process.
    public static HttpResponse sendReceipts(String requestJSON, list<AcctSeed__Cash_Receipt__c> receiptList, String token, String trId ){
        
        String accessToken = token;
        YayPay_Configuration__c config = YayPay_Configuration__c.getOrgDefaults();
        String EndpointURL = config.EndPoint__c;
        String transactionId = trId;
        EndpointURL += '/payments?'+'sync_id=1&'+'transaction_id='+transactionId;
        
        HttpRequest req = new HttpRequest();
        
        req.setEndpoint( EndpointURL );
        req.setMethod('POST');
        req.setTimeout(12000);
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('accept', 'application/json');
        req.setHeader('Authorization', 'Bearer '+ accessToken );
       
        System.debug('requestJSON-->' + requestJSON );
        req.setBody(requestJSON);
        Http h = new Http();
        HttpResponse res = h.send(req);

        return res;
    }
    
    
    
    //Cash Receipt records to Process.
    public static HttpResponse deleteItems( String requestJSON, String objectName, String token, String trId ){
        
        String accessToken = token;
        YayPay_Configuration__c config = YayPay_Configuration__c.getOrgDefaults();
        String EndpointURL = config.EndPoint__c;
        String transactionId = trId;
        EndpointURL += '/' + objectName  +'/delete?'+'transaction_id='+transactionId;
        
        HttpRequest req = new HttpRequest();
        
        req.setEndpoint( EndpointURL );
        req.setMethod('POST');
        req.setTimeout(12000);
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('accept', 'application/json');
        req.setHeader('Authorization', 'Bearer '+ accessToken );
       
        System.debug('requestJSON-->' + requestJSON );
        System.debug('requestJSON-->' + EndpointURL );
        req.setBody(requestJSON);
        Http h = new Http();
        HttpResponse res = h.send(req);
		
        return res;
    }
}