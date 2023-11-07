public class ProductToItemAPIService {

    
    public static void sendProductsToCompliance(List<Product2> productList){
        for(Product2 product : productList){
            try{
                String requestXML = ComplianceRequestHelper.createRequestXMLToSendItem(product);
                product.Compliance_Request__c = requestXML;
                HttpResponse res = ComplianceAPIHelper.sendShipmentDetails(requestXML, product.Name);
                //System.assert(false, res.getStatusCode());
                if(res.getStatusCode() == 200){
                    String responseBody = res.getBody();
                    product.Compliance_Response__c = responseBody;
                    //System.assert(false, responseBody);
                    ComplianceResponseHelper.parseUploadFileResponse(responseBody, product);    
                }else{
                    product.Compliance_Response__c = 'Response :'+res.getStatus()+ '\n Response Code : '+res.getStatusCode()+' \n Response Body: '+res.getBody();
                }    
            }catch(Exception e){
                product.Compliance_Response__c = e.getMessage() + '\n\n\n '+e.getStackTraceString();
                product.Compliance_Status__c = 'Uploaded Failed';
            }
        }
        Database.DMLOptions opt = new Database.DMLOptions();
        opt.allowFieldTruncation = true;
        Database.update(productList, opt);
    
    }
}