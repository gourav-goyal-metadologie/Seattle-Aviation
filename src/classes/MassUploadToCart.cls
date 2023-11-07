public with sharing class MassUploadToCart {

	// CSV Partmaster File Upload to Cart.

	@AuraEnabled
	public static Boolean massUploadToCart (String base64Data, String NetworkId){
		
		string accountId; //= '0016s00000Dn3DtAAJ';
		//string communityId;
		//string NetworkId;
		string webStoreId;//= '0ZE6s0000000085GAA';
		String cartDeliveryGroupId; //= '0a76s00000000ODAAY';
		String CartId;
		String buyerGroupId;
		Decimal GrandTotal; 
		Boolean noErrorFile=true;
		system.debug('base64Data => '+base64Data);
		
		list<String> lstCSVLines = JSON.deserializeUntyped(base64Data).toString().split('\r\n');
		System.debug('csv lstCSVLines ====> '+lstCSVLines);

		Map<String, Integer> partNolist = new Map<String, Integer>();
		Map<String, String> Conditionlist = new Map<String, String>();
		
		
		if(lstCSVLines.size()>1) {
			list<string> headerList = lstCSVLines[0].split(',');
			System.debug('csv header size====> '+lstCSVLines[0]);
			System.debug('csv header Data====> '+headerList);
			headerList[2].trim();
			System.debug('csv headerList[2] Data====> '+headerList[2]);			
			if(headerList.size()!=3 || headerList[0]!='Part Number' || headerList[1] != 'Condition Code' || headerList[2] != 'Quantity'){
				noErrorFile = false;
			}

			if(noErrorFile == true) {
			for(Integer i = 1; i < lstCSVLines.size(); i++){

				String csvLine = lstCSVLines[i];
				String prevLine = csvLine;
				Integer startIndex;
				Integer endIndex;
				
				List<String> csvRowData = new List<String>();
				
				for(String column : csvLine.split(',')){
	
					column = column.replaceAll(':quotes:', '').replaceAll(':comma:', ',');
					column = column.trim();	
					csvRowData.add(column);	
				}
				partNolist.put(csvRowData[0].toLowerCase(),integer.ValueOf(csvRowData[2]));
				Conditionlist.put(csvRowData[0].toLowerCase(),csvRowData[1]);
				
			}
		}
		} else {
			noErrorFile = false;
		}
		System.debug('List Of Parts ====> '+partNolist);
		System.debug('List Of Condition Code ====> '+Conditionlist);

		// User Info...
		List<User> UserDetails = [SELECT Id,Name,ContactId,AccountId FROM User WHERE Id =:UserInfo.getUserId()];
		for (User useraccId : UserDetails) {
            accountId = useraccId.AccountId;
        }
		
		System.debug('NetworkId ====> '+NetworkId);

		// Web Store info...

		//ID webStoreId = [SELECT WebStoreId FROM WebStoreNetwork WHERE NetworkId =:NetworkId limit 1].WebStoreId;
		List<WebStoreNetwork> webStoreNetwork = new List<WebStoreNetwork>([SELECT WebStoreId FROM WebStoreNetwork WHERE NetworkId =:NetworkId limit 1]);
        System.debug('webStoreNetwork ====> '+webStoreNetwork);
		for (WebStoreNetwork Webstorerow : webStoreNetwork) {
            webStoreId = Webstorerow.WebStoreId;
        }
		System.debug('webStoreId ====> '+webStoreId);
		

		// Checking Cart Is exist or not if not Create a Cart with status "Active".

        List<WebCart> Cart_id =  [SELECT Id, TotalAmount, GrandTotalAmount FROM WebCart WHERE AccountId=:accountId and Status='Active' and OwnerId=:UserInfo.getUserId()];
		system.debug('Cart Details => '+Cart_id);        
        for (WebCart Cartlist : Cart_id) {
            CartId = Cartlist.Id;
        }
		if(CartId== null){
			WebCart newWebCart = new WebCart();
            newWebCart.WebStoreId = webStoreId;
            newWebCart.AccountId = accountId;
            newWebCart.Status = 'Active';
            newWebCart.Type = 'Cart';
            newWebCart.Name = 'Cart';
			//newWebCart.TotalAmount = 0.00;
            insert newWebCart;
			system.debug('New Cart Details => '+newWebCart);
			if(newWebCart.Id<>null){
				CartId = newWebCart.Id;
			}
		}

		

		List<CartItem> CartItemList = new List<CartItem>();
		List<CartItem> CartItemNewList = new List<CartItem>();
		List<String> ExistCartItemList = new List<String>();
		If(partNolist.size()>0 && CartId<> null && noErrorFile==true){
			
			// Cart Delivery Group Id
			List<CartDeliveryGroup> cartDeliveryGroup =  [SELECT Id, Name FROM CartDeliveryGroup WHERE CartId=:CartId];
			system.debug('Cart Details => '+cartDeliveryGroup);        
			for (CartDeliveryGroup deliverygrouplist : cartDeliveryGroup) {
				cartDeliveryGroupId = deliverygrouplist.Id;
			}
			
			// Checking mass List Product Exist in Partnumber Obj.

			Map<Id,Integer> existpartNolist = new Map<Id,Integer>();
			Map<Id,String> existConditionlist = new Map<Id,String>();
			Map<Id,String> existSKUlist = new Map<Id,String>();
			//set<ID> existPartNoIdSet = new Set<Id>();
			List<Product2> NewSortedPartlist = [SELECT Id,Name,StockKeepingUnit FROM Product2 WHERE Name IN : partNolist.KeySet()];
			system.debug('Partmaster NewSortedPartlist => '+NewSortedPartlist);
			for(Product2 currentRow : NewSortedPartlist){
				String prodname = currentRow.Name.toLowerCase();
				existpartNolist.put(currentRow.Id,partNolist.get(prodname));
				existSKUlist.put(currentRow.Id,currentRow.StockKeepingUnit);
				existConditionlist.put(currentRow.Id,Conditionlist.get(prodname));			
			}
			system.debug('existpartNolist data => '+existpartNolist);
			system.debug('existSKUlist data => '+existSKUlist);
			system.debug('existConditionlist data => '+existConditionlist);


			// Existing Product List Check Quantity>0 in Inventory Obj.

			Map<Id,Integer> InventrypartNolist = new Map<Id,Integer>();
			Map<Id,String> InventryConditionlist = new Map<Id,String>();
			Map<Id,String> InventrySKUlist = new Map<Id,String>();
			List<inscor__Inventory_Line__c> InventryPartlist = [
				SELECT Id,inscor__Condition_Code__c,inscor__Condition_Code__r.Name,inscor__product__c,inscor__Quantity__c
				FROM inscor__Inventory_Line__c 
				WHERE inscor__product__c IN :existConditionlist.KeySet()
				AND inscor__Condition_Code__r.Name IN :existConditionlist.values()
				AND inscor__Quantity__c>0 Order By CreatedDate DESC];

			system.debug('Partmaster InventryPartlist => '+InventryPartlist);

			for(inscor__Inventory_Line__c InventryRow : InventryPartlist){
				if(!InventryConditionlist.containsKey(InventryRow.inscor__product__c)){
					if(existConditionlist.containsKey(InventryRow.inscor__product__c) && existConditionlist.get(InventryRow.inscor__product__c)==InventryRow.inscor__Condition_Code__r.Name){
						InventryConditionlist.put(InventryRow.inscor__product__c,InventryRow.inscor__Condition_Code__r.Name);
						InventrypartNolist.put(InventryRow.inscor__product__c,existpartNolist.get(InventryRow.inscor__product__c));
						InventrySKUlist.put(InventryRow.inscor__product__c,existSKUlist.get(InventryRow.inscor__product__c));
					}
				}		
			}
			system.debug('InventrypartNolist data => '+InventrypartNolist);
			system.debug('InventryConditionlist data => '+InventryConditionlist);
			system.debug('InventrySKUlist data => '+InventrySKUlist);


			// get Price for Inventory part list from Price obj.

			Map<Id,Integer> PricepartNolist = new Map<Id,Integer>();
			Map<Id,String> PriceConditionlist = new Map<Id,String>();
			Map<Id,String> PriceConditionIDlist = new Map<Id,String>();
			Map<Id,String> PriceSKUlist = new Map<Id,String>();
			Map<Id,Decimal> Pricepartlist = new Map<Id,Decimal>();
			Map<Id,String> PriceTypepartlist = new Map<Id,String>();
			Map<Id,String> PricepartNamelist = new Map<Id,String>();
			List<String> PriceType = new List<String>{'Cost Plus', 'Flat Rate w/OH Core', 'Flat Rate w/SV Core','Flat Rate w/Repairable Core'};
			List<inscor__Price__c> PriceForPartlist = [
				SELECT Id,inscor__Condition_Code__c,inscor__Condition_Code__r.Name,inscor__Price__c,inscor__Part_Master__c,inscor__Part_Master__r.Name,inscor__Price_Type__c
                FROM inscor__Price__c 
                WHERE inscor__Condition_Code__r.Name IN :InventryConditionlist.values()
                AND inscor__Part_Master__c IN :InventryConditionlist.KeySet()
                Order By CreatedDate DESC];				

			system.debug('Partmaster PriceForPartlist => '+PriceForPartlist);

			for(inscor__Price__c PriceRow : PriceForPartlist){
				if(!PriceConditionlist.containsKey(PriceRow.inscor__Part_Master__c)){
					if(InventryConditionlist.containsKey(PriceRow.inscor__Part_Master__c) && InventryConditionlist.get(PriceRow.inscor__Part_Master__c)==PriceRow.inscor__Condition_Code__r.Name){
						if(!PriceType.contains(PriceRow.inscor__Price_Type__c)){
						PriceConditionlist.put(PriceRow.inscor__Part_Master__c,PriceRow.inscor__Condition_Code__r.Name);
						PriceConditionIDlist.put(PriceRow.inscor__Part_Master__c,PriceRow.inscor__Condition_Code__c);
						PricepartNolist.put(PriceRow.inscor__Part_Master__c,InventrypartNolist.get(PriceRow.inscor__Part_Master__c));
						Pricepartlist.put(PriceRow.inscor__Part_Master__c,PriceRow.inscor__Price__c);
						PriceSKUlist.put(PriceRow.inscor__Part_Master__c,InventrySKUlist.get(PriceRow.inscor__Part_Master__c));
						PricepartNamelist.put(PriceRow.inscor__Part_Master__c,PriceRow.inscor__Part_Master__r.Name);
						//if(PriceType.contains(PriceRow.inscor__Price_Type__c)){
							//PriceTypepartlist.put(PriceRow.inscor__Part_Master__c,PriceRow.inscor__Price_Type__c);
						//} else{
							PriceTypepartlist.put(PriceRow.inscor__Part_Master__c,null);
						}
					}
				}		
			}

			system.debug('PricepartNolist data => '+PricepartNolist);
			system.debug('PriceConditionlist data => '+PriceConditionlist);
			system.debug('PriceConditionIDlist data => '+PriceConditionIDlist);
			system.debug('PriceSKUlist data => '+PriceSKUlist);
			system.debug('Pricepartlist data => '+Pricepartlist);
			system.debug('PriceTypepartlist data => '+PriceTypepartlist);
			system.debug('PricepartNamelist data => '+PricepartNamelist);

			// Check Existing Cartitems and update cartitems.
			
			List<CartItem> CheckexistCartItem = [
				SELECT Id,Name,SalesPrice,Quantity,TotalPrice,TotalLineAmount,Price_Type__c, Condition_Code__c,Condition_Code__r.Name,Product2Id
				FROM CartItem 
				WHERE CartId =: CartId 
				AND Product2Id IN :PriceConditionlist.KeySet()
				AND Condition_Code__r.Name IN :PriceConditionlist.values()];

			system.debug('Check CartItem  => '+CheckexistCartItem);
			for(CartItem currentCI : CheckexistCartItem){
				if(PriceConditionlist.containsKey(currentCI.Product2Id) && PriceConditionlist.get(currentCI.Product2Id)==currentCI.Condition_Code__r.Name){
					currentCI.Quantity = currentCI.Quantity + PricepartNolist.get(currentCI.Product2Id);
					currentCI.TotalPrice = currentCI.TotalPrice + (PricepartNolist.get(currentCI.Product2Id)*currentCI.SalesPrice);				
					currentCI.TotalLineAmount = currentCI.TotalLineAmount + (PricepartNolist.get(currentCI.Product2Id)*currentCI.SalesPrice);
					//ExistCartItemList.add(currentCI.Name);
					
					PricepartNolist.remove(currentCI.Product2Id);
					PriceConditionlist.remove(currentCI.Product2Id);
					PriceConditionIDlist.remove(currentCI.Product2Id);
					Pricepartlist.remove(currentCI.Product2Id);
					PriceSKUlist.remove(currentCI.Product2Id);
					PriceTypepartlist.remove(currentCI.Product2Id);
					PricepartNamelist.remove(currentCI.Product2Id);
				}
			}
			update CheckexistCartItem;

			system.debug('PricepartNolist data => '+PricepartNolist);
			system.debug('PriceConditionlist data => '+PriceConditionlist);
			system.debug('PriceSKUlist data => '+PriceSKUlist);
			system.debug('Pricepartlist data => '+Pricepartlist);
			system.debug('PriceTypepartlist data => '+PriceTypepartlist);

			List<CartItem> CheckPartexistCartItem = [
				SELECT Id,Name, Condition_Code__c,Condition_Code__r.Name,Product2Id
				FROM CartItem 
				WHERE CartId =: CartId 
				AND Product2Id IN :PriceConditionlist.KeySet()];

			system.debug('Check CartItem CheckPartexistCartItem => '+CheckPartexistCartItem);
			for(CartItem currentCInew : CheckPartexistCartItem){				
				PricepartNolist.remove(currentCInew.Product2Id);
				PriceConditionlist.remove(currentCInew.Product2Id);
				PriceConditionIDlist.remove(currentCInew.Product2Id);
				Pricepartlist.remove(currentCInew.Product2Id);
				PriceSKUlist.remove(currentCInew.Product2Id);
				PriceTypepartlist.remove(currentCInew.Product2Id);
				PricepartNamelist.remove(currentCInew.Product2Id);				
			}

			if(PriceConditionlist.size()>0){
				for(Id singlePart : PriceConditionlist.keySet()){
					CartItem Citem = New CartItem();
					Citem.Product2Id = singlePart;
					Citem.Type = 'Product';
					Citem.Sku = PriceSKUlist.get(singlePart);
					Citem.Name = PricepartNamelist.get(singlePart);
					Citem.CartDeliveryGroupId = cartDeliveryGroupId;
					Citem.Quantity = PricepartNolist.get(singlePart);
					Citem.SalesPrice = Pricepartlist.get(singlePart);
					Citem.Price_Type__c = PriceTypepartlist.get(singlePart);
					Citem.Condition_Code__c = PriceConditionIDlist.get(singlePart);				
					Citem.Condition_Code_Price_Type__c = PriceConditionlist.get(singlePart)+' - Outright';
					Citem.AdjustmentAmount = 0.00;
					Citem.TotalListPrice = 0.00;
					Citem.UnitAdjustmentAmount = 0.00;
					Citem.UnitAdjustedPrice = Pricepartlist.get(singlePart);
					Citem.TotalPrice = PricepartNolist.get(singlePart)*Pricepartlist.get(singlePart);
					Citem.TotalLineAmount = PricepartNolist.get(singlePart)*Pricepartlist.get(singlePart);
					GrandTotal = PricepartNolist.get(singlePart)*Pricepartlist.get(singlePart);
					Citem.CartId = CartId;
					CartItemNewList.add(Citem);
				}
			}
			//system.debug('Check CartItemNewList  => '+CartItemNewList);

			if(CartItemNewList.size()>0) {
				insert CartItemNewList;
				system.debug('Inserted CartItem => '+CartItemNewList);
			}


			/*List<Product2> SortedPartlist = [SELECT Id,Name,StockKeepingUnit,(SELECT Id,IsActive,UnitPrice,Name  FROM PriceBookEntries WHERE PriceBook2.Name ='Seattle Store Price Book') FROM Product2 WHERE Name IN : partNolist.KeySet()];
			system.debug('Partmaster With Price => '+SortedPartlist);
			List<CartItem> CheckCartItem = [SELECT Id,Name,SalesPrice,Quantity,TotalPrice,TotalLineAmount FROM CartItem WHERE CartId =: CartId And Name IN : partNolist.KeySet()];
			system.debug('Check CartItem  => '+CheckCartItem);
			for(CartItem currentCI : CheckCartItem){
				currentCI.Quantity = currentCI.Quantity + partNolist.get(currentCI.Name);
				currentCI.TotalPrice = currentCI.TotalPrice + (partNolist.get(currentCI.Name)*currentCI.SalesPrice);				
				currentCI.TotalLineAmount = currentCI.TotalLineAmount + (partNolist.get(currentCI.Name)*currentCI.SalesPrice);
				ExistCartItemList.add(currentCI.Name);
			}
			update CheckCartItem;

			//system.debug('Partmaster => '+SortedPartlist.PricebookEntries[0]);
			for(Product2 singlePart : SortedPartlist){
				
				if(singlePart.PricebookEntries.size()>0 && (ExistCartItemList.contains(singlePart.Name)== False)) {
					system.debug('Partmaster With Price => '+singlePart.PricebookEntries);
					CartItem Citem = New CartItem();
					Citem.Product2Id = singlePart.Id;
					Citem.Type = 'Product';
					Citem.Sku = singlePart.StockKeepingUnit;
					Citem.Name = singlePart.Name;
					Citem.CartDeliveryGroupId = cartDeliveryGroupId;
					Citem.Quantity = partNolist.get(singlePart.Name);
					Citem.SalesPrice = singlePart.PricebookEntries[0].UnitPrice;
					Citem.AdjustmentAmount = 0.00;
					Citem.TotalListPrice = 0.00;
					Citem.UnitAdjustmentAmount = 0.00;
					Citem.UnitAdjustedPrice = singlePart.PricebookEntries[0].UnitPrice;
					Citem.TotalPrice = partNolist.get(singlePart.Name)*singlePart.PricebookEntries[0].UnitPrice;
					Citem.TotalLineAmount = partNolist.get(singlePart.Name)*singlePart.PricebookEntries[0].UnitPrice;
					GrandTotal = partNolist.get(singlePart.Name)*singlePart.PricebookEntries[0].UnitPrice;
					Citem.CartId = CartId;
					CartItemList.add(Citem);
				}
			}

			
			if(CartItemList.size()>0) {
				insert CartItemList;
				system.debug('Inserted CartItem => '+CartItemList);
			}*/
			//System.debug( 'Current User Type - '+UserInfo.getUserId());
			//System.debug( 'Current User Id - '+UserInfo.getOrganizationId());
		}


		//return CartItemList;
		return noErrorFile;
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
    }
}