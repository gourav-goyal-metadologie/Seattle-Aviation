global class CoreExchangeFormResponsePDFCtrl {
    
    public Customer_Exchange_Summary_Form_Response__c coreExchangeFormResponse{get; set;}
    public List<inscor__Sales_Order_Line__c> salesOrderLines{get; set;}
    public string ipAddress {get; set;}
    public String imageUrl{get;set;} 
    //public String carrier{get;set;}
    
    public CoreExchangeFormResponsePDFCtrl() {
        String coreExchangeFormResponseId = ApexPages.currentPage().getParameters().get('id');
        if(String.isNotBlank(coreExchangeFormResponseId)){
            this.coreExchangeFormResponse = getCoreExchangeFormResponseById(coreExchangeFormResponseId);
            //this.carrier = (String)this.coreExchangeFormResponse.Carrier__c;
            system.debug(JSON.serializePretty(this.coreExchangeFormResponse));
            
            setSalesOrderLines(this.coreExchangeFormResponse.Customer_Exchange_Summary__c);
            ipAddress = getIpAddress();
            //imageUrl = 'https://www.webarcode.com/barcode/image.php?code=' + this.coreExchangeFormResponse.Customer_Exchange_Summary__r.inscor__Original_SO_ID__r.Name + '&type=C128B&xres=1&height=100&width=300&font=3&output=png';
			imageUrl = 'https://mobiledemand-barcode.azurewebsites.net/barcode/image?content=' + this.coreExchangeFormResponse.Customer_Exchange_Summary__r.inscor__Original_SO_ID__r.Name + '&size=50&symbology=CODE_128&format=png&text=false';
        
        }
    }
    
    public Customer_Exchange_Summary_Form_Response__c getCoreExchangeFormResponseById(Id coreExchangeFormResponseId){
        Customer_Exchange_Summary_Form_Response__c coreExchangeFormResponse = [SELECT 
                                                                               Id,
                                                                               Customer_Exchange_Summary__c,
                                                                               Customer_Exchange_Summary__r.Customer_PO_Number__c,
                                                                               Customer_Exchange_Summary__r.inscor__Original_SO_ID__r.Name,
                                                                               Customer_Name__c,
                                                                               Billing_Address__c,
                                                                               Aircraft_Model__c,
                                                                               Aircraft_SN__c,
                                                                               Carrier__c,
                                                                               AC_CSN__c,
                                                                               AWB__c,
                                                                               AC_TSN__c,
                                                                               SN__c,
                                                                               PN__c,
                                                                               TSO__c,
                                                                               Cso__c,
                                                                               TSO_Value__c, TSN_Value__c, CSO_Value__c, CSN_Value__c
                                                                               FROM Customer_Exchange_Summary_Form_Response__c 
                                                                               WHERE Id = :coreExchangeFormResponseId];
        return coreExchangeFormResponse;
    }
    
    /**
     * @author : Vinod Kumar Sharma
     * @date : 10/09/2021
     * description : this method used to get all the sales order lines with the id from exchange summary
     **/
    public void setSalesOrderLines(Id customerExchangeSummaryId){
        salesOrderLines = [SELECT Id, inscor__Quantity_Ordered__c, inscor__Product__r.Name, 
                           inscor__Expected_Core_Serial_Number__c, inscor__Condition_Code__r.Name  
                           FROM inscor__Sales_Order_Line__c 
                           WHERE inscor__Order__c IN (SELECT inscor__Original_SO_ID__c 
                                                      FROM inscor__Customer_Exchange_Summary__c 
                                                      WHERE Id =: customerExchangeSummaryId)];
    }
    
    public String getIpAddress(){
        String ipAddress = ApexPages.currentPage().getHeaders().get('True-Client-IP');
        
        if (ipAddress == '' || ipAddress == null) {
            ipAddress = ApexPages.currentPage().getHeaders().get('X-Salesforce-SIP');
        }
        if (ipAddress == '' || ipAddress == null) {
            ipAddress = ApexPages.currentPage().getHeaders().get('X-Forwarded-For');
        }
        
        return ipAddress;
    }
    
    

    @AuraEnabled
    public static String getCurrentPageReference()
    {
        PageReference pageRef;
        String baseUrl = System.URL.getSalesforceBaseUrl().toExternalForm();
        pageRef = new PageReference(baseUrl+'/apex/CoreExchangeFormResponsePDF');
        pageRef.setRedirect(true);
        System.debug(pageRef);
        return String.valueOf(pageRef);
    }
    
}