public class AmountSettlementAuthorizeDotNet {
    public static List<String> mystring = new List<String>();
    public static List<String> paymentAuthorizationRefNumber = new List<String>();
    public static List<String> orderPaymentSummaryList = new List<String>();
    public static List<String> orderSummaryList = new List<String>();
    public static List<String> orderList = new List<String>();
    public static void getUnsettledTransactions(){
        String recordLimit = '1000';
        HttpRequest req = new HttpRequest();
        //req.setEndpoint('https://apitest.authorize.net/xml/v1/request.api');
        req.setEndpoint('callout:Authorize_net_Payment_Gateway_sandbox/xml/v1/request.api');
        req.setMethod('GET');
        req.setBody(batchRequestBody());
        setAuthorizationHeaders(req);
        Http binding = new Http();
        try{
            HttpResponse res = new HttpResponse();
            if(!Test.isRunningTest()){
            	res = binding.send(req);
            }else{
                res.setStatusCode(200);
                String jsonBody='{"batchList":[{"batchId":"10198080","settlementTimeUTC":"2014-10-24T18:48:19Z","settlementTimeUTCSpecified":true,"settlementTimeLocal":"2014-10-24T16:18:19","settlementTimeLocalSpecified":true,"settlementState":"settledSuccessfully","paymentMethod":"eCheck"},{"batchId":"10198081","settlementTimeUTC":"2014-10-24T18:48:55Z","settlementTimeUTCSpecified":true,"settlementTimeLocal":"2014-10-24T16:18:55","settlementTimeLocalSpecified":true,"settlementState":"settledSuccessfully","paymentMethod":"eCheck"},{"batchId":"10198082","settlementTimeUTC":"2014-10-24T18:49:37Z","settlementTimeUTCSpecified":true,"settlementTimeLocal":"2014-10-24T16:19:37","settlementTimeLocalSpecified":true,"settlementState":"settledSuccessfully","paymentMethod":"eCheck"}],"messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}';
                res.setBody(jsonBody);
            }
            if(res.getStatusCode() == 200){
                String strJSON = res.getBody();
                System.debug('strJSON -> '+strJSON);
                jsonBatchList obj = (jsonBatchList)System.JSON.deserialize(strJSON,jsonBatchList.class);
                List<jsonBatchList.BatchList> objBatchList = new List<jsonBatchList.BatchList>();
                objBatchList = obj.batchList;
                system.debug('objBatchList: '+objBatchList);
                //List<String> batchIds = new List<String>();
                //List<PaymentAuthorization> paymentAuthorizationObj = new List<PaymentAuthorization>();
                
                //List<String> transactionIds = new List<String>();
                
                for(Integer i = 0; i < objBatchList.size(); i++){
                    Integer offsetLevel = 1;
                    if(objBatchList[i].settlementState == 'settledSuccessfully'){
                        String currentBatchId = objBatchList[i].batchId;
                        //system.debug('currentBatchId: '+currentBatchId);
                        //List<String> currentIds = new List<String>();
                        getBatchDetails(currentBatchId,recordLimit,offsetLevel);
                        //transactionIds.add(getBatchDetails(currentBatchId));
                    }
                }
                system.debug('final Ids: '+mystring);
                //updateSalesOrders();
                updatePaymentAuthorizationRecords();
                //return req;
            }
        }catch(System.CalloutException e){
            system.debug('Callout Error: '+e);
        }
    }
    
