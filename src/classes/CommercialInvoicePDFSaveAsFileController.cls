public class CommercialInvoicePDFSaveAsFileController {
    
    public inscor__Release__c release{get;set;}
    public List< inscor__Release_Line__c > releaseLines{get;set;}
    public  inscor__Form_Options__c formOptions{get;set;}
    public String imageUrl{get;set;} 
    public Decimal totalAmount{get;set;} 
    public String shippingAddressAccountName{get;set;} 
    
    public CommercialInvoicePDFSaveAsFileController(ApexPages.StandardController stdController) {
        
        String releaseRecordId = ApexPages.currentPage().getParameters().get('Id');
        system.debug('releaseRecordId >> '+releaseRecordId);
        this.release = [Select Id, inscor__Freight_Charge__c, Name, inscor__Sales_Order__r.inscor__Customer__r.Name,
                        inscor__Billing_Street__c, inscor__Billing_City__c, inscor__Billing_State__c, 
                        inscor__Billing_Country__c, inscor__Billing_Postal_Code__c, inscor__Billing_Contact__r.Phone, 
                        inscor__Street__c, inscor__City__c, inscor__State__c, inscor__Country__c, inscor__Zip_Code__c,
                        inscor__Contact_Phone__c, inscor__Date_Shipped__c, inscor__Sales_Order__r.inscor__Customer_PO_Number__c, 
                        inscor__Acct__c, inscor__Sales_Order__r.Name, inscor__Sales_Order__r.inscor__Dropship_to_Account__r.Name, inscor__Shipped_Method__r.Name,
                        inscor__Account_Terms__r.Name, inscor__Ship_Terms__c, inscor__Billing_Contact__r.Name, inscor__Sales_Order__r.inscor__Customer__r.inscor__VAT__c, 
                        inscor__Release_Value__c, inscor__External_Comments_rt__c, inscor__AWB__c FROM inscor__Release__c where Id =: releaseRecordId];
        if(this.release.inscor__Sales_Order__r.inscor__Dropship_to_Account__r.Name != null){
            this.shippingAddressAccountName = this.release.inscor__Sales_Order__r.inscor__Dropship_to_Account__r.Name;
        }else{
            this.shippingAddressAccountName = this.release.inscor__Sales_Order__r.inscor__Customer__r.Name;
        }
         totalAmount = 0;
        if(release.inscor__Freight_Charge__c != null){
            totalAmount = release.inscor__Release_Value__c + release.inscor__Freight_Charge__c;
        }else{
            totalAmount = release.inscor__Release_Value__c;
        }
        setReleaseLines(releaseRecordId);
        imageUrl = 'https://mobiledemand-barcode.azurewebsites.net/barcode/image?content=' + this.release.Name + '&size=50&symbology=CODE_128&format=png&text=false';
        setfooter();
        
    }
    
    private void setReleaseLines(String releaseId){
        releaseLines = [SELECT Id, Name, inscor__Allocation__r.inscor__Inventory_Line__r.inscor__Product__r.Name,
                        inscor__Allocation__r.inscor__Inventory_Line__r.inscor__Serial_Number__c,
                        inscor__Allocation__r.inscor__Inventory_Line__r.inscor__Batch_LOT__c,
                        inscor__Allocation__r.inscor__Inventory_Line__r.inscor__Product__r.inscor__HTS_Code__c,
                        inscor__Allocation__r.inscor__Inventory_Line__r.inscor__Product__r.ECCN_Value__c, 
                        inscor__Allocation__r.inscor__Inventory_Line__r.inscor__Condition_Code__r.Name,
                        inscor__Allocation__r.inscor__Inventory_Line__r.inscor__Product__r.inscor__Description__c,
                        inscor__Allocation__r.inscor__Inventory_Line__r.inscor__UOM__c,
                        inscor__Quantity__c, inscor__Price__c, inscor__Line_Value__c, inscor__Part_Number__c
                        FROM inscor__Release_Line__c
                        WHERE inscor__Release__c =:releaseId];
    }
    
    private void setfooter(){
        formOptions = [select id, name, inscor__Footer__c, inscor__Body_1__c from inscor__Form_Options__c where name='Packing Slip (Priced)' limit 1];
        String formattedFooter = formOptions.inscor__Body_1__c == null ? '' : formOptions.inscor__Body_1__c.remove('<p>')
            .replaceAll('</p>', '<br/>')
            .removeEnd('<br/>');
        formOptions.inscor__Footer__c = formattedFooter;
    }
    

}