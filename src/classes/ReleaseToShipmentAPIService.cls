public class ReleaseToShipmentAPIService {

    public static void sendShipmentToCompliance(List<inscor__Release__c> releases){
        Set<Id> salesOrderIds = new Set<Id>();
        Set<Id> customerIds = new Set<Id>();
        for(inscor__Release__c release : releases){
            salesOrderIds.add(release.inscor__Sales_Order__c);
            if(release.inscor__Ship_To_Address__c != null){
                customerIds.add(release.inscor__Sales_Order__r.inscor__Customer__c);
            }else if(release.inscor__Dropship_Site__c != null){
                customerIds.add(release.inscor__Dropship_to_Account__c);
            }
        }
        
        Map<Id, inscor__Sales_Order__c> salesOrderMap = ComplianceUtility.getSalesOrderWithLineItems(salesOrderIds);
        Map<Id, Account> accountMap = ComplianceUtility.getAccountWithContacts(customerIds);
        //System.assert( false, releaseLineIds );
        inscor__Sales_Order__c salesOrder;
        Account customer;
        for(inscor__Release__c release : releases){
            try{
                salesOrder = salesOrderMap.get(release.inscor__Sales_Order__c);
                //releaseLine = salesOrderMap.get(release.inscor__Sales_Order__c);
                
                if(release.inscor__Ship_To_Address__c != null){
                customer = accountMap.get(release.inscor__Sales_Order__r.inscor__Customer__c);
                }else if(release.inscor__Dropship_Site__c != null){
                    customer = accountMap.get(release.inscor__Dropship_to_Account__c);
                }
                
                String errorString = ComplianceValidation.validateUploadFileRequest(release, salesOrder, customer);
                //System.assert(false, errorString);
                if(String.isBlank(errorString)){
                    String requestXMLWIthSpecialChar = ComplianceRequestHelper.createRequestXMLToSendShipment(release, salesOrder, customer);
                    String requestXML = ComplianceUtility.formatSpecialCharXML( requestXMLWIthSpecialChar );
                    //System.assert(false, requestXML);
                    release.Compliance_Request__c = requestXML;
                    HttpResponse res = ComplianceAPIHelper.sendShipmentDetails(requestXML, release.Name);
                    if(res.getStatusCode() == 200){
                        String responseBody = res.getBody();
                        release.Compliance_Response__c = responseBody;
                        //System.assert(false, responseBody);
                        ComplianceResponseHelper.parseUploadFileResponse(responseBody, release);    
                    }else{
                        release.Compliance_Response__c = 'Response :'+res.getStatus()+ '\n Response Code : '+res.getStatusCode()+' \n Response Body: '+res.getBody();
                    }    
                }else{
                    release.Compliance_Response__c = errorString;
                    release.Compliance_Status__c = 'Uploaded Failed';
                    release.inscor__Export_Status__c = 'On Hold';
                }
            }catch(Exception e){
                release.Compliance_Response__c = e.getMessage() + '\n\n\n '+e.getStackTraceString();
                release.Compliance_Status__c = 'Uploaded Failed';
                release.inscor__Export_Status__c = 'On Hold';
            }
        }
        Database.DMLOptions opt = new Database.DMLOptions();
        opt.allowFieldTruncation = true;
        Database.update(releases, opt);
    }
    
    
    
    public static void checkShipmentStatus(List<inscor__Release__c> releases){
        for(inscor__Release__c release : releases){
            try{                
                HttpResponse res = ComplianceAPIHelper.checkShipmentStatus(release.Name);
                if(res.getStatusCode() == 200){
                    String responseBody = res.getBody();
                    release.Shipment_Response__c = responseBody;
                    //System.assert(false, responseBody);
                    ComplianceResponseHelper.parseShipmentResponse(responseBody, release);    
                }else{
                    release.Shipment_Response__c = 'Response :'+res.getStatus()+ '\n Response Code : '+res.getStatusCode()+' \n Response Body: '+res.getBody();
                }    
                
            }catch(Exception e){
                release.Shipment_Response__c = e.getMessage() + '\n\n\n '+e.getStackTraceString();
            }
        }
        Database.DMLOptions opt = new Database.DMLOptions();
        opt.allowFieldTruncation = true;
        Database.update(releases, opt);
    }
}