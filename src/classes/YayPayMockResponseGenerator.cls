@isTest
global with sharing class YayPayMockResponseGenerator implements HttpCalloutMock {
    
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/soap+xml');

        if(req.getEndpoint().contains('token')) {
            res.setBody('{ "access_token": "eyJraWg-zg", "expires_in": 3600, "token_type": "Bearer" }');
            res.setStatusCode(200);
        } else {
            res.setBody('OK');
            res.setStatusCode(200);
        } 
        return res;
    }
    
}