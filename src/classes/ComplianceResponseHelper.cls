public class ComplianceResponseHelper {

    
    public static void parseUploadFileResponse(String responseXML, inscor__Release__c release){
        responseXML = responseXML.substringAfter('<UploadfileResult>');
        responseXML = responseXML.substringBefore('</UploadfileResult>');
        if(responseXML.contains('Successful uploaded File')){
            release.Compliance_Status__c = 'Upload Successful';
        }else{
            release.Compliance_Status__c = 'Upload Failed';
            release.inscor__Export_Status__c = 'On Hold';
        }
    }
    
    
    public static void parseShipmentResponse(String responseXML, inscor__Release__c release){
        responseXML = responseXML.replaceAll('&gt;', '>');
        responseXML = responseXML.replaceAll('&lt;', '<');
        
        String shipmentStatusXML = responseXML.substringAfter('<ShipmentStatus>');
        shipmentStatusXML = shipmentStatusXML.substringBefore('</ShipmentStatus>');
        
        String itinXML = responseXML.substringAfter('<ITNNumber>');
        itinXML = itinXML.substringBefore('</ITNNumber>');
        
        if(String.isNotBlank(itinXML)){
            if( itinXML.isNumeric() ){
                release.International_Transaction_Number__c	= itinXML;
            }else{
                if( itinXML.startsWith('AES ') ){
                    release.Remarks__c	= itinXML.substringAfter('AES ');
                }else{
                    release.Remarks__c	= itinXML;
                }
            }
        	
            release.inscor__Export_Status__c = 'Approved';
        }else if(String.isNotBlank(shipmentStatusXML) && shipmentStatusXML.containsIgnoreCase('On Hold')){
            release.inscor__Export_Status__c = 'On Hold';
        }
    }
    
    
    public static void parseUploadFileResponse(String responseXML, Product2 product){
        responseXML = responseXML.substringAfter('<UploadfileResult>');
        responseXML = responseXML.substringBefore('</UploadfileResult>');
        if(responseXML.contains('Successful uploaded File')){
            product.Compliance_Status__c = 'Upload Successful';
        }else{
            product.Compliance_Status__c = 'Upload Failed';
        }
    }
    
    //This method will return XML String for Contact.
    //Added 02June2021 
    public static void parseContactWithAccountResponse(String responseXML, Contact con){
        responseXML = responseXML.substringAfter('<UploadfileResult>');
        responseXML = responseXML.substringBefore('</UploadfileResult>');
        if(responseXML.contains('Successful uploaded File')){
            con.Compliance_Status__c = 'Upload Successful';
        }else{
            con.Compliance_Status__c = 'Upload Failed';
        }
    }
}