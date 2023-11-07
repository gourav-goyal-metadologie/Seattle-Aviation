@isTest
public class MassUploadToCartTest {
	
    @isTest
    public static void massUploadToCartCheck(){
        string csvData = 'Part Number,Condition Code,Quantity\r\n#10,RD,8\r\n#10,NE,5\r\n#10 INSERT,AR,10\r\n1515026-13,OH,5\r\n1323133-545,AI,3\r\n';        
        string communityId;// = '0DB6s000000Gmmy';
        Id p = [select id from profile where name='Customer Community Plus Login User'].id;
        //Id ac = [select id from Account where name='Seattle Account'].id;
        Account ac = new Account(name ='Grazitti') ;
        insert ac; 
       
        Contact con = new Contact(LastName ='testCon',BillNPay__LP_Payment_Request_Method__c ='Email',Email='mlum@cloudstreet.com',AccountId = ac.id);
        insert con;  
                  
        User user = new User(alias = 'test123', email='test123@noemail.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = p, country='United States',IsActive =true,
                ContactId = con.Id,
                timezonesidkey='America/Los_Angeles', username='tester@noemail.com');
       
        insert user;
        system.debug('user'+user);
        
        List<User> user1 = [SELECT Id, Name,ContactID FROM User WHERE ProfileId = :p AND isActive = true];
        List<NetworkMember> membership = [SELECT NetworkID, MemberID FROM NetworkMember WHERE memberID = :user1[0].id ];
        communityId = membership[0].NetworkID;
        /*List<User> user = [SELECT Id, Name FROM User WHERE Id = '0056s000000Y4q6AAC'];
        List<NetworkMember> membership = [SELECT NetworkID, MemberID FROM NetworkMember WHERE memberID = :user[0].id];
        communityId = membership[0].NetworkID;*/
        system.debug('communityId => '+communityId);
        
        //Instantiate the Pricebook2 record with StandardPricebookId
        Pricebook2 standardPricebook = new Pricebook2(
            Id = Test.getStandardPricebookId(),
            IsActive = true
        );
        
        //Execute an update DML on the Pricebook2 record, to make IsStandard to true
        Update standardPricebook;
        
        // Create Web Store
        WebStore newWebStore = new WebStore();
        newWebStore.Name = 'Seattle Store'+math.random();
        newWebStore.StrikethroughPricebookId=Test.getStandardPricebookId();
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
        newWebCart.OwnerId=user.Id;
        insert newWebCart;
        system.debug('New Cart Details => '+newWebCart);
        
               
        /*WebStore newWebStore = new WebStore();
        newWebStore.Name = 'Seattle Store1';
        newWebStore.StrikethroughPricebookId='01s6s000000H5I0AAK';
        newWebStore.PaginationSize=20;
        newWebStore.PricingStrategy='LowestPrice';
        newWebStore.MaxValuesPerFacet=100;
        insert newWebStore;
        
        WebStoreNetwork newWebStoreBG = new WebStoreNetwork();
        newWebStoreBG.WebStoreId = newWebStore.Id;
        newWebStoreBG.NetworkId='0DB6s000000GmmyGAC';
        insert newWebStoreBG;*/
        
        //Id webStoreId = [SELECT WebStoreId,NetworkId FROM WebStoreNetwork WHERE NetworkId =:communityId limit 1].WebStoreId;
        
        CartDeliveryGroup cartDeliveryGp = new CartDeliveryGroup();
        cartDeliveryGp.CartId = newWebCart.Id;
        cartDeliveryGp.Name=communityId;
        insert cartDeliveryGp;
        
        Product2 prod = new Product2();
        prod.Name='ABCD';
        prod.StockKeepingUnit='ABCD';
        prod.inscor__Keyword__c='10';
        insert prod;
        system.debug('product Details => '+prod);
        
        inscor__Condition_Code__c code = new inscor__Condition_Code__c();
        code.Name='NE';
        code.inscor__Show_in_Summary__c=false;
        insert code;
        system.debug('Condition code Details => '+code);
        
        //List<inscor__Company_Location__c> Company_Location = [SELECT Id FROM inscor__Company_Location__c]; 
        //system.debug('Company_Location Details => '+Company_Location);
        
        
        // Company...
        inscor__Company__c  company = new inscor__Company__c(
        inscor__Address_1__c = '1111', inscor__City__c = '1111', inscor__Company_Name__c = '1111', inscor__Zip_Code__c = '1111');
        insert company;
		system.debug('Company Details => '+company);
        
        inscor__Company_Location__c companyLoc = new inscor__Company_Location__c( inscor__Company__c =company.Id );
        insert companyLoc;
        system.debug('Company_Location Details => '+companyLoc);
        
		// Inventory Location
        inscor__Inventory_Location__c Inventory_Location = new inscor__Inventory_Location__c();
        //Inventory_Location.Name='Test';
        Inventory_Location.inscor__Company_Location__c = companyLoc.Id;
		insert Inventory_Location;  
        //List<inscor__Inventory_Location__c> Inventory_Location = [SELECT Id FROM inscor__Inventory_Location__c]; 
        system.debug('Inventory_Location Details => '+Inventory_Location);
        
		// Inventory Owner Code
        inscor__Owner_Code__c Owner_Code = new inscor__Owner_Code__c();
        //Owner_Code.Name='SPEC';
        Owner_Code.inscor__Available_for_Sale__c=true;
		insert Owner_Code;   
        //List<inscor__Owner_Code__c> Owner_Code = [SELECT Id FROM inscor__Owner_Code__c]; 
        system.debug('Owner_Code Details => '+Owner_Code);
        
		// // Inventory Warehouse.
        inscor__Warehouse__c Warehouse = new inscor__Warehouse__c();
        //Warehouse.Name='SAS - CIV';
        Warehouse.inscor__Warehouse_Code__c='CIV';
        Warehouse.inscor__Company_Location__c=companyLoc.Id;
		insert Warehouse; 
        //List<inscor__Warehouse__c> Warehouse = [SELECT Id FROM inscor__Warehouse__c]; 
        system.debug('Warehouse Details => '+Warehouse);
       
       	// Insert Inventory
		inscor__Inventory_Line__c inventory = new inscor__Inventory_Line__c();
        inventory.inscor__Condition_Code__c=code.id;
        inventory.inscor__product__c=prod.id;
        inventory.inscor__Quantity__c=1;
        inventory.inscor__Location__c = Inventory_Location.Id;
        inventory.inscor__Owner_Code__c = Owner_Code.Id;
        inventory.inscor__Warehouse__c = Warehouse.Id;
        //inventory.inscor__UOM__c = 'EA';
        //inventory.inscor__Keyword__c='10';
        insert inventory;		
        system.debug('update inventory Details => '+inventory);
        
        // Insert product Price
        inscor__Price__c Price = new inscor__Price__c();
        Price.inscor__Active__c = true;
        Price.inscor__Company__c = company.Id;
        Price.inscor__Condition_Code__c = code.id;
        Price.inscor__Part_Master__c = prod.id;
        Price.inscor__Price__c = 50;
        insert Price;
        system.debug('Price Details => '+Price);
        
        //0056s000000Ww1DAAS
        system.runAs(user) {
            //List<CartItem> Result = MassUploadToCart.massUploadToCart(JSON.serialize(csvData),communityId);
            MassUploadToCart.massUploadToCart(JSON.serialize(csvData),communityId);
        }       
       
    }
    
