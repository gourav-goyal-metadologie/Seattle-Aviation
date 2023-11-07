/**
 * Authorization Service class 
 */ 
public class AuthorizationTransactionService extends AbstractTransactionService{

    /**
     * Constructor that sets the gatewayContext for the service
     * The gateway context contains the input request and request type
     */ 
    public AuthorizationTransactionService(commercepayments.paymentGatewayContext gatewayContext){
        super(gatewayContext);
    }
    
    /**
     * Function to build request for Authorization Transaction
     * Creates a new request and set request body, authorization parameters and other related fields
     */ 
    public override HttpRequest buildRequest(){
        HttpRequest req = new HttpRequest();
        //req.setEndpoint('/v1/transactions');
        if(Test.isRunningTest()){
            req.setEndpoint('https://apitest.authorize.net/xml/v1/request.api');
        }else{
            //req.setEndpoint('callout:Authorize_net_Payment_Gateway_sandbox/xml/v1/request.api');
            req.setEndpoint('/xml/v1/request.api');
        }        
        req.setMethod('POST');
        system.debug('EndPoint: '+req.getEndpoint());
        req.setBody(buildAuthRequestBody((commercepayments.AuthorizationRequest)gatewayContext.getPaymentRequest()));
        setAuthorizationHeaders(req);
        return req;
    }
    
    /**
     * Function to build gateway response for Authorization Transaction
     * The input is the response from gateway
     * It creates and returns AuthGatewayResponse from the HttpResponse
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
        /*if(Test.isRunningTest()){
            TRANSACTION_STATUS = 'OK';
        }*/
        system.debug('skdkas dak dkajs dkasd: '+TRANSACTION_STATUS);
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
        
        String amountStr = getPaymentAmount((commercepayments.AuthorizationRequest)gatewayContext.getPaymentRequest());
        if(amountStr != null){
            Double amountDbl = double.valueOf(amountStr);
            //amount is divided by 100 to convert cents to dollars
            //authResponse.setAmount(double.valueOf(amountDbl/100.0));
            authResponse.setAmount(amountDbl);
        }
        //Gateway does not send date, assigning the current date for recording purpose
        authResponse.setGatewayDate(system.now());
        
        commercepayments.PaymentMethodTokenizationResponse paymentMethodTokenizationResponse = new commercepayments.PaymentMethodTokenizationResponse();
        //paymentMethodTokenizationResponse.setGatewayToken(mapOfResponseValues.get('value'));
        authResponse.setPaymentMethodTokenizationResponse(paymentMethodTokenizationResponse);
        return authResponse;
    }
    
    
    private String getPaymentAmount(commercepayments.AuthorizationRequest authRequest) {
        String amount = '0';
        if(authRequest.amount!=null){
            amount = String.ValueOf(authRequest.amount);
        }
        return amount;
    }
    
    /**
     * Function to build request body for Authorization Transaction
     */
    private String buildAuthRequestBody(commercepayments.AuthorizationRequest authRequest) {
        system.debug('Mera final Auth: '+authRequest);
        String currencyIso = authRequest.currencyIsoCode;
        commercepayments.AuthApiPaymentMethodRequest paymentMethod = authRequest.paymentMethod;
        JSONGenerator jsonGeneratorInstance = JSON.createGenerator(true);
        commercepayments.GatewayErrorResponse error;
        
        // Metadata
        //AuthorizeDotNet_Payment_Gateway_Sandbox__mdt authorizeDotNetAccess = AuthorizeDotNet_Payment_Gateway_Sandbox__mdt.getInstance('Sandbox');
        AuthorizeDotNet_Payment_Gateway_Sandbox__mdt authorizeDotNetAccess = AuthorizeDotNet_Payment_Gateway_Sandbox__mdt.getInstance('AuthorizePaymentGatewayDetails');
        String timestamp = string.valueof(DateTime.now().getTime());
        // Write data to the JSON string
        jsonGeneratorInstance.writeStartObject();
            jsonGeneratorInstance.writeFieldName('createTransactionRequest');
            jsonGeneratorInstance.writeStartObject();
                jsonGeneratorInstance.writeFieldName('merchantAuthentication');
                jsonGeneratorInstance.writeStartObject();
                    jsonGeneratorInstance.writeStringField('name',authorizeDotNetAccess.userName__c);
                    jsonGeneratorInstance.writeStringField('transactionKey',authorizeDotNetAccess.password__c);
                jsonGeneratorInstance.writeEndObject();
        
                jsonGeneratorInstance.writeStringField('refId',timestamp);
        
                jsonGeneratorInstance.writeFieldName('transactionRequest');
                jsonGeneratorInstance.writeStartObject();
                    jsonGeneratorInstance.writeStringField('transactionType','authCaptureTransaction');
                    String amount = '0';
                    if(authRequest.amount!=null){
                        amount = String.ValueOf(authRequest.amount);
                    }
                    jsonGeneratorInstance.writeStringField('amount',amount);
                    if(paymentMethod !=null) {
                        jsonGeneratorInstance.writeFieldName('payment');
                        jsonGeneratorInstance.writeStartObject();
                        if(paymentMethod.cardPaymentMethod!=null){
                            //get the payment method part of request using buildCardPaymentMethodBody
                            String cardRequestBody = buildCardPaymentMethodBody(paymentMethod.cardPaymentMethod);
                            Map<String, Object> mapOfJson = (Map<String, Object>) JSON.deserializeUntyped(cardRequestBody);
                            String cardCategory = String.ValueOf(mapOfJson.get('method'));
                            jsonGeneratorInstance.writeObjectField('creditCard', mapOfJson.get(cardCategory));
                        }else {
                            //Add new payment Method here
                            throw new AuthorizeValidationException('Required Field Missing : CardPaymentMethod');
                        }
                        jsonGeneratorInstance.writeEndObject();
                    } else {
                        throw new AuthorizeValidationException('Required Field Missing : PaymentMethod');
                    }
                jsonGeneratorInstance.writeEndObject();
        
            jsonGeneratorInstance.writeEndObject();
        jsonGeneratorInstance.writeEndObject();
        
        String myreturn = jsonGeneratorInstance.getAsString();
        system.debug('Test return: '+myreturn);
        return myreturn;
    }

}