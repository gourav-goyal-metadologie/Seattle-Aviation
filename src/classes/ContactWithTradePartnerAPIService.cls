public class ContactWithTradePartnerAPIService {

    public static void sendContactToCompliance(List<Contact> contacts){
        Set<Id> customerIds = new Set<Id>();
        for(Contact con : contacts){
            customerIds.add( con.AccountId );
        }
        
        Map<Id, Account> accountMap = ComplianceUtility.getAccounts(customerIds);
       
        Account customer;
        for(Contact con : contacts){
            try{
                customer = accountMap.get( con.AccountId );
                
                String errorString = ComplianceValidation.validateContactRequest(con, customer);
                //System.assert(false, errorString);
                if(String.isBlank(errorString)){
                    String requestXML = ComplianceRequestHelper.createRequestXMLToContactWithAccount(con, customer);
                    //System.assert(false, requestXML);
                    con.Compliance_Request__c = requestXML;
                    //System.assert(false, requestXML);
                    HttpResponse res = ComplianceAPIHelper.sendShipmentDetails(requestXML, con.Name);
                    if(res.getStatusCode() == 200){
                        String responseBody = res.getBody();
                        con.Compliance_Response__c = responseBody;
                        //System.assert(false, responseBody);
                        ComplianceResponseHelper.parseContactWithAccountResponse(responseBody, con);    
                    }else{
                        con.Compliance_Response__c = 'Response :'+res.getStatus()+ '\n Response Code : '+res.getStatusCode()+' \n Response Body: '+res.getBody();
                    }    
                }else{
                    con.Compliance_Response__c = errorString;
                    con.Compliance_Status__c = 'Uploaded Failed';
                }
            }catch(Exception e){
                con.Compliance_Response__c = e.getMessage() + '\n\n\n '+e.getStackTraceString();
                con.Compliance_Status__c = 'Uploaded Failed';
            }
        }
        Database.DMLOptions opt = new Database.DMLOptions();
        opt.allowFieldTruncation = true;
        Database.update(contacts, opt);
    }  
}