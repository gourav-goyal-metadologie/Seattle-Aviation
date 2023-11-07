@isTest
global class CustomerquoteTestcontroller implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        if(request.getEndpoint() == 'https://test.salesforce.com'){
            response.setHeader('Content-Type', 'application/json');
            response.setBody('{"access_token":"test","instance_url":"https://test.salesforce.com"}');
            response.setStatusCode(200);
        } else if(request.getEndpoint() == 'https://test.salesforce.com/services/apexrest/CreateCQ/'){
            response.setHeader('Content-Type', 'application/json');
            response.setBody('{"Quote":{"attributes":{"type":"inscor__Customer_Quote__c"},"inscor__Customer__c":"0016s00000OZT47AAH","inscor__Temp_Quote__c":true,"inscor__Quote_Source__c":"Storefront"},"QuoteLine":[{"attributes":{"type":"inscor__Customer_Quote_Line__c"},"inscor__Customer_Quote__c":null,"inscor__Customer_Part_Number__c":"01t6s000000zBxKAAU","inscor__Product__c":"01t6s000000zBxKAAU","inscor__Condition_Code__c":"a096s000000e2dHAAQ","inscor__Quote_Type__c":"Outright","inscor__Quantity__c":2}]}');
            response.setStatusCode(200);
        }
        else if(request.getEndpoint() == 'https://test.salesforce.com/services/apexrest/CreateSO/'){
            response.setHeader('Content-Type', 'application/json');
            response.setBody('{"OrderId":'+JSON.serialize('8016s000000KNHUAA4')+'}');
            response.setStatusCode(200);
        }
        return response; 
    }

}