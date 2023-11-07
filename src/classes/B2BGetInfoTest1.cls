@isTest
public class B2BGetInfoTest1 {    
    public Static String userId; // declare userId
    public Static String accountId; // declare accountId
    public Static String cartId; // declare cartId
    public Static String conditioncodeId; // declare conditioncodeId
    public Static String productId; // declare productId
    
    // get coummunityId/NetworkId 
    private static String getCommunityId(){
        Id p = [select id from profile where name='Customer Community Plus Login User'].id;
        List<User> user = [SELECT Id, Name,ContactID FROM User WHERE ProfileId = :p];
        
		userId = user[0].Id;
        List<NetworkMember> membership = [SELECT NetworkID, MemberID FROM NetworkMember WHERE memberID = :user[0].id];
        return membership[0].NetworkID;
    }
    
    private static ID createStoreAndActiveCart(){
        
        Id p = [select id from profile where name='Customer Community Plus Login User' ].id;
        Account ac = new Account(name ='Grazitti') ;
        insert ac; 
       
        Contact con = new Contact(LastName ='testCon',BillNPay__LP_Payment_Request_Method__c ='Email',Email='mlum@cloudstreet.com',AccountId = ac.id);
        insert con; 
        
        /*User user = new User(alias = 'test123', email='test123@noemail.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = p, country='United States',IsActive =true,
                ContactId = con.Id,
                timezonesidkey='America/Los_Angeles', username='tester@noemail.com');
       
        insert user;*/
        List<User> user = [SELECT Id, Name,ContactID FROM User WHERE ProfileId = :p];
        system.debug('user'+user);
        List<NetworkMember> membership = [SELECT NetworkID, MemberID FROM NetworkMember WHERE memberID = :user[0].id ];
        //communityId = membership[0].NetworkID;
        //
        //Pricebook2 standardPricebook = new Pricebook2(Id = Test.getStandardPricebookId(),IsActive = true);
        //Update standardPricebook;
        
        // Create Web Store
        WebStore newWebStore = new WebStore();
        newWebStore.Name = 'Seattle Store'+math.random();
        //newWebStore.StrikethroughPricebookId=standardPricebook.ID;
        newWebStore.PaginationSize=20;
        newWebStore.PricingStrategy='LowestPrice';
        newWebStore.MaxValuesPerFacet=100;
        insert newWebStore;
        system.debug('WebStore: '+newWebStore);
       
        // Create Web cart
        WebCart newWebCart = new WebCart();
        newWebCart.WebStoreId = newWebStore.Id; //'0ZE6s0000000085GAA';
        newWebCart.AccountId = ac.id;
        newWebCart.Status = 'Active';
        newWebCart.Type = 'Cart';
        newWebCart.Name = 'Cart';
        newWebCart.OwnerId=userId;
        insert newWebCart;
        
        return newWebCart.ID;
    }
	
    @isTest
    public static void testGetProductInventories(){
        String communityId = getCommunityId();
        Product2 pr = new Product2(Name ='#162',inscor__Keyword__c = 'SCREW2',inscor__UOM__c='EA');
        insert pr;
        
        inscor__Company__c  company = new inscor__Company__c(
            inscor__Address_1__c = '1111', inscor__City__c = '1111', inscor__Company_Name__c = '1111', inscor__Zip_Code__c = '1111');
        insert company;
        inscor__Company_Location__c companyLoc = new inscor__Company_Location__c( inscor__Company__c =company.Id );
        insert companyLoc;
        
        inscor__Inventory_Location__c invLocation  = new inscor__Inventory_Location__c(
            inscor__Company_Location__c = companyLoc.Id );
        insert invLocation;
        
        inscor__Owner_Code__c ownerCode = new inscor__Owner_Code__c(inscor__Company__c =company.Id);
        insert ownerCode;
        
        inscor__Warehouse__c warehouse = new inscor__Warehouse__c( 
            inscor__Company_Location__c = companyLoc.Id, inscor__Warehouse_Code__c ='1111' );
        insert warehouse;       
        
        inscor__Condition_Code__c conditionCode = new inscor__Condition_Code__c(Name ='NE', inscor__Show_in_Summary__c = false);
        insert conditionCode;
        inscor__Condition_Code__c conditionCode1 = new inscor__Condition_Code__c(Name ='AI', inscor__Show_in_Summary__c = false);
        insert conditionCode1;
        //
        //inscor__Condition_Code__c conditionCode = new inscor__Condition_Code__c();
        //conditionCode = [SELECT ID,Name FROM inscor__Condition_Code__c LIMIT 1 ];
        
        conditioncodeId = conditionCode.Id;
        System.debug('conditioncodeId -> '+conditioncodeId);
        //inscor__Inventory_Line__c invLine1 = new inscor__Inventory_Line__c();
        //invLine1 = [SELECT ID FROM inscor__Inventory_Line__c WHERE inscor__Condition_Code__c=: conditioncodeId];
        
        
        inscor__Inventory_Line__c invLine = new inscor__Inventory_Line__c(
            
            inscor__Condition_Code__c = conditionCode.Id , 
            inscor__Location__c  = invLocation.Id, 
            inscor__Owner_Code__c  = ownerCode.Id,
            inscor__Warehouse__c  = warehouse.Id,
            inscor__product__c = pr.Id
        );
        
        insert invLine;
        
        inscor__Inventory_Line__c invLine1 = new inscor__Inventory_Line__c(
            
            inscor__Condition_Code__c = conditionCode1.Id , 
            inscor__Location__c  = invLocation.Id, 
            inscor__Owner_Code__c  = ownerCode.Id,
            inscor__Warehouse__c  = warehouse.Id,
            inscor__product__c = pr.Id
        );
        
        insert invLine1;
        
        List<inscor__Price__c> priceList = new List<inscor__Price__c>();
		for(integer i=1; i<=5; i++)
            {	
                inscor__Price__c priceobj = new inscor__Price__c();
                priceobj.OwnerId= userId;
                priceobj.inscor__Condition_Code__c = conditioncodeId;
                priceobj.inscor__Part_Master__c = pr.Id;
                if(i==1){
                	priceobj.inscor__Price_Type__c = 'Cost Plus';
                }else if(i==2){
                	priceobj.inscor__Price_Type__c = 'Flat Rate w/OH Core';
                }else if(i==3){
                	priceobj.inscor__Price_Type__c = 'Flat Rate w/Repairable Core';
                }else if(i==4){
                	priceobj.inscor__Price_Type__c = 'Flat Rate w/SV Core';
                }else if(i==5){
                    priceobj.inscor__Price_Type__c ='';
                }
                
                priceList.add(priceobj);
            }
            insert priceList;
        
        
        //productId = pr.Id;
        Test.setMock(HttpCalloutMock.class, new ApnMockHttpResponseGenerator());
        Test.startTest();
        B2BGetInfo.getProductInventories(communityId,pr.Id,accountId);
        Test.stopTest();
    }
    
