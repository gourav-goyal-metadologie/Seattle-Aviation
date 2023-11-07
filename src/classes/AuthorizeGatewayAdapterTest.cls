@isTest
public class AuthorizeGatewayAdapterTest {
    
    public static testmethod void testAuthRequest() {
        //Create a PaymentMethod instance
        commercepayments.AuthApiPaymentMethodRequest paymentMethod = createAuthPaymentMethodRequest();
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new PaymentCalloutMock());
        //Create an auth request
        commercepayments.AuthorizationRequest authRequest = new commercepayments.AuthorizationRequest(80);
        authRequest.paymentMethod = paymentMethod;
        commercepayments.PaymentGatewayContext p = new commercepayments.PaymentGatewayContext(authRequest, commercepayments.RequestType.Authorize);
        AuthorizeAdapter adapter = new AuthorizeAdapter();
        
        commercepayments.GatewayResponse authResponse = adapter.processRequest(p);
        //System.assert(authResponse instanceOf commercepayments.AuthorizationResponse, 'Response is not a valid Authorization response');

        // Metadata
        AuthorizeDotNet_Payment_Gateway_Sandbox__mdt authorizeDotNetAccess = AuthorizeDotNet_Payment_Gateway_Sandbox__mdt.getInstance('AuthorizePaymentGatewayDetails');

    }
    
    public static testmethod void testAuthValidationExceptionRequest() {
        //Create Address request
        commercepayments.AddressRequest address = new commercepayments.AddressRequest('test', 'test', 'test', 'test', 'test');
        
         // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new PaymentCalloutMock());
        //Create an auth request
        commercepayments.AuthorizationRequest authRequest = new commercepayments.AuthorizationRequest(80);
        commercepayments.PaymentGatewayContext p = new commercepayments.PaymentGatewayContext(authRequest, commercepayments.RequestType.Authorize);
        AuthorizeAdapter adapter = new AuthorizeAdapter();
        
        commercepayments.GatewayResponse authResponse = adapter.processRequest(p);
        system.assert(authResponse instanceOf commercepayments.GatewayErrorResponse, 'Response is not a valid Authorization response');
        
    }
    
    public static testmethod void testCaptureRequest() {
        PaymentAuthorization auth = initializeAuthObject();
        insert auth;
        //Dmls and http request can't be performed in a single transaction in apex
        //segreagating the transaction by starting a test context
        Test.startTest();
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new PaymentCalloutMock());
        //Create an capture request
        commercepayments.CaptureRequest captureRequest = new commercepayments.CaptureRequest(80, auth.id);
        
        commercepayments.PaymentGatewayContext p = new commercepayments.PaymentGatewayContext(captureRequest, commercepayments.RequestType.capture);
        AuthorizeAdapter adapter = new AuthorizeAdapter();
        
        commercepayments.GatewayResponse captureResponse = adapter.processRequest(p);
        //system.assert(captureResponse instanceOf commercepayments.CaptureResponse, 'Response is not a valid Capture response');
        Test.stopTest();
    }
    
    public static testmethod void testCaptureFailureRequest() {
        PaymentAuthorization auth = initializeAuthObject();
        insert auth;
        //Dmls and http request can't be performed in a single transaction in apex
        //segreagating the transaction by starting a test context
        Test.startTest();
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new PaymentCalloutFailureMock());
        //Create an capture request
        commercepayments.CaptureRequest captureRequest = new commercepayments.CaptureRequest(80, auth.id);
        
        commercepayments.PaymentGatewayContext p = new commercepayments.PaymentGatewayContext(captureRequest, commercepayments.RequestType.Capture);
        AuthorizeAdapter adapter = new AuthorizeAdapter();
        
        commercepayments.GatewayResponse captureResponse = adapter.processRequest(p);
        //system.assert(captureResponse instanceOf commercepayments.CaptureResponse, 'Response is not a valid Capture response');
        Test.stopTest();
    }
    
    public static testmethod void testTokenizeRequest() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new PaymentCalloutMock());
        //Create an auth request
        commercepayments.PaymentMethodTokenizationRequest tokenizeRequest = new commercepayments.PaymentMethodTokenizationRequest(NULL);
        tokenizeRequest.cardPaymentMethod = getCardPaymentMethod();
        commercepayments.PaymentGatewayContext p = new commercepayments.PaymentGatewayContext(tokenizeRequest, commercepayments.RequestType.Tokenize);
        AuthorizeAdapter adapter = new AuthorizeAdapter();
        commercepayments.GatewayResponse tokenizeResponse = adapter.processRequest(p);
        //system.assert(tokenizeResponse instanceOf commercepayments.PaymentMethodTokenizationResponse, 'Response is not a valid Tokenize response');
        
    }
    
    public static testmethod void testTokenizeFailureRequest() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new PaymentCalloutFailureMock());
        //Create an auth request
        commercepayments.PaymentMethodTokenizationRequest tokenizeRequest = new commercepayments.PaymentMethodTokenizationRequest(NULL);
        tokenizeRequest.cardPaymentMethod = getCardPaymentMethod();
        commercepayments.PaymentGatewayContext p = new commercepayments.PaymentGatewayContext(tokenizeRequest, commercepayments.RequestType.Tokenize);
        AuthorizeAdapter adapter = new AuthorizeAdapter();
        commercepayments.GatewayResponse tokenizeResponse = adapter.processRequest(p);
        //system.assert(tokenizeResponse instanceOf commercepayments.PaymentMethodTokenizationResponse, 'Response is not a valid Tokenize response');
    }
    
    private static PaymentAuthorization initializeAuthObject()
    {
        PaymentAuthorization auth = new PaymentAuthorization();
        auth.amount = 10;
        auth.Status = 'Processed';
        auth.ProcessingMode = 'External';
        auth.GatewayRefNumber = 'testreferencenumber';
        auth.GatewayRefDetails = '{"method":"credit_card","transaction_id":"ET119982"}';
        return auth;
    
    }
    
    private static Payment initializePaymentObject()
    {
        Payment pmt = new Payment();
        pmt.amount = 10;
        pmt.Status = 'Processed';
        pmt.ProcessingMode = 'External';
        pmt.GatewayRefNumber = 'testreferencenumber';
        pmt.Type = 'Capture';
        pmt.GatewayRefDetails = '{"method":"credit_card","transaction_id":"ET119982"}';
        return pmt;    
    }
    
    private static commercepayments.AuthApiPaymentMethodRequest createAuthPaymentMethodRequest()
    {
        //Create a PaymentMethod instance
        commercepayments.AuthApiPaymentMethodRequest paymentMethod = new commercepayments.AuthApiPaymentMethodRequest(getCardPaymentMethod());
        return paymentMethod;
    }
    
    private static commercepayments.CardPaymentMethodRequest getCardPaymentMethod(){
        commercepayments.CardPaymentMethodRequest cardPaymentMethod = new commercepayments.CardPaymentMethodRequest(commercepayments.CardCategory.CreditCard);
        //cardPaymentMethod.cardType = commercepayments.CardType.Visa;
        cardPaymentMethod.cardType = commercepayments.CardType.MasterCard;
        cardPaymentMethod.cardHolderFirstName = 'Test';
        cardPaymentMethod.cardHolderLastName = 'Test';
        cardPaymentMethod.cardHolderName = 'Test Test';
        cardPaymentMethod.cardNumber = '5424000000000015';
        cardPaymentMethod.cvv = '123';
        cardPaymentMethod.email = 'test@test.com';
        cardPaymentMethod.expiryMonth = 12;
        cardPaymentMethod.expiryYear = 2025;
        cardPaymentMethod.startMonth = 02;
        cardPaymentMethod.startYear = 2021;
        return cardPaymentMethod;
        
        //return '{"createTransactionRequest":{"merchantAuthentication":{"name":"47NvzG283kNx","transactionKey":"6y84Jax62AUx2gBD"},"refId":"81725712930192301","transactionRequest":{"transactionType":"authCaptureTransaction","amount":"10","payment": {"creditCard": {"cardNumber": "5424000000000015","expirationDate": "2025-12","cardCode": "999"}}}}}';
    }
    
}