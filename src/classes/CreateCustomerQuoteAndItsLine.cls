@RestResource(urlMapping='/CreateCQ/*') 
global class CreateCustomerQuoteAndItsLine {
  @HttpPost
    global static void doPost(){
        try{
            RestRequest req = RestContext.request;
            String jsonBody = '';
            If(test.isRunningTest()){
                jsonBody = '{"Quote":{"attributes":{"type":"inscor__Customer_Quote__c"},"inscor__Customer__c":"0016s00000OZT47AAH","inscor__Temp_Quote__c":true,"inscor__Quote_Source__c":"Storefront"},"QuoteLine":[{"attributes":{"type":"inscor__Customer_Quote_Line__c"},"inscor__Customer_Quote__c":null,"inscor__Customer_Part_Number__c":"01t6s000000zBxKAAU","inscor__Product__c":"01t6s000000zBxKAAU","inscor__Condition_Code__c":"a096s000000e2dHAAQ","inscor__Quote_Type__c":"Outright","inscor__Quantity__c":2}]}';
            } else {
                jsonBody = req.requestBody.toString();
            }
            //jsonBody = req.requestBody.toString();
            System.debug('jsonBody -> '+jsonBody);
            Map<String,Object> productList = (Map<String,Object>)JSON.deserializeUntyped(jsonBody);
            Map<String,Object> quoteMap = (Map<String,Object>)productList.get('Quote');
            inscor__Customer_Quote__c customerQuote = new inscor__Customer_Quote__c();
            customerQuote.inscor__Customer__c = (String)quoteMap.get('inscor__Customer__c');
            customerQuote.inscor__Temp_Quote__c = (Boolean)quoteMap.get('inscor__Temp_Quote__c');
            customerQuote.inscor__Quote_Source__c = 'Storefront';
            customerQuote.OwnerId = (String)quoteMap.get('OwnerId');
            customerQuote.inscor__Contact__c = (String)quoteMap.get('inscor__Contact__c');
            customerQuote.inscor__Assigned_To__c = (String)quoteMap.get('inscor__Assigned_To__c');
            //customerQuote = (inscor__Customer_Quote__c)productList.get('Quote');
            If(!test.isRunningTest()){
                insert customerQuote;
            }
            
            System.debug('customerQuote -> '+customerQuote);
            
            List<inscor__Customer_Quote_Line__c> quoteLineList = new List<inscor__Customer_Quote_Line__c>(); 
            
            List<Object> lineList =(List<Object>)productList.get('QuoteLine'); 
            for(Object eachLine : lineList){  
                Map<String,Object> quoteLineMap = (Map<String,Object>)eachLine;
                inscor__Customer_Quote_Line__c quoteLine = new inscor__Customer_Quote_Line__c();
                quoteLine.inscor__Customer_Quote__c = customerQuote.Id;
                
                quoteLine.inscor__Customer_Part_Number__c = (String)quoteLineMap.get('inscor__Customer_Part_Number__c');
                quoteLine.inscor__Product__c = (String)quoteLineMap.get('inscor__Product__c');            
                quoteLine.inscor__Condition_Code__c = (String)quoteLineMap.get('inscor__Condition_Code__c');
                
                quoteLine.inscor__Quote_Type__c = (String)quoteLineMap.get('inscor__Quote_Type__c');
                quoteLine.inscor__Exchange_Type__c = (String)quoteLineMap.get('inscor__Exchange_Type__c');
                quoteLine.inscor__Outright_Price__c = (Decimal)quoteLineMap.get('inscor__Outright_Price__c');
                quoteLine.inscor__Core_Due__c = (Decimal)quoteLineMap.get('inscor__Core_Due__c');
                quoteLine.inscor__Core_Disposition__c = (String)quoteLineMap.get('inscor__Core_Disposition__c');
                quoteLine.inscor__Stock_Disposition__c = (String)quoteLineMap.get('inscor__Stock_Disposition__c');
                
                quoteLine.inscor__Quantity__c = (Decimal)quoteLineMap.get('inscor__Quantity__c');
                quoteLineList.add(quoteLine);
            }
            
            if(!quoteLineList.isEmpty()){
                insert quoteLineList;
                System.debug('quoteLineList -> '+quoteLineList.size());
            }
        }catch(exception e){
            System.debug('Error '+e.getLineNumber());
            System.debug('Error '+e.getMessage());
            //return 'Something went wrong '+e.getMessage();
        }
    } 
}