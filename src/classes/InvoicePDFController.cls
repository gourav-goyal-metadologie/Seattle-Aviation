public class InvoicePDFController {
    
    public inscor__Invoice__c Invoice{get;set;}
    public List< inscor__Invoice_Line__c > invoiceLines{get;set;}
    public  inscor__Form_Options__c formOptions{get;set;}
    public String imageUrl{get;set;} 
    
    public InvoicePDFController(ApexPages.StandardController stdController) {

        String invoiceRecordId = ApexPages.currentPage().getParameters().get('inv');
        system.debug('invoiceRecordId >> '+invoiceRecordId);
        //this.Invoice = (inscor__Invoice__c)stdController.getRecord();
    	this.Invoice = [Select Id,inscor__AWB__c,inscor__Shipped_Method__r.Name, Name, inscor__Invoice_Date__c, inscor__Invoice_Total__c, 
            inscor__Account_Terms__r.Name, inscor__Account__r.Name, inscor__Account__r.inscor__VAT__c,inscor__Acct__c, inscor__Billing_City__c, 
            inscor__Billing_Contact__r.Name, inscor__Billing_Contact__r.Phone, inscor__Contact__r.Phone, inscor__Billing_Country__c, inscor__Billing_Postal_Code__c, 
            inscor__Billing_State__c, inscor__Billing_Street__c, inscor__City__c, 
            inscor__Sales_Order__r.Name, inscor__Sales_Order__r.inscor__Create_Date__c, 
            inscor__Country__c, inscor__Total_Invoice__c,
            inscor__External_Comments_rt__c,
            inscor__State__c, inscor__Street__c, 
            inscor__Zip_Code__c, inscor__Customer_PO_Number__c,
            inscor__Ship_Terms__c FROM inscor__Invoice__c where Id =: invoiceRecordId];
        setInvoiceLines(invoiceRecordId);
        //imageUrl = 'https://www.webarcode.com/barcode/image.php?code=' + this.Invoice.Name + '&type=C128B&height=60&width=200&output=png';
        //imageUrl = 'https://www.webarcode.com/barcode/image.php?code=*INVC-3467*&type=C39&height=60&width=200&output=png';
        imageUrl = 'https://mobiledemand-barcode.azurewebsites.net/barcode/image?content=' + this.Invoice.Name + '&size=50&symbology=CODE_128&format=png&text=false';
        setfooter();
        }
    
    private void setInvoiceLines(String invoiceId){
        invoiceLines = [SELECT Id, Name, inscor__Item__c, inscor__Extended_Price__c , inscor__Item__r.Name, inscor__Item__r.inscor__HTS_Code__c, inscor__Item__r.ECCN_Value__c, inscor__Item__r.inscor__Description__c,
                        inscor__Quantity__c, inscor__UOM__c, Condition_Code_Value__c, inscor__Price__c, inscor__Inventory__r.inscor__Serial_Number__c, inscor__Inventory__r.inscor__Batch_LOT__c,  inscor__Total_Cost__c, inscor__Extended_Total_Cost__c
                        FROM inscor__Invoice_Line__c
                       	WHERE inscor__Invoice__c =:invoiceId];
    }
    
    private void setfooter(){
        
        formOptions = [select id, name, inscor__Footer__c from inscor__Form_Options__c where name='Invoice' limit 1];
        String formattedFooter = formOptions.inscor__Footer__c.remove('<p>')
            					.replaceAll('</p>', '<br/>')
        						.removeEnd('<br/>');
        /*formattedFooter += '<span  style="margin-left:78px;float:right;">' +
                    'Page&nbsp;<span class="pagenumber" />&nbsp;of&nbsp;<span class="pagecount" />' +
                '</span>';
        system.debug(formattedFooter);*/
        formOptions.inscor__Footer__c = formattedFooter;
        //formattedFooterList = formattedFooterList.split('</p>');
        
    }
}