@isTest(SeeAllData=true)
public class B2BCartControllerSampleTest {
    public Static String userId;
    public Static String accountId;
    public Static String communityId;
    public Static String cartId;
    public Static String cartItemId;
    
	private static String getCommunityId(){
        Id p = [select id from profile where name='Customer Community Plus Login User'].id;
        List<User> user = [SELECT Id, Name,ContactID FROM User WHERE ProfileId = :p AND ContactID!=null];
        Contact Obj =new Contact();
        obj = [SELECT ID,AccountId FROM Contact WHERE ID=:user[0].ContactID];
        accountId = obj.AccountId;
		userId = user[0].Id;
        
        List<NetworkMember> membership = [SELECT NetworkID, MemberID FROM NetworkMember WHERE memberID = :user[0].id];
        
        Product2 prod = new Product2();
        prod.Name='#10';
        prod.StockKeepingUnit='10';
        prod.inscor__Keyword__c='10';
        insert prod;
        
        /*inscor__Condition_Code__c code = new inscor__Condition_Code__c();
        code.Name='NE';
        code.inscor__Show_in_Summary__c=false;
        insert code;*/
        
        // Create Web Store
        WebStore newWebStore = new WebStore();
        newWebStore.Name = 'Seattle Store'+math.random();
        //newWebStore.StrikethroughPricebookId=Test.getStandardPricebookId();
        newWebStore.PaginationSize=20;
        newWebStore.PricingStrategy='LowestPrice';
        newWebStore.MaxValuesPerFacet=100;
        insert newWebStore;
        
        // Create Web cart
        WebCart newWebCart = new WebCart();
        newWebCart.WebStoreId = newWebStore.Id; //'0ZE6s0000000085GAA';
        newWebCart.AccountId = accountId;
        newWebCart.Status = 'Active';
        newWebCart.Type = 'Cart';
        newWebCart.Name = 'Cart';
        newWebCart.OwnerId=userId;
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
        
        
        return membership[0].NetworkID;
    }
    
    private static String getCartItemId(){
        String cartItemId = [select Id,Product2Id,CartId from CartItem where CartId = :cartId].Id;
        return cartItemId;
    }
    
    private static String getProduct(){
        return [select Id from Product2 limit 1].Id;
    }
    
    @isTest
    public static void testCreateCart(){
        communityId = getCommunityId();
        Test.startTest();
        	ConnectApi.CartSummary cartSummary = B2BCartControllerSample.createCart(communityId,accountId);
        	/*WebCart cart = new WebCart();
        	cart = [SELECT ID, Status FROM WebCart WHERE ID =:cartSummary.cartId];
        	cart.Status = 'Active';
        	update cart;*/
        	
        Test.stopTest();
    }

	@isTest
    public static void testGetCartItems(){
        communityId = getCommunityId();
        Test.startTest();
        	B2BCartControllerSample.getCartItems(communityId,accountId,cartId,'20','');
        Test.stopTest();
    }
    
    @isTest
    public static void testUpdateCartItem(){
        communityId = getCommunityId();
        //cartItemId = getCartItemId();
        
        ConnectAPI.CartItemInput cartItemInput = new ConnectAPI.CartItemInput();
        cartItemInput.productId = getProduct();
        cartItemInput.quantity = String.valueOf(math.random());
        
        Test.startTest();
        	//B2BCartControllerSample.updateCartItem(communityId,accountId,cartId,cartItemId,cartItemInput);
        Test.stopTest();
    }
    
    @isTest
    public static void testGetCartSummary(){
        communityId = getCommunityId();
        Test.startTest();
        	B2BCartControllerSample.getCartSummary(communityId,accountId,cartId);
        Test.stopTest();
    }
    
    @isTest
    public static void testDeleteCartItem(){
        communityId = getCommunityId();
        
        Test.startTest();
        	B2BCartControllerSample.deleteCartItem(communityId,accountId,cartId,cartItemId);
        Test.stopTest();
    }
    
    @isTest
    public static void testDeleteCart(){
        communityId = getCommunityId();
        Test.startTest();
        	B2BCartControllerSample.deleteCart(communityId,accountId,cartId);
        Test.stopTest();
    }
    
    @isTest
    public static void testIncrement(){
        B2BCartControllerSample.justIncrement();
    }
}