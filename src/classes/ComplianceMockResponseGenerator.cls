@isTest
global with sharing class ComplianceMockResponseGenerator implements HttpCalloutMock {
    
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/soap+xml');

        if(req.getBody().contains('GetShipmentStatus')) {
            res.setBody('<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><GetShipmentStatusResponse xmlns="http://tempuri.org/"><GetShipmentStatusResult>&lt;Status&gt;No ShipmentFound&lt;/Status&gt;<ITNNumber>Test</ITNNumber></GetShipmentStatusResult></GetShipmentStatusResponse></soap:Body></soap:Envelope>');
        	res.setStatusCode(200);
        } else if(req.getBody().contains('Uploadfile')) {
            res.setBody('<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><UploadfileResponse xmlns="http://tempuri.org/"><UploadfileResult>&lt;Messages&gt;&lt;Validationmessages&gt;&lt;Message&gt;&lt;Information&gt;Successful uploaded File&lt;/Information&gt;&lt;EIMReference&gt;aabe12c8-4&lt;/EIMReference&gt;&lt;/Message&gt;&lt;/Validationmessages&gt;&lt;/Messages&gt;</UploadfileResult></UploadfileResponse></soap:Body></soap:Envelope>');
            res.setStatusCode(200);
        	
        } else if(req.getBody().contains('failed scenerio')) {
            res.setBody('<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><UploadfileResponse xmlns="http://tempuri.org/"><UploadfileResult>&lt;Messages&gt;&lt;Validationmessages&gt;&lt;Message&gt;&lt;Information&gt;Successful uploaded File&lt;/Information&gt;&lt;EIMReference&gt;aabe12c8-4&lt;/EIMReference&gt;&lt;/Message&gt;&lt;/Validationmessages&gt;&lt;/Messages&gt;</UploadfileResult></UploadfileResponse></soap:Body></soap:Envelope>');
            res.setStatusCode(200);
        	
        } 
        return res;
    }
    
}