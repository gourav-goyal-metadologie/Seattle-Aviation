public class PaymentCalloutMock implements HttpCalloutMock {
    public HTTPResponse respond(HTTPRequest req) {
        System.assertEquals('POST', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        List<String> jsonResponse;
        if(req.getEndpoint().contains('tokens')){
          	/*jsonResponse = new List<String> {
        		'"correlation_id": "124.9765829358068"',
        		'"status": "success"',
        		'"type": "FDToken"',
            	'"token": {"type": "VISA","cardholder_name": "JohnSmith","exp_date": "1030","value": "2537446225198291"}'
      		};*/
            jsonResponse = new List<String>{'"messages":{"resultCode":"Error","message":[{"code":"E00003","text":"The AnetApi/xml/v1/schema/AnetApiSchema.xsd:transactionKey element is invalid - The value XXXXXXXXXXXXXXXXXXXXXX is invalid according to its datatype String - The actual length is greater than the MaxLength value."}]}'};
        }
        else{
          /*jsonResponse = new List<String> {
                '"method": "credit_card"',
                '"amount": "15000"',
                '"currency": "USD"',
                '"cvv2": "111"',
                '"card": {"type": "VISA","cardholder_name": "Test Name","card_number": "1111","exp_date": "1122"}',
                '"token": {"token_type": "FDToken","token_data": {"value": "9916904738371111"}}',
                '"transaction_status": "approved"',
                '"validation_status": "success"',
                '"transaction_type": "authorize"',
                '"transaction_id": "ET119982"',
                '"transaction_tag": "2316284066"',
                '"bank_resp_code": "100"',
                '"bank_message": "Approved"',
                '"gateway_resp_code": "00"',
                '"gateway_message": "Transaction Normal"'                  
            };*/
            jsonResponse = new List<String>{'"transactionResponse":{"responseCode":"1","authCode":"HW617E","avsResultCode":"Y","cvvResultCode":"","cavvResultCode":"","transId":"2157047189","refTransID":"","transHash":"E7CEB0A9F1BECA32A02493E1B31D5955","testRequest":"0","accountNumber":"XXXX1111","accountType":"Visa","messages":[{"code":"1","description":"This transaction has been approved."}],"transHashSha2":"D0C4FFF5648511A5862B917CFD9BB78ABF8A6E1D90C119CBBC4C0B454F4FF40DED15B204E042F36ECA5FB15D02588E4E4A7B85B94E7279599CE6020462CB7DEE","SupplementalDataQualificationIndicator":0,"networkTransId":"123456789NNNH"},"messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}'};
        }
        res.setBody('{' + String.join(jsonResponse, ',') + '}');
        return res;
    }
}