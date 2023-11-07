@isTest
public class CoreExchangeFormResponsePDFCtrlTest {
	@testSetup
    public static void setupData(){
        
        inscor__Company__c companyInstance = new inscor__Company__c();
        companyInstance.inscor__Company_Name__c = 'inscor Company' ;
        companyInstance.inscor__Address_1__c = 'address';
        companyInstance.inscor__City__c = 'xyz';
        companyInstance.inscor__Zip_Code__c = '21321';
        insert companyInstance;
        
        Customer_Exchange_Summary_Form_Response__c exchangeSummaryInstance = new Customer_Exchange_Summary_Form_Response__c();
        exchangeSummaryInstance.Name__c = 'er';
        insert exchangeSummaryInstance;
        
        }
    
    @isTest
    static void insertRecord(){
        List<Customer_Exchange_Summary_Form_Response__c> CustomerExchangeSummaryFormResponseList = [SELECT Id from Customer_Exchange_Summary_Form_Response__c];
        System.debug('Customer_Exchange_Summary_Form_Response__c->' + CustomerExchangeSummaryFormResponseList);
        Test.startTest();
        PageReference coreExchangeFormResponsePage = Page.coreExchangeFormResponsePDF;
        Test.setCurrentPage(coreExchangeFormResponsePage);
        coreExchangeFormResponsePage.getParameters().put('id', CustomerExchangeSummaryFormResponseList[0].Id);
        
         ApexPages.StandardController sc = new ApexPages.StandardController(CustomerExchangeSummaryFormResponseList[0]);
        try{
           CoreExchangeFormResponsePDFCtrl ext = new CoreExchangeFormResponsePDFCtrl();
        }catch(Exception e){
            System.debug(e);
        }         
       
         Test.stopTest();
    }
    @isTest
    static void testGetCurrentPageReference(){
        Test.startTest();
        CoreExchangeFormResponsePDFCtrl.getCurrentPageReference();
          Test.stopTest();
    }
}