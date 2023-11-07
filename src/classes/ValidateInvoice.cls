public class ValidateInvoice {

    @InvocableMethod( label='Send Invoice for Validation Check' )
    public static void validateInvoiceForYaypaySyncRequest(List<Id> invoiceIds){
        List<inscor__Invoice__c> relatedInvoices = [SELECT Id, Name, inscor__Account__c, inscor__Billing_Contact__c, inscor__Customer_PO_Number__c,
                                        inscor__Billing_Contact__r.Email, inscor__Account__r.Id, inscor__Invoice_Date__c, 
                                        inscor__Billing_Contact__r.Id, inscor__Status__c, inscor__Total_Invoice__c, YayPay_Last_Sync_Date__c,
                                        inscor__Account__r.inscor__Billing_Contact__r.Email, 
                                        inscor__Account_Terms__r.inscor__Number_of_Days__c,
                                        ( SELECT Id, Name, inscor__Quantity__c, inscor__Price__c, inscor__Item__r.inscor__Description__c,
                                         inscor__Item__r.Name, inscor__Extended_Price__c FROM inscor__Invoice_Lines__r ),
                                        ( SELECT Id, Name, inscor__Receivable_Amount__c, inscor__External_Reference_ID__c,
                                         inscor__INVC_Date__c, inscor__Line_Value__c, inscor__INVC__r.Id, inscor__Customer_Vendor__r.Id
                                         FROM inscor__Transaction_Activities__r )
                                        FROM  inscor__Invoice__c
                                        WHERE Id IN :invoiceIds ];
        if(!relatedInvoices.isEmpty()){
            inscor__Invoice__c invoiceObj = relatedInvoices.get(0);
            String errorString = BatchProcessInvoiceToYayPay.validateInvoiceRequest(relatedInvoices.get(0));
            if(String.isNotBlank(errorString)){
                invoiceObj.Is_Error__c = true;
                invoiceObj.YayPay_Error_Message__c = errorString;
                InvoiceTriggerHelper.TriggerDisabled = true;
                update invoiceObj;
                InvoiceTriggerHelper.TriggerDisabled = false;
            }
        }
    }
}