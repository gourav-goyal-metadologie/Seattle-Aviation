public class shippingNewAddressController {
    @AuraEnabled
    public static String shippingNewAddress(string street,string city,string state,string postalcode,string country,String name) {//,String Name
        //string contactId;
        string accountId;
		
         // User Info...
		List<User> UserDetails = new List<User>([SELECT Id,Contact.AccountID FROM User WHERE Id =:UserInfo.getUserId()]);
		if(!UserDetails.IsEmpty()){
			accountId = UserDetails[0].Contact?.AccountId;
		}
        
        //AddressType='Shipping';
        //Add New Shipping Address.
        ContactPointAddress NewAddress = new ContactPointAddress();
        NewAddress.ParentId = accountId;
        NewAddress.Name = name;
        NewAddress.Street = street;
        NewAddress.City = city;
        NewAddress.State = state;
        NewAddress.PostalCode = postalcode;
        NewAddress.Country = country;
        NewAddress.AddressType='Shipping';
        insert NewAddress;
        try{
            inscor__Account_Ship_Address__c newShippingAddress = new inscor__Account_Ship_Address__c();
            newShippingAddress.inscor__Account__c = accountId;
            newShippingAddress.inscor__City__c = city;
            newShippingAddress.inscor__Country__c = country;
            newShippingAddress.inscor__Postal_Code__c = postalcode;
            newShippingAddress.inscor__State__c = state;
            newShippingAddress.inscor__Street__c = street;
            newShippingAddress.Name = name;
            newShippingAddress.Shipping__c = true;
            insert newShippingAddress; 
        }catch(Exception e){
            System.debug('Error '+e.getStackTraceString());
        }
        return 'Sucesssfully added';

    }
    
    
   
}