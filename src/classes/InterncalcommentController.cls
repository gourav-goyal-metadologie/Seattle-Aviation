public with sharing class InterncalcommentController {
    @AuraEnabled
    public static String Internalcomments(String cartId, string comment, String commentlinelevel) { // String comments, string CartId
        //string contactId;
        string accountId;
        System.debug('Commnets :'+comment);
        System.debug('comment Line level : ' +commentlinelevel);
        System.debug('CartId Id :'+cartId);
        

         // User Info...
		  List<User> UserDetails = new List<User>([SELECT Id,Contact.AccountID FROM User WHERE Id =:UserInfo.getUserId()]);
		if(!UserDetails.IsEmpty()){
			accountId = UserDetails[0].Contact?.AccountId;
            // System.debug('accout Id : ', accountId);
            System.debug('Account Id '+accountId);
		}

        try{
            ////// code for inserting comments with refernce to Cart Id /////
            WebCart newcartcomment = new WebCart();
            // newcartcomment.AccountId = accountId;
            // newcartcomment.Internal_Comments__c =  comment; 
            
            newcartcomment = [SELECT Id,Internal_Comments__c FROM WebCart WHERE Id =: cartId];
            if(comment.length() > 0 && comment != 'blankspace'){
                newcartcomment.Internal_Comments__c =  comment; 
            } 
            if(commentlinelevel.length() > 0 && commentlinelevel != 'blankspace'){
                newcartcomment.Line_Level_Comment__c = commentlinelevel;
            }
            update newcartcomment;
            System.debug('Updated Result '+newcartcomment);

        }catch(Exception e){
            System.debug('Error '+e.getStackTraceString());
        } 


        return 'Comment added Sucesssfully';

    }


    // checking cart availability in cart item 
    @AuraEnabled
    public static Decimal internalcartitems(String cartId){
        Decimal WebCartcount=0;
        List<WebCart> ExistingCartItems = new List<WebCart>();
        try{
            ExistingCartItems = [SELECT TotalProductCount FROM WebCart WHERE Id =: cartId Limit 1];
            System.debug('Query :' + ExistingCartItems[0].TotalProductCount);
            WebCartcount = ExistingCartItems[0].TotalProductCount;
        }catch(Exception e){
        }
        return WebCartcount;
    }



}