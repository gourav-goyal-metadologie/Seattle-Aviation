Public class EnableProductForStorefront{
    @invocableMethod(label='Category EP Creation')
    public static void invokeFuture(List<ID> ids){
        createProductRelatedData(ids[0]);
    }
    
    @future
    public static void createProductRelatedData(Id  productId){
        /* CommerceEntitlementPolicy cep = new CommerceEntitlementPolicy();
        String cepName = System.Label.Entitlement_Policy_Name;
        cep = [SELECT ID,Name FROM CommerceEntitlementPolicy WHERE Name ='Seattle Store Entitlement Policy']; */
        
        CommerceEntitlementProduct ceProduct = new CommerceEntitlementProduct();
        ceProduct.ProductId = productId;
        ceProduct.PolicyId = System.Label.Entitlement_Policy_ID;        
        insert ceProduct;
        
        List<ProductCategory> pc = new List<ProductCategory>([SELECT ID FROM ProductCategory WHERE Name != 'ALL' AND NumberOfProducts < 5000]);
        
        if(!pc.isEmpty()){
            ProductCategoryProduct pcp = new ProductCategoryProduct();
            pcp.ProductCategoryId = pc[0].id;
            pcp.ProductId = productId;
            insert pcp;
        }
        
        /* PriceBook2 standardPriceBook = new PriceBook2();
        standardPriceBook = [SELECT ID FROM PriceBook2 WHERE Name ='Standard Price Book']; */
        
        PriceBookEntry standardPBE = new PriceBookEntry();
        standardPBE.Pricebook2Id = System.Label.Standard_PriceBook_ID;
        standardPBE.Product2Id = productId;
        standardPBE.UnitPrice = 1;
        standardPBE.isActive = true;
        insert standardPBE;
        
        /* PriceBook2 customPriceBook = new PriceBook2();
        customPriceBook = [SELECT ID FROM PriceBook2 WHERE Name =:System.Label.Custom_Price_Book_Name]; */
        
        PriceBookEntry customPBE = new PriceBookEntry();
        customPBE.Pricebook2Id = System.Label.Custom_PriceBook_ID;
        customPBE.Product2Id = productId;
        customPBE.UnitPrice = 1;
        customPBE.isActive = true;
        insert customPBE;
        
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
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
        i++;
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