@isTest(SeeAllData=true)
public class Internal_Comment_Test_Class {
    public Static String userId;
    public Static String accountId;
    // public Static String getcartId = '0a66s00000001dxAAA';
    public Static String getcartId;
    public Static String cartId;
    // public Static String cartItemId;
    public Static String comment = 'order level comment';
    public Static String commentlinelevel = 'line level comment';
    	
    
    private static String getCartId(){
          Id p = [select id from profile where name='Customer Community Plus Login User'].id;
        List<User> user = [SELECT Id, Name,ContactID FROM User WHERE ProfileId = :p AND ContactID!=null limit 1];
        Contact Obj =new Contact();
        obj = [SELECT ID,AccountId FROM Contact WHERE ID=:user[0].ContactID];
        accountId = obj.AccountId;
		userId = user[0].Id;
        
        /*Product2 prod = new Product2();
        prod.Name='#10';
        prod.StockKeepingUnit='10';
        prod.inscor__Keyword__c='10';
        insert prod;*/
        
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
        newWebCart.WebStoreId = newWebStore.Id; //'0a66s00000001cQAAQ';
        newWebCart.AccountId = accountId;
        newWebCart.Status = 'Active';
        newWebCart.Type = 'Cart';
        newWebCart.Name = 'Cart';
        newWebCart.OwnerId=userId;
        insert newWebCart;
        cartId = newWebCart.Id;
        
        return cartId;
    }
    	
    	
             
        // Perform the test 1 for insert line and order level comment
		@isTest
    	public static void testinsertCartlevelcomments(){
        getcartId = getCartId();
		system.debug('CartId: '+getcartId);
        Test.startTest();
        	InterncalcommentController.Internalcomments(getcartId, comment, commentlinelevel);
        Test.stopTest();
    	}
    
     	// Perform the test 2 for insert hide the internal comment
     	 @isTest
    	public static void testhideInternalcomments(){
        getcartId = getCartId();
        system.debug('CartId: '+getcartId);
        Test.startTest();
        	InterncalcommentController.internalcartitems(getcartId);
        Test.stopTest();
    	}

        
     
}