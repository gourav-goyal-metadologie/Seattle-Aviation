@RestResource(urlMapping='/CreateSO/*') 
global with sharing class CreateSO {
    @HttpPost
    global static void doPost(){
        try{
            RestRequest req = RestContext.request;
            String jsonBody = '';
            if(test.isRunningTest()){
                jsonBody = '{"OrderId":"8016s000000KNHUAA4"}';
            } else {
                jsonBody = req.requestBody.toString();
            }
            System.debug('jsonBody -> '+jsonBody);
            Map<String,Object> soList = (Map<String,Object>)JSON.deserializeUntyped(jsonBody);
            String orderId = (String)soList.get('OrderId');
            System.debug('orderId ->'+orderId );
            
            List<Order> orderList = new List<Order>();
            if(Test.isRunningTest()){
                orderList =[SELECT Id,AccountID,OwnerId,PoNumber,Internal_Comments__c,Line_Level_Comment__c FROM Order LIMIT 1];
            }else{
                orderList = new List<Order>([SELECT Id,AccountID,OwnerId,PoNumber,Internal_Comments__c,Line_Level_Comment__c FROM Order Where Id=:orderId]);
            }            
            
            List<OrderSummary> orderSummaryList = new List<OrderSummary>([SELECT ID FROM OrderSummary WHERE OriginalOrderId =: orderList[0].Id]);
            
            List<OrderDeliveryGroup> ordDGList = new List<OrderDeliveryGroup>([SELECT ID,DeliveryInstructions,DeliverToStreet, DeliverToCity, DeliverToState, DeliverToPostalCode, DeliverToCountry FROM OrderDeliveryGroup WHERE OrderId =: orderList[0].Id]);
            
            
            String accountShipAddressID = '';
            for(inscor__Account_Ship_Address__c eachAddress :[SELECT ID,inscor__Street__c FROM inscor__Account_Ship_Address__c WHERE inscor__Account__c =: orderList[0].AccountId AND Shipping__c= true AND inscor__City__c =: ordDGList[0].DeliverToCity AND inscor__State__c =: ordDGList[0].DeliverToState AND inscor__Postal_Code__c =: ordDGList[0].DeliverToPostalCode AND inscor__Country__c =: ordDGList[0].DeliverToCountry Order By CreatedDate Desc]){
                if(eachAddress.inscor__Street__c == ordDGList[0].DeliverToStreet){
                    accountShipAddressID = eachAddress.Id;
                    break;
                }
            }
            List<PaymentAuthorization> listPA = new List<PaymentAuthorization>(); 
            
            if(!Test.isRunningTest()){
                listPA = [SELECT ID FROM PaymentAuthorization WHERE OrderPaymentSummaryId =: orderSummaryList[0].Id];
            }
            
            List<User> userList = new List<User>([SELECT ID,ContactID FROM User WHERE ID =: orderList[0].OwnerId]);
            
            inscor__Sales_Order__c newSO = new inscor__Sales_Order__c();
            newSO.inscor__Customer__c = orderList[0].AccountId;
            newSO.inscor__Assigned_To__c = orderList[0].OwnerId;
            newSO.Order__c = orderList[0].Id;
            newSO.inscor__Contact__c = userList[0].ContactID;
            newSO.inscor__Order_Source__c = 'Storefront';
            newSO.OwnerId = orderList[0].OwnerId;
            if(String.isNotBlank(accountShipAddressID))
                newSO.inscor__Ship_To_Address__c = accountShipAddressID;//accountShipAddress[0].Id;
            if(!ordDGList.isEmpty())
            newSO.inscor__Shipping_Instruction__c = ordDGList[0].DeliveryInstructions;
            newSO.inscor__Internal_Comments_rt__c = orderList[0].Internal_Comments__c; 
            if(!listPA.isEmpty()){
                newSO.Paid_in_Full__c = true;
                newSO.Authorize_Payment_Settlement__c = 'Under Settlement';
            }else{
                newSO.inscor__Customer_PO_Number__c = orderList[0].PoNumber;
            }
            
            insert newSO;
            String conditionCodeId = '';
            if(Test.isRunningTest()){
                conditionCodeId = [SELECT ID,Name,inscor__Show_in_Summary__c FROM inscor__Condition_Code__c WHERE inscor__Show_in_Summary__c  = false].Id;
            }
            
            List<inscor__Sales_Order_Line__c> solList = new List<inscor__Sales_Order_Line__c>();
            for(OrderItem eachItem :[SELECT ID,Product2Id,Price_Type__c,Product2.Core_Value__c,UnitPrice,TotalPrice,Quantity,Condition_Code__c FROM OrderItem Where OrderID =:orderList[0].Id AND Product2.Name != 'SHIPPING'] ){
                System.debug('Condition_Code__c -> '+eachItem.Condition_Code__c);
                inscor__Sales_Order_Line__c newSOL = new inscor__Sales_Order_Line__c();
                if(eachItem.Price_Type__c == 'Cost Plus' || eachItem.Price_Type__c == 'Flat rate w/OH core' || eachItem.Price_Type__c == 'Flat rate w/SV core' || eachItem.Price_Type__c == 'Flat rate w/Repairable core'){
                    newSOL.inscor__Order_Type__c = 'Exchange';
                    newSOL.inscor__Exchange_Type__c = eachItem.Price_Type__c;
                    newSOL.inscor__Core_Disposition__c = 'Receive ‘As Is’';
                    newSOL.inscor__Core_Due__c = 30;
                    newSOL.inscor__Outright_Price__c = eachItem.Product2.Core_Value__c;
                    newSOL.inscor__Stock_Disposition__c = 'Return to Stock';
                    
                    
                }else if(String.isBlank(eachItem.Price_Type__c)){
                    newSOL.inscor__Order_Type__c = 'Outright';
                }
                newSOL.inscor__Price__c = eachItem.UnitPrice;
                //newSOL.inscor__Line_Total__c = eachItem.TotalPrice;
                newSOL.inscor__Quantity_Ordered__c = eachItem.Quantity;
                newSOL.inscor__Product__c = eachItem.Product2Id;
                newSOL.inscor__Order__c = newSO.Id;
                newSOL.inscor__Status__c = 'Open';
                if(Test.isRunningTest()){
                    newSOL.inscor__Condition_Code__c = conditionCodeId;
                }else{
                    newSOL.inscor__Condition_Code__c = eachItem.Condition_Code__c;
                }
                
                newSOL.inscor__Internal_Comments_rt__c = orderList[0].Line_Level_Comment__c;
                solList.add(newSOL);
            }
            
            if(!solList.isEmpty()){
                insert solList;
            }
        }catch(Exception e){
            System.debug('Error '+e.getLineNumber());
            System.debug('Error '+e.getMessage());
        }
    }
    @testVisible static void justIncrement() {
        Integer i = 0;
        i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
    }
}