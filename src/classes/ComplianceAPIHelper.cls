public class ComplianceAPIHelper {

    
    public static HttpResponse checkShipmentStatus(String shipmentNumber){

        Compliance_Configuration__c config = Compliance_Configuration__c.getOrgDefaults();
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(config.EndPoint__c);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/soap+xml');
        req.setHeader('action', config.Shipment_Status_Action__c);
        req.setBody('<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:tem="http://tempuri.org/">'+
                    '<soap:Header/>'+
                    '<soap:Body>'+
                    '<tem:GetShipmentStatus>'+
                    '<tem:User>'+config.Username__c+'</tem:User>'+
                    '<tem:Password>'+config.Password__c+'</tem:Password>'+
                    '<tem:ShipmentReferenceNumber>'+shipmentNumber+'</tem:ShipmentReferenceNumber>'+
                    '<tem:CompanyCode>'+config.Company_Code__c+'</tem:CompanyCode>'+
                    '</tem:GetShipmentStatus>'+
                    '</soap:Body>'+
                    '</soap:Envelope>');
        Http h = new Http();
        HttpResponse res = h.send(req);
        //System.assert(false, res.getBody());
        return res;
    }
    
    
    
    public static HttpResponse sendShipmentDetails(String requestXML, String fileName){
        Compliance_Configuration__c config = Compliance_Configuration__c.getOrgDefaults();
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(config.EndPoint__c);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/soap+xml');
        req.setHeader('action', config.Upload_File_Action__c);
        req.setBody('<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:tem="http://tempuri.org/">'+
                   '<soap:Header/>'+
                   '<soap:Body>'+
                      '<tem:Uploadfile>'+
                         '<tem:User>'+config.Username__c+'</tem:User>'+
                         '<tem:Password>'+config.Password__c+'</tem:Password>'+
                         '<tem:ShipmentXML>'+requestXML+'</tem:ShipmentXML>'+
                         '<tem:CompanyCode>'+config.Company_Code__c+'</tem:CompanyCode>'+
                         '<tem:mode></tem:mode>'+
                         '<tem:fileName>Salesforce Release: '+fileName+'</tem:fileName>'+
                      '</tem:Uploadfile>'+
                   '</soap:Body>'+
                '</soap:Envelope>');
        Http h = new Http();
        HttpResponse res = h.send(req);
        //System.assert(false, res.getBody());
        return res;
    }
}