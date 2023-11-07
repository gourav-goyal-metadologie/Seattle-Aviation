@isTest(SeeAllData=true)
public class B2BGetInfoTest {
    public Static String userId; // declare userId
    public Static String accountId; // declare accountId
    public Static String cartId; // declare cartId
    public Static String conditioncodeId; // declare conditioncodeId
    public Static String productId; // declare productId
    public static String accountName;
    
    // get coummunityId/NetworkId 
    private static String getCommunityId(){
        Id p = [select id from profile where name='Customer Community Plus Login User'].id;
        List<User> user = [SELECT Id, Name,ContactID FROM User WHERE ProfileId = :p AND ContactID!=null];
        Contact Obj =new Contact();
        obj = [SELECT ID,AccountId,Account.Name FROM Contact WHERE ID=:user[0].ContactID];
        accountId = obj.AccountId;
        accountName = obj.Account.Name;
		userId = user[0].Id;
        List<NetworkMember> membership = [SELECT NetworkID, MemberID FROM NetworkMember WHERE memberID = :user[0].id];
        return membership[0].NetworkID;
    }
    
    @isTest
    public static void testGetProduct (){
        String communityId = getCommunityId();
        Product2 pr = new Product2(Name ='#10',inscor__Keyword__c = 'SCREW',inscor__UOM__c='EA');
        //productId = [SELECT Id,Name FROM Product2 WHERE Name Like '%#10%' Order by CreatedDate DESC LIMIT 1].Id;
        insert pr;
        productId = pr.Id;
        Test.setMock(HttpCalloutMock.class, new ApnMockHttpResponseGenerator());
        Test.startTest();
        	B2BGetInfo.getProduct(communityId,productId,accountId);
        Test.stopTest();
    }
    
       
     @isTest
    public static void testGetCartSummary(){
        String communityId = getCommunityId();
        //BuyerAccount objBA = new BuyerAccount(BuyerId=accountId,isActive=true,Name=accountName);
        //insert objBA;
        Test.startTest();
        	B2BGetInfo.getCartSummary(communityId,accountId);
        Test.stopTest();
    }
    
    @isTest
    public static void testGetProductPrice(){
        String communityId = getCommunityId();
        String productId = productId;
        Test.startTest();
        	B2BGetInfo.getProductPrice(communityId,productId,accountId);
        Test.stopTest();
    }
    
    @isTest
    public static void testCreateAndAddToList(){
        String communityId = getCommunityId();
        String productId = productId;
        Test.startTest();
        	B2BGetInfo.createAndAddToList(communityId,productId,'wishlistName',accountId);
        Test.stopTest();
    } 
}