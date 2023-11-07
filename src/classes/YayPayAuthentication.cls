public class YayPayAuthentication {
    
    public static String getAccessToken(){
        
        YayPay_Configuration__c config = YayPay_Configuration__c.getOrgDefaults();
        String client_Key = config.Client_Key__c;
        String client_Secret = config.Client_Secret__c;
        
        String Endpoint = config.EndPoint__c;
        Blob headerValue = Blob.valueOf(client_Key + ':' + client_Secret);
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint( Endpoint +'/token?scope=invoice.api.write');
        req.setMethod('POST');
        req.setTimeout(12000);
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setHeader('Authorization', 'Basic '+EncodingUtil.base64Encode(headerValue));
        
        Http h = new Http();
        HttpResponse res = h.send(req);
        String responseString = res.getBody();
        ResponseWrapper rw = (ResponseWrapper)System.JSON.deserialize(responseString, ResponseWrapper.class);
        
        return rw.access_token;
    }
    
    
    public class ResponseWrapper{
        public String access_token;
        public String token_type;
    }
}