    private static void setAuthorizationHeaders(HttpRequest req){
        req.setHeader('Content-Type', 'application/json');
        //Username and password stored in the named credential that is linked with the payment gateway record
        req.setHeader('apikey', '{!$Credential.Username}');
        req.setHeader('token', '{!$Credential.Password}');
    }
    
    
    private static void getBatchDetails(String currentBatchId, String recordLimit, Integer offset){
        HttpRequest req = new HttpRequest();
        //req.setEndpoint('https://apitest.authorize.net/xml/v1/request.api');
        req.setEndpoint('callout:Authorize_net_Payment_Gateway_sandbox/xml/v1/request.api');
        req.setMethod('GET');
        String reqBodyBatch = '';
        reqBodyBatch = batchTransactionListRequestBody(currentBatchId,recordLimit,offset);
        req.setBody(reqBodyBatch);
        setAuthorizationHeaders(req);
        Http binding = new Http();
        try{
            //HttpResponse res = binding.send(req);
            HttpResponse res = new HttpResponse();
            if(!Test.isRunningTest()){
            	res = binding.send(req);
            }else{
                res.setStatusCode(200);
                String jsonBody='{"getTransactionListResponse":{"-xmlns":"AnetApi/xml/v1/schema/AnetApiSchema.xsd","messages":{"resultCode":"Ok","message":{"code":"I00001","text":"Successful."}},"transactions":{"transaction":[{"transId":"12345","submitTimeUTC":"2009-05-30T09:00:00","submitTimeLocal":"2009-05-30T04:00:00","transactionStatus":"settledSuccessfully","invoice":"INV00001","firstName":"John","lastName":"Doe","amount":"2.00","accountType":"Visa","accountNumber":"XXXX1111","settleAmount":"2.00","subscription":{"id":"145521","payNum":"1"},"profile":{"customerProfileId":"1806660050","customerPaymentProfileId":"1805324550"}},{"transId":"12345","submitTimeUTC":"2009-05-30T09:00:00","submitTimeLocal":"2009-05-30T04:00:00","transactionStatus":"settledSuccessfully","invoice":"INV00001","firstName":"John","lastName":"Doe","amount":"2.00","accountType":"Visa","accountNumber":"XXXX1111","marketType":"eCommerce","product":"Card Not Present","mobileDeviceId":"2354578983274523978"}]},"totalNumInResultSet":"2"}}';
                res.setBody(jsonBody);
            }
            //system.debug('Response: '+res);
            //system.debug('ResponseBody: '+res.getBody());
            if(res.getStatusCode() == 200){
            String jData = res.getBody();
                Map<String,Object> myResponseData = (Map<String,Object>) JSON.deserializeUntyped(jData);
                //List<String> mystring = new List<String>();
                if(myResponseData.containsKey('getTransactionListResponse')){
                    System.debug('Inside...');
                    Map<String, Object> mapOfTransactionResponseByChild = (Map<String, Object>) myResponseData.get('getTransactionListResponse');
                    Map<String, Object> mapOfTransactions = (Map<String, Object>) mapOfTransactionResponseByChild.get('transactions');
                    List<Object> mapOfTransaction = (List<Object>) mapOfTransactions.get('transaction');
                    system.debug('Size: '+mapOfTransaction.size());
                    for(Object mt: mapOfTransaction){
                        Map<String,Object> mtD = (Map<String,Object>) mt;
                        mystring.add(String.valueOf(mtD.get('transId')));
                    }
                    //if(mapOfTransaction.size() == 1000){
                    /*Integer i=0;
                    while(i<2){
                        offset = offset+1;
                        system.debug('Offset: '+offset);
                        getBatchDetails(currentBatchId,recordLimit,offset);
                    }*/
                }
            }
        }catch(System.CalloutException e){
            system.debug('Callout Error: '+e);
        }
    }
        
    private static void updatePaymentAuthorizationRecords(){
        try{
            List<PaymentAuthorization> paymentAuthorization = [SELECT Id,PaymentAuthorizationNumber,OrderPaymentSummaryId,Authorize_Payment_Settlement__c from PaymentAuthorization where GatewayRefNumber in :mystring];
            updateSalesOrders(paymentAuthorization);
            for(PaymentAuthorization pa: paymentAuthorization){
                pa.Authorize_Payment_Settlement__c = 'Payment Settled';
                //pa.Authorize_Payment_Settlement__c = 'Under Settlement';
            }
            update paymentAuthorization;
            
            List<inscor__Sales_Order__c> salesOrder = [select Id,Authorize_Payment_Settlement__c from inscor__Sales_Order__c where Order__c in :orderList];
            for(inscor__Sales_Order__c so: salesOrder){
                so.Authorize_Payment_Settlement__c = 'Payment Settled';
                //so.Authorize_Payment_Settlement__c = 'Under Settlement';
            }
            update salesOrder;
            orderList.clear();
            paymentAuthorization.clear();
        }catch(Exception e) {
            System.debug(e);
        }
    }
    
