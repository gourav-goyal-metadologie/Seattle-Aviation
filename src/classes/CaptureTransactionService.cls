/**
 * Capture Service class
 */ 
public class CaptureTransactionService extends AbstractTransactionService{
    
    /**
     * Constructor that sets the gatewayContext for the service
     */ 
    public CaptureTransactionService(commercepayments.paymentGatewayContext gatewayContext){
        super(gatewayContext);
    }
    
    /**
     * Function to build request for Capture Transaction
     * Creates a new request and set request body, authorization parameters and other related fields
     */ 
    public override HttpRequest buildRequest(){
        HttpRequest req = new HttpRequest();
        //The rest of the endpoint is set in the buildCaptureRequestBody
        req.setEndpoint('/v1/transactions/');
        req.setMethod('POST');
        req.setBody(buildCaptureRequestBody((commercepayments.CaptureRequest)gatewayContext.getPaymentRequest(),req));
        setAuthorizationHeaders(req);
        return req; 
    }
    
    /**
     * Function to build gateway response for Capture Transaction
     * The input is the response from gateway
     * It creates and returns CptureGatewayResponse from the HttpResponse
     */
    public override commercepayments.GatewayResponse buildResponse(HttpResponse response){
        String statusCode = String.valueOf(response.getStatusCode());
        String strJSON = response.getBody();
        strJSON = strJSON.trim().replace('\uFEFF', '');
        String res_code = null;
        String TRANSACTION_STATUS = String.valueOf(response.getStatus()); //mapOfResponseValues.get(TRANSACTION_STATUS);
        String salesforceResultCode = null;
        Map<String,Object> deserializedResponseData = (Map<String,Object>) JSON.deserializeUntyped(strJSON);
        
        if(deserializedResponseData.containsKey('transactionResponse')){
            AuthorizeDotNetPaymentResponseWrapper obj = (AuthorizeDotNetPaymentResponseWrapper)System.JSON.deserialize(strJSON,AuthorizeDotNetPaymentResponseWrapper.class);
            AuthorizeDotNetPaymentResponseWrapper.Messages_Z objMessages = new AuthorizeDotNetPaymentResponseWrapper.Messages_Z();
            objMessages = obj.messages;
            if(objMessages.resultCode.toLowercase() == 'ok'){
                TRANSACTION_STATUS = objMessages.resultCode.toUppercase();
            }else{
                TRANSACTION_STATUS = ((objMessages.resultCode != NULL)?objMessages.resultCode:'Error'); //'Error'
            }
        }else{
            TRANSACTION_STATUS = 'Error';
        }
        
        commercepayments.AuthorizationResponse authResponse = new commercepayments.AuthorizationResponse();
        system.debug('Build Response authResponse: '+authResponse);
        if(TRANSACTION_STATUS != null){
            if(TRANSACTION_STATUS == APPROVED){
                AuthorizeDotNetPaymentResponseWrapper responseWrapperObj = (AuthorizeDotNetPaymentResponseWrapper)System.JSON.deserialize(strJSON,AuthorizeDotNetPaymentResponseWrapper.class);
                AuthorizeDotNetPaymentResponseWrapper.TransactionResponse objTransaction = new AuthorizeDotNetPaymentResponseWrapper.TransactionResponse();
                objTransaction = responseWrapperObj.transactionResponse;
                system.debug('objTransaction: '+objTransaction);
                List<AuthorizeDotNetPaymentResponseWrapper.Messages> tranMessages = new List<AuthorizeDotNetPaymentResponseWrapper.Messages>();
                tranMessages = objTransaction.messages;
                system.debug('tranMessages: '+tranMessages);
                
                //Successful gateway response
                res_code = statusCode; //mapOfResponseValues.get(GATEWAY_RESPONSE_CODE);
                salesforceResultCode = SUCCESS_SALESFORCE_RESULT_CODE.name();
                
                //Populating successful auth response
                authResponse.setGatewayResultCode(res_code);
                //authResponse.setGatewayResultCodeDescription(mapOfResponseValues.get(GATEWAY_MESSAGE));
                authResponse.setGatewayResultCodeDescription(tranMessages[0].description);
                //authResponse.setGatewayResultCodeDescription('Payment Successful!');
                authResponse.setGatewayReferenceDetails(responseWrapperObj.refId);
                //authResponse.setGatewayReferenceNumber(mapOfResponseValues.get(TRANSACTION_TAG));
               	authResponse.setGatewayReferenceNumber(objTransaction.transId);
            }else{
                //Failed gateway response
                salesforceResultCode = DECLINE_SALESFORCE_RESULT_CODE.name();
                res_code = statusCode;//mapOfResponseValues.get('code');
                String description = 'Failed'; //mapOfResponseValues.get('description');
                //Populating failed auth response
                if(res_code != null){
                    authResponse.setGatewayResultCode(res_code);
                } /*else if(mapOfResponseValues.get(VALIDATION_STATUS) != null){
                    authResponse.setGatewayResultCode('Validation Status - failed');
                }*/ else{
                    authResponse.setGatewayResultCode('failed');
                }
                if(description != null){
                    authResponse.setGatewayResultCodeDescription(description);  
                }else{
                    authResponse.setGatewayResultCodeDescription(TRANSACTION_STATUS);
                }
            }
            
            //Gateway Result code mappings provided as custom metadata for the gateway
            if (useCustomMetadata) {
                // If customMetadata is used, fetch the salesforce result code info from the gateway result code mappings
                authResponse.setSalesforceResultCodeInfo(getSalesforceResultCodeInfo(res_code));
            } else {
                // Else fetch the salesforce result code info from the salesforce result code set in the method
                authResponse.setSalesforceResultCodeInfo(getSalesforceResultCodeInfo(salesforceResultCode));
            }
        }else {
                //String message = mapOfResponseValues.get('message') == null? mapOfResponseValues.get('description') :mapOfResponseValues.get('message');
                String message = 'Something went wrong';
                commercepayments.GatewayErrorResponse error = new commercepayments.GatewayErrorResponse(statusCode, message);
                return error;
        }
        //String amountStr = mapOfResponseValues.get('amount');
        
        //Double amountStr = getPaymentAmount((commercepayments.AuthorizationRequest)gatewayContext.getPaymentRequest());
        /*if(amountStr != null){
            Double amountDbl = double.valueOf(amountStr);
            authResponse.setAmount(amountDbl);
        }*/
        commercepayments.AuthorizationRequest authRequest = (commercepayments.AuthorizationRequest)gatewayContext.getPaymentRequest();
        Double amount = 0.00;
        if(authRequest.amount!=null){
            amount = double.ValueOf(authRequest.amount);
        }
        //Double amountDbl = double.valueOf(amount);
        authResponse.setAmount(amount);
        //Gateway does not send date, assigning the current date for recording purpose
        authResponse.setGatewayDate(system.now());
        
        commercepayments.PaymentMethodTokenizationResponse paymentMethodTokenizationResponse = new commercepayments.PaymentMethodTokenizationResponse();
        //paymentMethodTokenizationResponse.setGatewayToken(mapOfResponseValues.get('value'));
        authResponse.setPaymentMethodTokenizationResponse(paymentMethodTokenizationResponse);
        return authResponse;
    }
    
