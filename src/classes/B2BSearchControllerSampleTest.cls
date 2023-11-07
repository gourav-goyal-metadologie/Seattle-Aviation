@isTest(SeeAllData=true)
public class B2BSearchControllerSampleTest {

     @isTest
    public static void productSearchFailTest (){
        Test.startTest();
        Product2 pr = new Product2(Name ='#16',inscor__Keyword__c = 'SCREW',inscor__UOM__c='EA');
        insert pr;
        Account ac = new Account(name ='Test2') ;
        insert ac;
        String communityId = getCommunityId();
        // String accountId = '0016s00000Dn3DtAAJ'; // Wrong account Id is corrected 
        B2BSearchControllerSample.productSearch(communityId, pr.name,ac.id);
        Test.stopTest();
    }
    
    
    

    private static String getCommunityId(){
        //List<User> user = [SELECT Id, Name FROM User WHERE Id = '0056s000000Y4q6AAC'];
        //List<NetworkMember> membership = [SELECT NetworkID, MemberID FROM NetworkMember WHERE memberID = :user[0].id];
         /* System.debug('communityID : ' + membership[0].NetworkID); */
        
        
        Id p = [select id from profile where name='Customer Community Plus Login User'].id;
        List<User> user = [SELECT Id, Name,ContactID FROM User WHERE ProfileId = :p];
        
        List<NetworkMember> membership = [SELECT NetworkID, MemberID FROM NetworkMember WHERE memberID = :user[0].id];
        //return membership[0].NetworkID;
        return membership[0].NetworkID;
        
    }
    /////////////////////////////// ends  here ////////////////////////////////////////////////
    
}