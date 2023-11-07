public class SalesOrderPDFController {
	
    public inscor__Sales_Order__c SalesOrder{get;set;}
    public List<inscor__Sales_Order_Line__c > salesOrderLines{get;set;}
    public String imageUrl{get;set;}
    public String shippingAddressAccountName{get;set;} 
    //public String AOG{get;set;}
    
    
    public SalesOrderPDFController(ApexPages.StandardController stdController) {

        String salesOrderId = ApexPages.currentPage().getParameters().get('id');
        
    	this.SalesOrder = [Select Id, Name, inscor__Customer__r.Name, inscor__Dropship_to_Account__r.Name,
                           inscor__Customer__r.inscor__Account_Number__c, inscor__Ship_Method__r.Name, inscor__Acct__c,
                           inscor__Billing_Contact__r.Email, inscor__Billing_Contact__r.Fax, inscor__Billing_Contact__r.Phone,
                           inscor__Billing_Contact__r.Title, inscor__Billing_Contact__r.Name,
                           inscor__Billing_Street__c, inscor__Billing_City__c, inscor__Billing_State__c, inscor__Billing_Country__c, 
                           inscor__Billing_Postal_Code__c, inscor__Shipping_Street__c, inscor__Shipping_City__c, inscor__Shipping_State__c, 
                           inscor__Shipping_Country__c, inscor__Shipping_Postal_Code__c,inscor__Sales_Order_Total_Value__c,
                           inscor__Incoterms__c, inscor__Number_of_Lines__c, inscor__Create_Date__c, inscor__Port_Dest__c, inscor__Customer_PO_Number__c,
                           inscor__Contact__r.Name, inscor__Contact__r.Title, inscor__Contact__r.Phone, inscor__Contact__r.Email, inscor__Contact__r.Fax                         
                           FROM inscor__Sales_Order__c where Id =: salesOrderId];
        setSalesOrderLines(salesOrderId);
        if(this.SalesOrder.inscor__Dropship_to_Account__r.Name != null){
            this.shippingAddressAccountName = this.SalesOrder.inscor__Dropship_to_Account__r.Name;
        }else{
            this.shippingAddressAccountName = this.SalesOrder.inscor__Customer__r.Name;
        }
        //this.AOG = '01 (425) 448-5005x703';
        imageUrl = 'https://mobiledemand-barcode.azurewebsites.net/barcode/image?content=' + this.SalesOrder.Name + '&size=50&symbology=CODE_128&format=png&text=false';
        
    }
    
    private void setSalesOrderLines(String salesOrderId){
        salesOrderLines = [SELECT Id, Name, inscor__Product__r.Name, inscor__Product__r.inscor__Description__c, 
                        inscor__Quantity_Ordered__c, inscor__Condition_Code__r.Name, inscor__Price__c, 
                        inscor__Line_Total__c, inscor__Product__r.inscor__Avg_Lead_Time__c, inscor__External_Comments_rt__c 
                        FROM inscor__Sales_Order_Line__c
                       	WHERE inscor__Order__c =:salesOrderId];
    }
}