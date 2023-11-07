public without sharing class B2BGetInfo{
    @AuraEnabled(cacheable=true)
    public static ConnectApi.ProductDetail getProduct(
        String communityId,
        String productId,
        String effectiveAccountId
    ) {
        // Lookup the webstore ID associated with the community
        String webstoreId = B2BUtils.resolveCommunityIdToWebstoreId(communityId);
        
        // https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_ConnectAPI_CommerceCatalog_static_methods.htm#apex_ConnectAPI_CommerceCatalog_static_methods
    if(!Test.isRunningTest()){
      return ConnectApi.CommerceCatalog.getProduct(webstoreId,productId,effectiveAccountID,null,false,null,false,true,false);
    }else{
      return null;
    }
    }
    
       
    
    
    // @AuraEnabled(cacheable=true)
    // public static Boolean checkProductIsInStock(String productId) {
        
    //     /*
    // * The following is an example of calling an external API.
    // * The example API provided is extremely simple: It takes in a product id
    // * and returns a true or false value for inStock based on whether the 15th char is odd or even.
    // *
    // * To access this endpoint on your org, go to Remote Site Settings in Setup as an admin user
    // * click "New Remote Site" and provide "https://inventorymanagerdemo.herokuapp.com" for the "Remote Site URL" field
    // */
    //     Http http = new Http();
    //     HttpRequest request = new HttpRequest();
    //     String endpoint =
    //         'https://inventorymanagerdemo.herokuapp.com/api/inventory/' + productId;
    //     request.setEndpoint(endpoint);
    //     request.setMethod('GET');
    //     HttpResponse response = http.send(request);
    //     // If the request is successful, parse the JSON response.
    //     if (response.getStatusCode() == 200) {
    //         // Deserialize the JSON string into collections of primitive data types.
    //         Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(
    //             response.getBody()
    //         );
    //         return (boolean) results.get('inStock');
    //     } else {
    //         return false;
    //     }
    // }
    

    // @AuraEnabled(cacheable=true)
    // public static Map<String,inscor__Inventory_Line__c> getProductInventories(String communityId,String productId, String effectiveAccountId){
    //     Map<String,inscor__Inventory_Line__c> ConditionCodeAndInventoryMap = new Map<String,inscor__Inventory_Line__c>();
    //     Map<String,InventoryPriceWrapper> ConditionCodeAndInventoryMapNew = new Map<String,InventoryPriceWrapper>();

    //     try {
    //         Set<String> conditionCodeSet = new Set<String>();
    //         for(inscor__Inventory_Line__c eachINV : [SELECT Id, name,inscor__Condition_Code__c,inscor__Quantity_Available__c,inscor__Condition_Code__r.Name,inscor__Price__c,inscor__Quantity__c
    //                                                  FROM inscor__Inventory_Line__c 
    //                                                  WHERE inscor__product__c=:productId
    //                                                  //WITH SECURITY_ENFORCED 
    //                                                  Order By CreatedDate   ]){
    //                                                      if(!ConditionCodeAndInventoryMap.containsKey(eachINV.inscor__Condition_Code__r.Name)){
    //                                                          ConditionCodeAndInventoryMap.put(eachINV.inscor__Condition_Code__r.Name,eachINV);                                     
    //                                                      }
    //                                                      conditionCodeSet.add(eachINV.inscor__Condition_Code__c);
    //                                                  }
            
    //     } catch (Exception e) {
    //         throw new AuraHandledException(e.getMessage());
    //     }
        
    //     return ConditionCodeAndInventoryMap;
        
    // }
    
    @AuraEnabled(cacheable=true)
    public static Map<String,InventoryPriceWrapper> getProductInventories(String communityId,String productId, String effectiveAccountId){
        Map<String,inscor__Inventory_Line__c> ConditionCodeAndInventoryMap = new Map<String,inscor__Inventory_Line__c>();
        Map<String,Decimal> ConditionCodeAndAvailableQtyCountMap = new Map<String,Decimal>();
        Map<String,InventoryPriceWrapper> ConditionCodeAndInventoryMapNew = new Map<String,InventoryPriceWrapper>();
        Map<String,inscor__Inventory_Line__c> ConditionCodeAndInventoryMapTemp = new Map<String,inscor__Inventory_Line__c>();


        try {   
            Set<String> conditionCodeSet = new Set<String>();
            Set<String> conditionCodeSetTmp = new Set<String>();
			
			List<inscor__Inventory_Line__c> inventoryList = new List<inscor__Inventory_Line__c>([SELECT Id, name,inscor__Condition_Code__c,inscor__Quantity_Available__c,inscor__Condition_Code__r.Name,inscor__Price__c,inscor__Quantity__c
                                                     FROM inscor__Inventory_Line__c 
                                                     WHERE inscor__product__c=:productId
                                                     //WITH SECURITY_ENFORCED 
                                                     //Order By CreatedDate DESC, LastModifiedDate DESC
                                                     ORDER BY CreatedDate DESC, inscor__Quantity_Available__c DESC
                                                     ]);
			if(!inventoryList.isEmpty()){

				for(inscor__Inventory_Line__c eachINV : inventoryList){
					if(!ConditionCodeAndInventoryMap.containsKey(eachINV.inscor__Condition_Code__r.Name)){
						 ConditionCodeAndInventoryMap.put(eachINV.inscor__Condition_Code__r.Name,eachINV);
						 System.debug('eachINV.inscor__Condition_Code__r.Name -> '+eachINV.inscor__Condition_Code__r.Name); 
						conditionCodeSet.add(eachINV.inscor__Condition_Code__c); 
					}
					if(!ConditionCodeAndInventoryMapTemp.containsKey(eachINV.inscor__Condition_Code__r.Name)){
						ConditionCodeAndInventoryMapTemp.put(eachINV.inscor__Condition_Code__r.Name,eachINV);                                     
					}
					if(eachINV.inscor__Quantity_Available__c>0){
						if(ConditionCodeAndAvailableQtyCountMap.containsKey(eachINV.inscor__Condition_Code__r.Name)){
							Decimal availableQtyCounter = ConditionCodeAndAvailableQtyCountMap.get(eachINV.inscor__Condition_Code__r.Name);
							availableQtyCounter += eachINV.inscor__Quantity_Available__c;
							ConditionCodeAndAvailableQtyCountMap.put(eachINV.inscor__Condition_Code__r.Name,availableQtyCounter);
						}else{
							ConditionCodeAndAvailableQtyCountMap.put(eachINV.inscor__Condition_Code__r.Name,eachINV.inscor__Quantity_Available__c);
						}
					}
					//conditionCodeSet.add(eachINV.inscor__Condition_Code__c);
				}
														 
				System.debug('ConditionCodeAndInventoryMap -> '+ConditionCodeAndInventoryMap);

				for(inscor__Price__c eachPrice : [SELECT Id, name,inscor__Condition_Code__c,inscor__Condition_Code__r.Name,inscor__Price_Type__c,inscor__Price__c FROM inscor__Price__c 
						WHERE inscor__Condition_Code__c In:conditionCodeSet
						AND inscor__Part_Master__c =:productId
						Order By CreatedDate DESC]){//WITH SECURITY_ENFORCED

					if(ConditionCodeAndInventoryMapTemp.containsKey(eachPrice.inscor__Condition_Code__r.Name)){
						ConditionCodeAndInventoryMapTemp.remove(eachPrice.inscor__Condition_Code__r.Name);                                     
					} 

					if(!conditionCodeSetTmp.contains(eachPrice.inscor__Condition_Code__r.Name+' - Outright') && (string.isEmpty(eachPrice.inscor__Price_Type__c)  || eachPrice.inscor__Price_Type__c =='List' || eachPrice.inscor__Price_Type__c =='Suggested')){
						
							ConditionCodeAndInventoryMapNew.put(
							eachPrice.inscor__Condition_Code__r.Name+' - Outright', new B2BGetInfo.InventoryPriceWrapper(
							ConditionCodeAndInventoryMap.get(eachPrice.inscor__Condition_Code__r.Name).inscor__Quantity__c,
							ConditionCodeAndAvailableQtyCountMap.get(eachPrice.inscor__Condition_Code__r.Name),
							eachPrice.inscor__Price_Type__c,
							eachPrice.inscor__Price__c,
							eachPrice.inscor__Condition_Code__c,
							eachPrice.inscor__Condition_Code__r.Name)); 
							conditionCodeSetTmp.add(eachPrice.inscor__Condition_Code__r.Name+' - Outright');  

					}else if(eachPrice.inscor__Price_Type__c=='Cost Plus'){

							ConditionCodeAndInventoryMapNew.put(
							eachPrice.inscor__Condition_Code__r.Name+' - Cost Plus', new B2BGetInfo.InventoryPriceWrapper(
							ConditionCodeAndInventoryMap.get(eachPrice.inscor__Condition_Code__r.Name).inscor__Quantity__c,
							ConditionCodeAndAvailableQtyCountMap.get(eachPrice.inscor__Condition_Code__r.Name),
							eachPrice.inscor__Price_Type__c,
							eachPrice.inscor__Price__c,
							eachPrice.inscor__Condition_Code__c,
							eachPrice.inscor__Condition_Code__r.Name)); 
							conditionCodeSetTmp.add(eachPrice.inscor__Condition_Code__r.Name+' - Cost Plus');

					}else if(eachPrice.inscor__Price_Type__c=='Flat Rate w/OH Core'){

							ConditionCodeAndInventoryMapNew.put(
							eachPrice.inscor__Condition_Code__r.Name+' - Flat Rate w/OH Core', new B2BGetInfo.InventoryPriceWrapper(
							ConditionCodeAndInventoryMap.get(eachPrice.inscor__Condition_Code__r.Name).inscor__Quantity__c,
							ConditionCodeAndAvailableQtyCountMap.get(eachPrice.inscor__Condition_Code__r.Name),
							eachPrice.inscor__Price_Type__c,
							eachPrice.inscor__Price__c,
							eachPrice.inscor__Condition_Code__c,
							eachPrice.inscor__Condition_Code__r.Name)); 
							conditionCodeSetTmp.add(eachPrice.inscor__Condition_Code__r.Name+' - Flat Rate w/OH Core');

					}else if(eachPrice.inscor__Price_Type__c=='Flat Rate w/SV Core'){

							ConditionCodeAndInventoryMapNew.put(
							eachPrice.inscor__Condition_Code__r.Name+' - Flat Rate w/SV Core', new B2BGetInfo.InventoryPriceWrapper(
							ConditionCodeAndInventoryMap.get(eachPrice.inscor__Condition_Code__r.Name).inscor__Quantity__c,
							ConditionCodeAndAvailableQtyCountMap.get(eachPrice.inscor__Condition_Code__r.Name),
							eachPrice.inscor__Price_Type__c,
							eachPrice.inscor__Price__c,
							eachPrice.inscor__Condition_Code__c,
							eachPrice.inscor__Condition_Code__r.Name)); 
							conditionCodeSetTmp.add(eachPrice.inscor__Condition_Code__r.Name+' - Flat Rate w/SV Core');  

					}else if(eachPrice.inscor__Price_Type__c=='Flat Rate w/Repairable Core'){
						
							ConditionCodeAndInventoryMapNew.put(
							eachPrice.inscor__Condition_Code__r.Name+' - Flat Rate w/Repairable Core', new B2BGetInfo.InventoryPriceWrapper(
							ConditionCodeAndInventoryMap.get(eachPrice.inscor__Condition_Code__r.Name).inscor__Quantity__c,
							ConditionCodeAndAvailableQtyCountMap.get(eachPrice.inscor__Condition_Code__r.Name),
							eachPrice.inscor__Price_Type__c,
							eachPrice.inscor__Price__c,
							eachPrice.inscor__Condition_Code__c,
							eachPrice.inscor__Condition_Code__r.Name)); 
							conditionCodeSetTmp.add(eachPrice.inscor__Condition_Code__r.Name+' - Flat Rate w/Repairable Core'); 

					}
				}
				
				System.debug('ConditionCodeAndInventoryMapTemp -> '+ConditionCodeAndInventoryMapTemp);
				for(String eachCC:ConditionCodeAndInventoryMapTemp.keyset()){
					ConditionCodeAndInventoryMapNew.put(
					eachCC+' - Outright', new B2BGetInfo.InventoryPriceWrapper(
					0,
					0,
					'',
					0,
					ConditionCodeAndInventoryMapTemp.get(eachCC).inscor__Condition_Code__c,
					eachCC)); 
				}
			}else{
				
				List<inscor__Condition_Code__c> conditionCodeList = new List<inscor__Condition_Code__c>([SELECT ID FROM inscor__Condition_Code__c WHERE Name = 'NE' LIMIT 1]);
				
				ConditionCodeAndInventoryMap.put('NE',new inscor__Inventory_Line__c());
				ConditionCodeAndInventoryMapNew.put(
							'NE - Outright', new B2BGetInfo.InventoryPriceWrapper(
							1,
							1,
							'List',
							0,
							conditionCodeList[0].Id,
							'NE')); 
							//conditionCodeSetTmp.add(eachPrice.inscor__Condition_Code__r.Name+' - Outright');
			}
			


        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        
        return ConditionCodeAndInventoryMapNew;
        
    }

    public class InventoryPriceWrapper{
        @AuraEnabled
        public  Decimal quantity{get;set;}
        @AuraEnabled
        public  Decimal availableQty{get;set;}
        @AuraEnabled
        public  String  priceType{get;set;}
        @AuraEnabled
        public Decimal price{get;set;}
        @AuraEnabled
        public Id  conditionCodeId{get;set;}
        @AuraEnabled
        public String  conditionCodeLabel{get;set;}
        
        public InventoryPriceWrapper(Decimal quantity,Decimal availableQty,String priceType,Decimal price,Id conditionCodeId,String conditionCodeLabel){
            this.quantity = quantity;
            this.availableQty = availableQty;
            this.priceType = priceType;
            this.price = price;
            this.conditionCodeId = conditionCodeId;
            this.conditionCodeLabel = conditionCodeLabel;
        }
    }
    
    /*@AuraEnabled(cacheable=true)
    public static Map<String,inscor__Price__c> getPriceBasedOnConditionCode(String conditionCodeId,String productId ){
        Map<String,inscor__Price__c> conditionCodeAndPriceMap = new Map<String,inscor__Price__c>();
        try{
            for(inscor__Price__c eachPrice : [SELECT Id, name,inscor__Condition_Code__c,inscor__Condition_Code__r.Name,inscor__Price_Type__c,inscor__Price__c
                                                     FROM inscor__Price__c 
                                                     WHERE inscor__Condition_Code__c=:conditionCodeId
                                                   AND inscor__Part_Master__c =:productId
                                                     WITH SECURITY_ENFORCED Order By CreatedDate DESC LIMIT 1]){
               if(!conditionCodeAndPriceMap.containsKey(eachPrice.inscor__Condition_Code__r.Name)){
                   conditionCodeAndPriceMap.put(eachPrice.inscor__Condition_Code__r.Name,eachPrice);                                     
                }
            }
        }catch(Exception e){
            
        }
        return conditionCodeAndPriceMap;
    }*/

    // @AuraEnabled(cacheable=true)
    // public static List<inscor__Price__c> getPriceBasedOnConditionCode(String conditionCodeId,String productId ){
    //     List<inscor__Price__c> conditionCodeAndPriceList = new List<inscor__Price__c>();
    //     try{
    //         conditionCodeAndPriceList =[SELECT Id, name,inscor__Condition_Code__c,inscor__Condition_Code__r.Name,inscor__Price_Type__c,inscor__Price__c
    //                                                  FROM inscor__Price__c 
    //                                                  WHERE inscor__Condition_Code__c=:conditionCodeId
    //                                                AND inscor__Part_Master__c =:productId
    //                                                  WITH SECURITY_ENFORCED Order By CreatedDate DESC];
    //     }catch(Exception e){
            
    //     }
    //     return conditionCodeAndPriceList;
    // }


    @AuraEnabled
    public static List<CartItem> checkProductAddedIntoCart(String cartId){
        List<CartItem> arrExistingCartItems = new List<CartItem>();
        try{
            arrExistingCartItems = [SELECT ID,Condition_Code__r.Name,Condition_Code_Price_Type__c,Product2Id,SalesPrice,Name,Sku,TotalPrice,Quantity,TotalLineAmount,UnitAdjustedPrice FROM CartItem WHERE CartId =: cartId];
        }catch(Exception e){
        }
        return arrExistingCartItems;
    }

    @AuraEnabled
    public static CartItem checkProductAddedIntoCartOrNot(String productId,String cartId){
        CartItem arrExistingCartItem = new CartItem();
        //List<CartItem> arrExistingCartItem = new List<CartItem>();
        try{
            arrExistingCartItem = [SELECT ID,Condition_Code__r.Name,Product2Id,Condition_Code_Price_Type__c,SalesPrice,Name,Sku,TotalPrice,Quantity,TotalLineAmount,UnitAdjustedPrice FROM CartItem WHERE product2Id=:productId and CartId =: cartId];
            /*if(!arrExistingCartItem.isEmpty()){
                return arrExistingCartItem[0];
            }else{
                return null;
            }*/
        }catch(Exception e){
            System.debug('Error Message -> '+e.getMessage());
            System.debug('Error Message -> '+e.getLineNumber());
            //return null;
        }
        return arrExistingCartItem;
    }


    @AuraEnabled
    public static void changeCartStatusToActive(String cartId){
        WebCart arrExistingCart = new WebCart();
        try{
            arrExistingCart = [SELECT ID,Status FROM WebCart WHERE Id =: cartId];
            arrExistingCart.Status='Active';
            update arrExistingCart;
        }catch(Exception e){
        }
    }
    
        
    @AuraEnabled
    public static ConnectApi.CartSummary getCartSummary(
        String communityId,
        String effectiveAccountId
    ) {
        // Lookup the webstore ID associated with the community
        String webstoreId = B2BUtils.resolveCommunityIdToWebstoreId(communityId);
        
        //'current' is available in version 50.0 and later and indicates a cart with a status that isn’t Closed or PendingDelete
        //This is important for the product detail page since we are using the cart summary to check if the status is "Processing" or "Checkout"
        String activeCartOrId = 'current';
        
        // https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_ConnectAPI_CommerceCart_static_methods.htm
        
    
    if(!Test.isRunningTest()){
      return ConnectApi.CommerceCart.getCartSummary(webstoreId,effectiveAccountId,activeCartOrId);
    }else{
      return null;
    }
    }
        
    @AuraEnabled
    public static CartItem addToCart(
        String communityId,
        String productId,
        String quantity,
        String effectiveAccountId,
        String conditionCodelabel,
        Double productPrice,
        String conditionCodeId,
        String productPriceType,
        String conditionCodePriceType

    ) { //ConnectApi.CartItem
        
        // Lookup the webstore ID associated with the community
        String webstoreId = B2BUtils.resolveCommunityIdToWebstoreId(communityId);
        
        ConnectApi.CartItemInput cartInput = new ConnectApi.CartItemInput();
        cartInput.productId = productId;
        cartInput.quantity = quantity;
        cartInput.type = ConnectApi.CartItemType.PRODUCT;

        /*ConnectApi.CartItem cartItem = ConnectApi.CommerceCart.addItemToCart(  
            webstoreId,
            effectiveAccountId,
            'active',
            cartInput
        );
        
        // https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_ConnectAPI_CommerceCart_static_methods.htm#apex_ConnectAPI_CommerceCart_static_methods
        /*return ConnectApi.CommerceCart.addItemToCart(  
            webstoreId,
            effectiveAccountId,
            'active',
            cartInput
        );*/
        ConnectApi.CartItem cartItem = ConnectApi.CommerceCart.addItemToCart(  
            webstoreId,
            effectiveAccountId,
            'active',
            cartInput
        );
        CartItem existingCartItem = new CartItem();
        existingCartItem = [SELECT ID,SalesPrice,Name,Sku,TotalPrice,Quantity,TotalLineAmount,UnitAdjustedPrice FROM CartItem WHERE Id =: cartItem.cartItemId];
        existingCartItem.SalesPrice = productPrice;
        existingCartItem.TotalPrice = productPrice * existingCartItem.Quantity;
        existingCartItem.TotalLineAmount = productPrice * existingCartItem.Quantity;
        existingCartItem.UnitAdjustedPrice = productPrice;
        existingCartItem.Condition_Code__c = conditionCodeId;
        existingCartItem.Price_Type__c = productPriceType;
        existingCartItem.Condition_Code_Price_Type__c=conditionCodelabel;
        update existingCartItem;
        return existingCartItem;            
    }
        
    @AuraEnabled
    public static ConnectApi.Wishlist createAndAddToList(
        String communityId,
        String productId,
        String wishlistName,
        String effectiveAccountId
    ) {
        // Lookup the webstore ID associated with the community
        String webstoreId = B2BUtils.resolveCommunityIdToWebstoreId(communityId);
        
        // Store the product in a WishlistItemInput to pass to the Wishlist
        ConnectApi.WishlistItemInput wishlistItemInput = new ConnectApi.WishlistItemInput();
        wishlistItemInput.productId = productId;
        
        //Create a wishlistInput to be created
        ConnectApi.WishlistInput wishlistInput = new ConnectApi.WishlistInput();
        wishlistInput.name = wishlistName;
        wishlistInput.products = new List<ConnectApi.WishlistItemInput>{
            wishlistItemInput
                };
                    
                    // https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_ConnectAPI_CommerceWishlist_static_methods.htm#apex_ConnectAPI_CommerceWishlist_static_methods
                    
    if(!Test.isRunningTest()){
      return ConnectApi.CommerceWishlist.createWishlist(webstoreId,effectiveAccountId,wishlistInput);
    }else{
      return null;
    }
    }
        
    @AuraEnabled(cacheable=true)
    public static ConnectApi.ProductPrice getProductPrice(
        String communityId,
        String productId,
        String effectiveAccountId
    ) {
        // Lookup the webstore ID associated with the community
        String webstoreId = B2BUtils.resolveCommunityIdToWebstoreId(communityId);
        
        // https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_ConnectAPI_CommerceStorePricing_static_methods.htm#apex_ConnectAPI_CommerceStorePricing_static_methods
        
    
    if(!Test.isRunningTest()){
      return ConnectApi.CommerceStorePricing.getProductPrice(webstoreId,productId,effectiveAccountId);
    }else{
      return null;
    }
    }
}