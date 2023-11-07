public class ComplianceValidation {
    
    public static String validateUploadFileRequest(inscor__Release__c release, 
                                                   inscor__Sales_Order__c salesOrder,
                                                   Account customer)
    {
    	List<String> errors = new List<String>();
        if(release.inscor__Ship_To_Address__c == null && release.inscor__Dropship_to_Account__c == null){
            errors.add('Ship To Address and Drop to account are Missing');
        }
		String destCountry;
        if(release.inscor__Ship_To_Address__c != null){
            destCountry = release.inscor__Ship_To_Address__r.inscor__Country__c;
        }else if(release.inscor__Dropship_Site__c != null){
            destCountry = release.inscor__Dropship_Site__r.inscor__Country__c;
        }
        
        destCountry = CountryStateUtility.getCountryCode(destCountry);
        if( String.isBlank(destCountry)){
            errors.add('Country on Shipping address or doorship site address is not correct.');
        }
        return String.join(errors, '\n');
    }
    
    //This method will validate if contact is valid or not.
    //Added 02June2021
     public static String validateContactRequest(Contact con, 
                                                   Account customer)
    {
    	List<String> errors = new List<String>();
        if(con.Accountid == null){
            errors.add('Trade Partner Missing');
        }
        return String.join(errors, '\n');
    }

}