    private static void updateSalesOrders(List<PaymentAuthorization> paymentAuthorization){
        try{
            for(PaymentAuthorization pa: paymentAuthorization){
                paymentAuthorizationRefNumber.add(pa.OrderPaymentSummaryId);
            }
            
            List<OrderPaymentSummary> orderPaymentSummary = [select Id,OrderSummaryId from OrderPaymentSummary where Id in :paymentAuthorizationRefNumber];
            for(OrderPaymentSummary ops: orderPaymentSummary){
                orderPaymentSummaryList.add(ops.OrderSummaryId);
            }
            
            List<OrderSummary> orderSummary = [select Id,OriginalOrderId from OrderSummary where Id in :orderPaymentSummaryList];
            for(OrderSummary os: orderSummary){
                orderSummaryList.add(os.OriginalOrderId);
            }
            
            List<Order> order = [select Id,OrderNumber from Order where Id in :orderSummaryList];
            for(Order o: order){
                orderList.add(String.valueOf(o.Id));
            }
            paymentAuthorizationRefNumber.clear();
            orderPaymentSummaryList.clear();
            orderSummaryList.clear();
        }catch(Exception e) {
            System.debug(e);
        }
    }
    
    private static String batchTransactionListRequestBody(String batchId, String recordLimit, Integer offset){
        AuthorizeDotNet_Payment_Gateway_Sandbox__mdt authorizeDotNetAccess = AuthorizeDotNet_Payment_Gateway_Sandbox__mdt.getInstance('AuthorizePaymentGatewayDetails');
        JSONGenerator jsonGeneratorInstance = JSON.createGenerator(true);
        jsonGeneratorInstance.writeStartObject();
            jsonGeneratorInstance.writeFieldName('getTransactionListRequest');
            jsonGeneratorInstance.writeStartObject();
                jsonGeneratorInstance.writeFieldName('merchantAuthentication');
                jsonGeneratorInstance.writeStartObject();
                    jsonGeneratorInstance.writeStringField('name',authorizeDotNetAccess.userName__c);
                    jsonGeneratorInstance.writeStringField('transactionKey',authorizeDotNetAccess.password__c);
                jsonGeneratorInstance.writeEndObject();
        
                jsonGeneratorInstance.writeStringField('batchId',batchId);
                
                jsonGeneratorInstance.writeFieldName('sorting');
                jsonGeneratorInstance.writeStartObject();
                    jsonGeneratorInstance.writeStringField('orderBy','submitTimeUTC');
                    jsonGeneratorInstance.writeStringField('orderDescending','true');
                jsonGeneratorInstance.writeEndObject();
                
                jsonGeneratorInstance.writeFieldName('paging');
                jsonGeneratorInstance.writeStartObject();
                    /*jsonGeneratorInstance.writeStringField('limit',recordLimit);
                    jsonGeneratorInstance.writeStringField('offset',String.valueOf(offset));*/
                    jsonGeneratorInstance.writeStringField('limit','1000');
                    jsonGeneratorInstance.writeStringField('offset','1');
                jsonGeneratorInstance.writeEndObject();
        
            jsonGeneratorInstance.writeEndObject();
        jsonGeneratorInstance.writeEndObject();
        
        String dataat = jsonGeneratorInstance.getAsString();
        //system.debug('dataat: '+dataat);
        return dataat;
    }
    
    private static String batchRequestBody(){
        AuthorizeDotNet_Payment_Gateway_Sandbox__mdt authorizeDotNetAccess = AuthorizeDotNet_Payment_Gateway_Sandbox__mdt.getInstance('AuthorizePaymentGatewayDetails');
        JSONGenerator jsonGeneratorInstance = JSON.createGenerator(true);
        jsonGeneratorInstance.writeStartObject();
            jsonGeneratorInstance.writeFieldName('getSettledBatchListRequest');
            jsonGeneratorInstance.writeStartObject();
                jsonGeneratorInstance.writeFieldName('merchantAuthentication');
                jsonGeneratorInstance.writeStartObject();
                    jsonGeneratorInstance.writeStringField('name',authorizeDotNetAccess.userName__c);
                    jsonGeneratorInstance.writeStringField('transactionKey',authorizeDotNetAccess.password__c);
                jsonGeneratorInstance.writeEndObject();
            jsonGeneratorInstance.writeEndObject();
        jsonGeneratorInstance.writeEndObject();
        
        String dataat = jsonGeneratorInstance.getAsString();
        //system.debug('dataat: '+dataat);
        return dataat;
    }
}