@isTest
public class shippingNewAddressController_Test {
    
	
       
    @isTest
  	public static void testaddAddress() {
	string street='strStreet';
    string city='strCity';
    string state='strState';
    string postalcode='strPostalCode';
    string country='strCountry';  
        String Name = 'Test';
        
        string returnvalue = shippingNewAddressController.shippingNewAddress(street, city, state, postalcode, country,Name);
 
  }
}