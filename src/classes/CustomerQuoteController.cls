public with sharing class CustomerQuoteController{

    @AuraEnabled
    public static List<inscor__Customer_Quote_Line__c> createQuoteAndLine(List<Map<String,String>> productList){   
        
        string accountId;      
        system.debug('productList => '+productList);

         // User Info...
        List<User> UserDetails = new List<User>([SELECT Id,AccountId,ContactID FROM User WHERE Id =:UserInfo.getUserId()]);
        for (User useraccId : UserDetails) {
            accountId = useraccId.AccountId;
        }
        system.debug('Get user => '+UserInfo.getUserId());
        system.debug('UserDetails => '+UserDetails);
        system.debug('accountId => '+accountId);

        // Condition Code Fetch
        Map<String,String> ConditionCode = new Map<String,String>();
        List<inscor__Condition_Code__c> CondCode =  [SELECT Id, Name FROM inscor__Condition_Code__c];
        system.debug('Cart Details => '+CondCode);        
        for (inscor__Condition_Code__c row : CondCode) {
            ConditionCode.put(row.Name, row.Id);
            //CartId = Cartlist.Id;
        }
        system.debug('ConditionCode List => '+ConditionCode);
        
        String jsonString = '{';
        //create Quote Account.
        inscor__Customer_Quote__c customerQuote = new inscor__Customer_Quote__c();
        customerQuote.inscor__Customer__c = accountId;
        customerQuote.inscor__Temp_Quote__c = true;
        customerQuote.inscor__Quote_Source__c = 'Storefront';
        customerQuote.OwnerId = UserInfo.getUserId();
        customerQuote.inscor__Contact__c = UserDetails[0].ContactID;
        customerQuote.inscor__Assigned_To__c = UserDetails[0].Id;
        System.debug('jsonString -> '+jsonString);
        jsonString += '"Quote":'+JSON.serialize(customerQuote)+',';
        
        /* jsonString +=jsonString+'"customer":"'+accountId+'",';
        jsonString +=jsonString+'"customer":"'+accountId+'",';
        jsonString +=jsonString+'"customer":"'+accountId+'",'; */
        
        System.debug('jsonString -> '+jsonString);
        //insert customerQuote;
        system.debug('customerQuote => '+customerQuote);
    
        // Create Quote Line.
        List<String> PriceType = new List<String>{'Cost Plus', 'Flat Rate w/OH Core', 'Flat Rate w/SV Core','Flat Rate w/Repairable Core'};
        List<inscor__Customer_Quote_Line__c> lineList = new List<inscor__Customer_Quote_Line__c>();    
        for(Map<String,String> row:productList){
            inscor__Customer_Quote_Line__c eachLine = new inscor__Customer_Quote_Line__c();
            string Ccode = row.get('code_id');
            List<String> code_id = new List<String>();
            String exchangeType;
            if(Ccode.contains(' - ')){
                code_id = Ccode.split(' - ');
                exchangeType = code_id[1];
            } else {
                code_id.add(Ccode);
                exchangeType = 'Outright';
            }
            //String cond_code = customerQuote.get(code_id[0]);
            eachLine.inscor__Customer_Quote__c = customerQuote.Id;
            eachLine.inscor__Customer_Part_Number__c = row.get('key');
            eachLine.inscor__Product__c = row.get('key');            
            eachLine.inscor__Condition_Code__c = ConditionCode.get(code_id[0]);//row.get('code_id');
            if(PriceType.contains(exchangeType)){
                eachLine.inscor__Quote_Type__c = 'Exchange';
                eachLine.inscor__Exchange_Type__c = exchangeType;
                eachLine.inscor__Outright_Price__c = 0;
                eachLine.inscor__Core_Due__c = 30;
                eachLine.inscor__Core_Disposition__c = 'Receive ‘As Is’';
                eachLine.inscor__Stock_Disposition__c = 'Return To Stock';
            }else{
                eachLine.inscor__Quote_Type__c = 'Outright';
            }
            eachLine.inscor__Quantity__c = Decimal.valueOf(row.get('qty'));
            
            
            lineList.add(eachLine);
        } 
        jsonString += '"QuoteLine":'+JSON.Serialize(lineList)+'}' ;
        
        System.debug('jsonString -> '+jsonString);
        
        HttpResponse res = getSalesforceAuth();
        System.debug('res.getBody() -> '+res.getBody());
        if(res.getStatusCode()==200){
            Map<String,Object> accessMap = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
            
            HttpRequest req = new HttpRequest();
            req.setEndpoint((String)accessMap.get('instance_url')+'/services/apexrest/CreateCQ/');
            req.setHeader('Content-Type','application/json');
            req.setHeader('Authorization', 'Bearer '+(String)accessMap.get('access_token'));
            req.setTimeout(120000);
            req.setBody(jsonString);
            req.setMethod('POST');
            
            Http http = new Http();
            HttpResponse resp = http.send(req);
            System.debug('Response -> '+resp.getBody());
        }
        
        
        
        
        system.debug('lineList Size => '+lineList.size());
        /* if(!lineList.isEmpty()){
            insert lineList;
        } */
        //system.debug('lineList => '+lineList);
        return lineList;
    }

    @AuraEnabled
    public static String ProductName(String productId){
        
        String Product_Name; 
        for(Product2 eachProduct :[SELECT Id,Name FROM Product2 WHERE Id=:productId]){
            Product_Name = eachProduct.Name;
            system.debug('eachProduct => '+eachProduct);
        }
        system.debug('ProductList => '+ Product_Name);
        return Product_Name;
    }
    
    public static HttpResponse getSalesforceAuth(){
        system.debug('Start getSalesforceAuth =>');
        Salesforce_Auth__c objSalesforceAuth = [SELECT Id, Client_Id__c, Client_Secret__c, Login_Url__c, Password__c, Security_Token__c, UserName__c FROM Salesforce_Auth__c];
        String originalPassword = '';
        If(!test.isRunningTest()){
            Blob bodyBlob = Blob.valueOf(objSalesforceAuth.Password__c);
            String password = bodyBlob.toString();
            Blob originalPasswordBlob	= EncodingUtil.base64Decode(password);
            originalPassword = originalPasswordBlob.toString();
        }else{
            originalPassword = 'success101';
        }
        
        
        HttpRequest httpRequest = new HttpRequest();  
        httpRequest.setEndpoint(objSalesforceAuth.Login_Url__c);
        httpRequest.setMethod('POST');
        httpRequest.setBody('grant_type=password&client_id='+objSalesforceAuth.Client_Id__c+'&client_secret='+objSalesforceAuth.Client_Secret__c+'&username='+objSalesforceAuth.UserName__c+'&password='+originalPassword);
        Http http = new Http();   
        HttpResponse httpResponse = http.send(httpRequest);
        System.debug('httpResponse -> '+httpResponse);
        return httpResponse;
    }
}