    /**
     * Function to build request body for Capture Transaction
     */
    private String buildCaptureRequestBody(commercepayments.CaptureRequest captureRequest,HttpRequest req) {
        Boolean IS_MULTICURRENCY_ORG = UserInfo.isMultiCurrencyOrganization();
        //Get the authorization object with all the required fields
        PaymentAuthorization authObject = getAuthObjectForCapture(captureRequest.paymentAuthorizationId,IS_MULTICURRENCY_ORG);
        String transactionId,method;
        try {
            Map<String, Object> refDetailsMap = (Map<String, Object>) JSON.deserializeUntyped(authObject.GatewayRefDetails);
            transactionId = (String)refDetailsMap.get('transaction_id');
            method = (String)refDetailsMap.get('method');
        } catch(Exception e) {}
        //Adding transaction_id to the end point   
        req.setEndpoint(req.getEndpoint() + transactionId);
         
        JSONGenerator jsonGeneratorInstance = JSON.createGenerator(true);
        // Write data to the JSON string.
        jsonGeneratorInstance.writeStartObject();
        jsonGeneratorInstance.writeStringField('merchant_ref', '');
        jsonGeneratorInstance.writeStringField('transaction_type', 'capture');
        jsonGeneratorInstance.writeStringField('transaction_tag', authObject.GatewayRefNumber);
        if(captureRequest.amount!=null)
            //Amount is multiplied by 100 as gateway accepts input in cents
            jsonGeneratorInstance.writeStringField('amount', String.ValueOf((captureRequest.amount*100.0).intValue()));
        if (IS_MULTICURRENCY_ORG) {
            jsonGeneratorInstance.writeStringField('currency_code', authObject.get('CurrencyIsoCode').toString());
        } else {
            jsonGeneratorInstance.writeStringField('currency_code', UserInfo.getDefaultCurrency());
        }
        jsonGeneratorInstance.writeStringField('method', method);
        jsonGeneratorInstance.writeEndObject();
        return jsonGeneratorInstance.getAsString(); 
    }
    
    /**
     * Get the auth record with all the required fields 
     * Database call from apex done to fetch the record
     */ 
    private PaymentAuthorization getAuthObjectForCapture(String authorizationId, Boolean IS_MULTICURRENCY_ORG){
        List<String> listOfFields = new List<String>();
        listOfFields.add('GatewayAuthCode');
        listOfFields.add('GatewayRefNumber');
        listOfFields.add('GatewayRefDetails');
        if (IS_MULTICURRENCY_ORG) {
            // currency of auth required if org is multi currency
            listOfFields.add('CurrencyIsoCode');
        }
        //Fetch the authorization record using the Auth Id
        PaymentAuthorization authObject = (PaymentAuthorization)DaoService.getSobjectById(authorizationId, listOfFields, PaymentAuthorization.SObjectType);
        return authObject;
    }
}