    @isTest
    public static void massUploadToCartCheck2(){
        string csvData = 'Part Number,Condition Code,Quantity\r\n#10,RD,8\r\n#10,NE,5\r\n#10 INSERT,AR,10\r\n1515026-13,OH,5\r\n1323133-545,AI,3\r\n';        
        string communityId;// = '0DB6s000000Gmmy';
        Id p = [select id from profile where name='Customer Community Plus Login User'].id;
        //Id ac = [select id from Account where name='Seattle Account'].id;
        Account ac = new Account(name ='Grazitti') ;
        insert ac; 
       
        Contact con = new Contact(LastName ='testCon',BillNPay__LP_Payment_Request_Method__c ='Email',Email='mlum@cloudstreet.com',AccountId = ac.id);
        insert con;  
                  
        User user = new User(alias = 'test123', email='test123@noemail.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = p, country='United States',IsActive =true,
                ContactId = con.Id,
                timezonesidkey='America/Los_Angeles', username='tester@noemail.com');
       
        insert user;
        system.debug('user'+user);
        List<User> user1 = [SELECT Id, Name,ContactID FROM User WHERE ProfileId = :p AND isActive = true];
        List<NetworkMember> membership = [SELECT NetworkID, MemberID FROM NetworkMember WHERE memberID = :user1[0].id];
        communityId = membership[0].NetworkID;
        /*List<User> user = [SELECT Id, Name FROM User WHERE Id = '0056s000000Y4q6AAC'];
        List<NetworkMember> membership = [SELECT NetworkID, MemberID FROM NetworkMember WHERE memberID = :user[0].id];
        communityId = membership[0].NetworkID;*/
        system.debug('communityId => '+communityId);
        
        //Instantiate the Pricebook2 record with StandardPricebookId
        Pricebook2 standardPricebook = new Pricebook2(
            Id = Test.getStandardPricebookId(),
            IsActive = true
        );
        
        //Execute an update DML on the Pricebook2 record, to make IsStandard to true
        Update standardPricebook;
        
        // Create Web Store
        WebStore newWebStore = new WebStore();
        newWebStore.Name = 'Seattle Store'+math.random();
        newWebStore.StrikethroughPricebookId=Test.getStandardPricebookId();
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
        newWebCart.OwnerId=user.id;
        insert newWebCart;
        system.debug('New Cart Details => '+newWebCart);
        
               
        /*WebStore newWebStore = new WebStore();
        newWebStore.Name = 'Seattle Store1';
        newWebStore.StrikethroughPricebookId='01s6s000000H5I0AAK';
        newWebStore.PaginationSize=20;
        newWebStore.PricingStrategy='LowestPrice';
        newWebStore.MaxValuesPerFacet=100;
        insert newWebStore;
        
        WebStoreNetwork newWebStoreBG = new WebStoreNetwork();
        newWebStoreBG.WebStoreId = newWebStore.Id;
        newWebStoreBG.NetworkId='0DB6s000000GmmyGAC';
        insert newWebStoreBG;*/
        
        //Id webStoreId = [SELECT WebStoreId,NetworkId FROM WebStoreNetwork WHERE NetworkId =:communityId limit 1].WebStoreId;
        
        CartDeliveryGroup cartDeliveryGp = new CartDeliveryGroup();
        cartDeliveryGp.CartId = newWebCart.Id;
        cartDeliveryGp.Name=communityId;
        insert cartDeliveryGp;
        
        Product2 prod = new Product2();
        prod.Name='PQRS';
        prod.StockKeepingUnit='PQRS';
        prod.inscor__Keyword__c='10';
        insert prod;
        system.debug('product Details => '+prod);
        
        inscor__Condition_Code__c code = new inscor__Condition_Code__c();
        code.Name='NE';
        code.inscor__Show_in_Summary__c=false;
        insert code;
        system.debug('Condition code Details => '+code);
        
        //List<inscor__Company_Location__c> Company_Location = [SELECT Id FROM inscor__Company_Location__c]; 
        //system.debug('Company_Location Details => '+Company_Location);
        
        
        // Company...
        inscor__Company__c  company = new inscor__Company__c(
        inscor__Address_1__c = '1111', inscor__City__c = '1111', inscor__Company_Name__c = '1111', inscor__Zip_Code__c = '1111');
        insert company;
		system.debug('Company Details => '+company);
        
        inscor__Company_Location__c companyLoc = new inscor__Company_Location__c( inscor__Company__c =company.Id );
        insert companyLoc;
        system.debug('Company_Location Details => '+companyLoc);
        
		// Inventory Location
        inscor__Inventory_Location__c Inventory_Location = new inscor__Inventory_Location__c();
        //Inventory_Location.Name='Test';
        Inventory_Location.inscor__Company_Location__c = companyLoc.Id;
		insert Inventory_Location;  
        //List<inscor__Inventory_Location__c> Inventory_Location = [SELECT Id FROM inscor__Inventory_Location__c]; 
        system.debug('Inventory_Location Details => '+Inventory_Location);
        
		// Inventory Owner Code
        inscor__Owner_Code__c Owner_Code = new inscor__Owner_Code__c();
        //Owner_Code.Name='SPEC';
        Owner_Code.inscor__Available_for_Sale__c=true;
		insert Owner_Code;   
        //List<inscor__Owner_Code__c> Owner_Code = [SELECT Id FROM inscor__Owner_Code__c]; 
        system.debug('Owner_Code Details => '+Owner_Code);
        
		// // Inventory Warehouse.
        inscor__Warehouse__c Warehouse = new inscor__Warehouse__c();
        //Warehouse.Name='SAS - CIV';
        Warehouse.inscor__Warehouse_Code__c='CIV';
        Warehouse.inscor__Company_Location__c=companyLoc.Id;
		insert Warehouse; 
        //List<inscor__Warehouse__c> Warehouse = [SELECT Id FROM inscor__Warehouse__c]; 
        system.debug('Warehouse Details => '+Warehouse);
       
       	// Insert Inventory
		inscor__Inventory_Line__c inventory = new inscor__Inventory_Line__c();
        inventory.inscor__Condition_Code__c=code.id;
        inventory.inscor__product__c=prod.id;
        inventory.inscor__Quantity__c=1;
        inventory.inscor__Location__c = Inventory_Location.Id;
        inventory.inscor__Owner_Code__c = Owner_Code.Id;
        inventory.inscor__Warehouse__c = Warehouse.Id;
        //inventory.inscor__UOM__c = 'EA';
        //inventory.inscor__Keyword__c='10';
        insert inventory;		
        system.debug('update inventory Details => '+inventory);
        
        // Insert product Price
        inscor__Price__c Price = new inscor__Price__c();
        Price.inscor__Active__c = true;
        Price.inscor__Company__c = company.Id;
        Price.inscor__Condition_Code__c = code.id;
        Price.inscor__Part_Master__c = prod.id;
        Price.inscor__Price__c = 50;
        insert Price;
        system.debug('Price Details => '+Price);
        
        // Already exist product.
        CartItem Citem = New CartItem();
        Citem.Product2Id = prod.id;
        Citem.Type = 'Product';
        Citem.Sku = prod.StockKeepingUnit;
        Citem.Name = prod.Name;
        Citem.CartDeliveryGroupId = cartDeliveryGp.Id;
        Citem.Quantity = 10;
        Citem.SalesPrice = 50;
        //Citem.Price_Type__c = PriceTypepartlist.get(singlePart);
        Citem.Condition_Code__c = code.id;
        Citem.AdjustmentAmount = 0.00;
        Citem.TotalListPrice = 0.00;
        Citem.UnitAdjustmentAmount = 0.00;
        Citem.UnitAdjustedPrice = 50;
        Citem.TotalPrice = 50*10;
        Citem.TotalLineAmount = 50*10;
        Citem.CartId = newWebCart.Id;
        insert Citem;        
        system.debug('CartItem Details => '+Citem);
        
        //0056s000000Ww1DAAS
        system.runAs(user) {
            //List<CartItem> Result = MassUploadToCart.massUploadToCart(JSON.serialize(csvData),communityId);
            MassUploadToCart.massUploadToCart(JSON.serialize(csvData),communityId);
        }       
       
    }
    
    static testmethod void testIncrement() {
        MassUploadToCart.justIncrement();
    }
    
}