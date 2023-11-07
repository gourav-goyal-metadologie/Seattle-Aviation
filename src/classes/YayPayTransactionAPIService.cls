public class YayPayTransactionAPIService {
    
    public static String transactionId;
     public static String startTransaction( String token ){
         
         String accessToken = token;
         HttpRequest req = new HttpRequest();
         String startPeriod = system.now().formatGMT('yyyy-MM-dd\'T\'HH:mm:ss');
         String endPeriod = (system.now().addMinutes(10)).formatGMT('yyyy-MM-dd\'T\'HH:mm:ss');
         
         YayPay_Configuration__c config = YayPay_Configuration__c.getOrgDefaults();
         String EndpointURL = config.EndPoint__c;
         EndpointURL += '/batch/start?'+
             			'end_period='+endPeriod+'&source_system=OTHER&start_period='+startPeriod+'&sync_id=1';
         req.setEndpoint( EndpointURL );
         req.setMethod('POST');
         req.setTimeout(12000);
         req.setHeader('accept', 'application/json');
         req.setHeader('Authorization', 'Bearer '+ accessToken);
         
         Http h = new Http();
         HttpResponse res = h.send(req);
         
         //System.assert(false, res.getBody() );
         String responseString = res.getBody();
         
         ResponseWrapper rw = (ResponseWrapper)System.JSON.deserialize(responseString, ResponseWrapper.class);
         transactionId = rw.Id;
        return rw.id;
    }
    
    public static Integer finishTransaction(  String token, String trId ){
         
         String accessToken = token; 
         HttpRequest req = new HttpRequest();
         String transactionId = trId;
        
        YayPay_Configuration__c config = YayPay_Configuration__c.getOrgDefaults();
        String EndpointURL = config.EndPoint__c;
        EndpointURL += '/batch/finish?sync_id=1&transaction_id='+transactionId;
        req.setEndpoint( EndpointURL );
        req.setMethod('POST');
        req.setHeader('accept', 'application/json');
        req.setHeader('Authorization', 'Bearer '+ accessToken);
        req.setTimeout(12000);
        Http h = new Http();
        HttpResponse res = h.send(req);
        
        return res.getStatusCode();
    }
    
    
    public class ResponseWrapper{
        public String id;
    }
}