    @isTest
    public static void testCustomCode(){
        getCommunityId();
        Product2 pr = new Product2(Name ='#161',inscor__Keyword__c = 'SCREW1',inscor__UOM__c='EA');
        insert pr;
        ID cartID = createStoreAndActiveCart();
        Test.setMock(HttpCalloutMock.class, new ApnMockHttpResponseGenerator());
        Test.startTest();
        	B2BGetInfo.checkProductAddedIntoCart(cartID);
        	B2BGetInfo.checkProductAddedIntoCartOrNot(pr.Id,cartID);
        	B2BGetInfo.changeCartStatusToActive(cartID);
        Test.stopTest();
        
    }
    
    /*@isTest
    public static void testAddToCart(){
        String communityId = getCommunityId();
        String productId = productId;
        Test.startTest();
        	B2BGetInfo.addToCart(communityId,productId,'2',accountId,'NE',125,conditioncodeId,'Flat Rate w/OH Core','Flat Rate w/OH Core');
        Test.stopTest();
    }*/
    
	/*@isTest
    public static void testUpdateCartItem(){
        Id p = [select id from profile where name='Customer Community Plus Login User'].id;
        Account ac = new Account(name ='Grazitti') ;
        insert ac; 
       
        Contact con = new Contact(LastName ='testCon',AccountId = ac.id);
        insert con; 
        
        User user = new User(alias = 'test123', email='test123@noemail.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = p, country='United States',IsActive =true,
                ContactId = con.Id,
                timezonesidkey='America/Los_Angeles', username='tester@noemail.com');
       
        insert user;
        system.debug('user'+user);
        List<NetworkMember> membership = [SELECT NetworkID, MemberID FROM NetworkMember WHERE memberID = :user.id];
        Product2 prod = new Product2();
        prod.Name='#10';
        prod.StockKeepingUnit='10';
        prod.inscor__Keyword__c='10';
        insert prod;
        
        inscor__Condition_Code__c code = new inscor__Condition_Code__c();
        code.Name='NE';
        code.inscor__Show_in_Summary__c=false;
        insert code;
        
                // Create Web Store
        WebStore newWebStore = new WebStore();
        newWebStore.Name = 'Seattle Store'+math.random();
        newWebStore.StrikethroughPricebookId=Test.getStandardPricebookId();
        newWebStore.PaginationSize=20;
        newWebStore.PricingStrategy='LowestPrice';
        newWebStore.MaxValuesPerFacet=100;
        insert newWebStore;
        
        // Create Web cart
        WebCart newWebCart = new WebCart();
        newWebCart.WebStoreId = newWebStore.Id; //'0ZE6s0000000085GAA';
        newWebCart.AccountId = ac.id;
        newWebCart.Status = 'Active';
        newWebCart.Type = 'Cart';
        newWebCart.Name = 'Cart';
        newWebCart.OwnerId=user.Id;
        insert newWebCart;
        cartId = newWebCart.Id;
        
        CartDeliveryGroup cartDeliveryGp = new CartDeliveryGroup();
        cartDeliveryGp.CartId = newWebCart.Id;
        cartDeliveryGp.Name=membership[0].NetworkID;
        insert cartDeliveryGp;
        
         CartItem Citem = New CartItem();
        Citem.Product2Id = prod.id;
        Citem.Type = 'Product';
        Citem.Sku = prod.StockKeepingUnit;
        Citem.Name = prod.Name;
        Citem.CartDeliveryGroupId = cartDeliveryGp.Id;
        Citem.Quantity = 10;
        Citem.SalesPrice = 50;
        //Citem.Price_Type__c = PriceTypepartlist.get(singlePart);
        //Citem.Condition_Code__c = code.id;
        Citem.AdjustmentAmount = 0.00;
        Citem.TotalListPrice = 0.00;
        Citem.UnitAdjustmentAmount = 0.00;
        Citem.UnitAdjustedPrice = 50;
        Citem.TotalPrice = 50*10;
        Citem.TotalLineAmount = 50*10;
        Citem.CartId = newWebCart.Id;
        insert Citem;
        
        
        ConnectAPI.CartItemInput cartItemInput = new ConnectAPI.CartItemInput();
        cartItemInput.productId = prod.Id;
        cartItemInput.quantity = String.valueOf(math.random());
        
        Test.startTest();
        	B2BCartControllerSample.updateCartItem(membership[0].NetworkID,accountId,newWebCart.id,Citem.id,cartItemInput);
        Test.stopTest();
    } */   
    
    
}