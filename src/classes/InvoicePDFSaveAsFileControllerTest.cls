@isTest
public class InvoicePDFSaveAsFileControllerTest {
    @testSetup static void setupData() {
		inscor__Invoice__c invoiceInstance = new inscor__Invoice__c();
        invoiceInstance.inscor__City__c = 'Jaipur';
        insert invoiceInstance;
        
        inscor__Invoice_Line__c invoiceLineInstance= new inscor__Invoice_Line__c();
        invoiceLineInstance.inscor__Invoice__c = invoiceInstance.Id;
        insert invoiceLineInstance;
        
        inscor__Company__c companyInstance = new inscor__Company__c();
        companyInstance.inscor__Company_Name__c = 'inscor Company' ;
        companyInstance.inscor__Address_1__c = 'address';
        companyInstance.inscor__City__c = 'xyz';
        companyInstance.inscor__Zip_Code__c = '21321';
        insert companyInstance;
        
        inscor__Form_Options__c formOption = new inscor__Form_Options__c();
        formOption.name = 'Invoice';
        formOption.inscor__Footer__c = 'test footer';
        formOption.inscor__Company__c = companyInstance.Id;
        insert formOption;
	}
    
    @isTest 
    static void insertRecord(){
    	
        List<inscor__Invoice__c> invoices = [SELECT Id FROM inscor__Invoice__c];
        System.debug('invoices->' + invoices);
        Test.startTest();
        	PageReference testPage = Page.InvoicePDFSaveAsFile; 
           Test.setCurrentPage(testPage);
           testPage.getParameters().put('Id', invoices[0].Id);
        
           ApexPages.StandardController sc = new  ApexPages.StandardController(invoices[0]);
        try{
           InvoicePDFSaveAsFileController ext = new InvoicePDFSaveAsFileController(sc);
        }catch(Exception e){
            System.debug(e);
        }         
       
         Test.stopTest();
    }
}