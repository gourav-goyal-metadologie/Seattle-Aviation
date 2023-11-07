Public class InvokeSOcreationFlow{
    @invocableMethod(label='SO Creation')
    public static void invokeFlow(List<ID> ids){
        invokeSOFlow(ids[0]);
    }
    
    @future(callout=true)
    public static void invokeSOFlow(Id  orderId){
        String jsonString = '{"OrderId":'+JSON.serialize(orderId)+'}';
    
        HttpResponse res = CustomerQuoteController.getSalesforceAuth();
        System.debug('res.getBody() -> '+res.getBody());
        if(res.getStatusCode()==200){
            Map<String,Object> accessMap = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
            
            HttpRequest req = new HttpRequest();
            req.setEndpoint((String)accessMap.get('instance_url')+'/services/apexrest/CreateSO/');
            req.setHeader('Content-Type','application/json');
            req.setHeader('Authorization', 'Bearer '+(String)accessMap.get('access_token'));
            req.setTimeout(120000);
            req.setBody(jsonString);
            req.setMethod('POST');
            
            Http http = new Http();
            HttpResponse resp = http.send(req);
            System.debug('Response -> '+resp.getBody());
        }
    }
    
    
}