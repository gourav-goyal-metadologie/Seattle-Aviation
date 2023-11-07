/**************************************************************************************************
Description: test class used to test apex class CommonUtility
====================================================================================================
====================================================================================================
TestClass: 
Code Coverage: 
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		10/14/2021		   Vinod Kumar Sharma       		Initial Creation   
***************************************************************************************************/
@IsTest
private class CommonUtilityTest {
    public static final Integer COUNT_LIMIT = 5;

    @TestSetup
    static void setupTestData(){
        Account accRec = new Account();
        accRec.Name = 'Customer 101';
        accRec.inscor__Account_Number__c = '2';  
        insert accRec;

        Contact conRec = new Contact();
        conRec.FirstName = 'Customer';
        conRec.LastName = 'Contact 101';
        conRec.Email = 'customercontact101@xyz.com';
        conRec.AccountId = accRec.Id;
        insert conRec;
        
        inscor__Company__c  company = new inscor__Company__c(inscor__Address_1__c = '1111', inscor__City__c = '1111', inscor__Company_Name__c = '1111', inscor__Zip_Code__c = '1111');
        insert company;
        
        Product2 productRec = new Product2(Name = 'Laptop X200', 
                                           Family = 'Hardware', 
                                           inscor__Keyword__c ='test',
                                           inscor__Description__c = 'Test Description');
        insert productRec;
        
        inscor__Customer_Quote__c customerQuoteRec = new inscor__Customer_Quote__c();
        customerQuoteRec.inscor__Customer__c = accRec.Id;
        customerQuoteRec.inscor__Status__c = 'New';
        customerQuoteRec.inscor__Company__c = company.Id;
        insert customerQuoteRec;
        
        inscor__Sales_Order__c salesOrderRec = new inscor__Sales_Order__c();
        salesOrderRec.inscor__Quote_Number__c = customerQuoteRec.Id;
        salesOrderRec.inscor__Customer__c = accRec.Id;
        salesOrderRec.inscor__Customer_PO_Number__c = '122345';
        salesOrderRec.inscor__Contact__c = conRec.Id;
        salesOrderRec.inscor__Company__c = company.Id;
        insert salesOrderRec;
        
        inscor__Condition_Code__c conditionCode = new inscor__Condition_Code__c(Name ='Condition Code 1', inscor__Show_in_Summary__c = false);
        insert conditionCode;
        
        inscor__Sales_Order_Line__c salesOrderLineRec = new inscor__Sales_Order_Line__c();
        salesOrderLineRec.inscor__Order__c = salesOrderRec.Id;
        salesOrderLineRec.inscor__Condition_Code__c = conditionCode.Id;
        salesOrderLineRec.inscor__Quantity_Ordered__c = 10;
        salesOrderLineRec.inscor__Product__c = productRec.Id;
        insert salesOrderLineRec;
        
        inscor__Account_Ship_Address__c addRec = new inscor__Account_Ship_Address__c();
        insert addRec;

        inscor__Ship_Method__c shipMethod = new inscor__Ship_Method__c(Name='FeDex',inscor__Company__c = company.Id);
        insert shipMethod;
        
        inscor__Release__c releaseRec = new inscor__Release__c();
        releaseRec.inscor__Ship_To_Address__c = addRec.Id;
        releaseRec.inscor__Sales_Order__c = salesOrderRec.Id;
        releaseRec.inscor__Status__c = 'In QC';
        releaseRec.Receivers_Email__c = 'mailTest@yue.com';
        releaseRec.inscor__AWB__c = '198w72345';
        releaseRec.inscor__Ship_Method__c = shipMethod.Id;
        insert releaseRec;

        inscor__Customer_Exchange_Summary__c customerExchangeSummary = new inscor__Customer_Exchange_Summary__c();
        customerExchangeSummary.inscor__Original_SO_ID__c = salesOrderRec.Id;
        customerExchangeSummary.inscor__Original_SO_Line__c = salesOrderLineRec.Id;
        customerExchangeSummary.inscor__Original_Core_Due_Date__c = System.today();
        customerExchangeSummary.inscor__Exchange_Status__c = Constants.CUSTOMER_EXCHANGE_SUMMARY_EXCHANGE_STATUS_SHIPPED;
        customerExchangeSummary.inscor__Original_Product__c = productRec.Id;
        insert customerExchangeSummary;
    }

    @IsTest
    static void testSendEmail(){
        
        Test.startTest();
        String emailBody = '(Cust. PO#)' + '-' + '(SO#)' + '-' + '(Ship Via)';
        
        EmailTemplate template = new EmailTemplate (developerName = 'test', FolderId = userInfo.getUserId(), TemplateType= 'Text', Name = 'test');
        template.HtmlValue = '<h1> test </h1>';
        template.body = emailBody;
        insert template;
        inscor__Release__c releaseRec = [SELECT Id FROM inscor__Release__c limit 1];
        Map<ID, List<String>> idToAddressMap = new Map<ID, List<String>>();
        idToAddressMap.put(releaseRec.Id, new List<String>{'test@test.com'});
        Map<ID, List<String>> idCCAddressMap = new Map<ID, List<String>>();
        idToAddressMap.put(releaseRec.Id, new List<String>{'test1@test.com'});
        CommonUtility.sendEmail(template.Id, idToAddressMap, idCCAddressMap, null, null );
        Test.stopTest();
        
    }

    @IsTest
    static void testSetMergeFields(){
        
        Test.startTest();
        inscor__Release__c releaseRec = [SELECT Id, inscor__Sales_Order__r.inscor__Customer_PO_Number__c,
                                         inscor__Sales_Order__r.Name, inscor__Ship_Method__r.Name, inscor__AWB__c,
                                         inscor__Sales_Order__r.inscor__Assigned_To__r.Name, inscor__Sales_Order__r.inscor__Assigned_To__r.Email
                                        FROM inscor__Release__c limit 1];
        String emailBody = '(Cust. PO#)' + '-' + '(SO#)' + '-' + '(Ship Via)';
        CommonUtility.setMergeFields( emailBody, releaseRec);
        Test.stopTest();
    }
    
    

    @IsTest
    static void testSetMergeFields02(){
        
        Test.startTest();
        inscor__Release__c releaseRec = [SELECT Id, inscor__Sales_Order__r.inscor__Customer_PO_Number__c,
                                         inscor__Sales_Order__r.Name, inscor__Ship_Method__r.Name, inscor__AWB__c,
                                         inscor__Sales_Order__r.inscor__Assigned_To__r.Name, inscor__Sales_Order__r.inscor__Assigned_To__r.Email
                                        FROM inscor__Release__c limit 1];
        String emailBody = '(Cust.PO#)' + '-' + '(SO#)' + '-' + '(Ship Via)';
        CommonUtility.setMergeFields( emailBody, releaseRec);
        Test.stopTest();
    }

    @IsTest
    static void TestSendEmailForCustomerExchangeSummary(){
        
        Test.startTest();
        String emailTemplateId = [SELECT Id FROM EmailTemplate 
                                            WHERE DeveloperName = :Constants.EMAIL_TEMPLATE_DUE_DATE_DAY 
                                            LIMIT 1]?.Id;
        inscor__Customer_Exchange_Summary__c exchangeSummary = [SELECT Id FROM inscor__Customer_Exchange_Summary__c LIMIT 1];
        CommonUtility.sendEmailForCustomerExchangeSummary(emailTemplateId, new Map<Id, List<String>>{exchangeSummary.Id => new List<String>{'test@test.com'}} , null, null);
        Test.stopTest();
    }
}