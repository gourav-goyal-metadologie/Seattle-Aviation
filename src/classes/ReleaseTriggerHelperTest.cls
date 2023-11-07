/**************************************************************************************************
Description: Trigger class for inscor__Release__c that will handle all types of trigger events Test Methods.
====================================================================================================
====================================================================================================
Class: ReleaseTriggerHelperTest
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		05/29/2021		    Gourav Goyal				Initial Creation     
***************************************************************************************************/
@isTest
private class ReleaseTriggerHelperTest {
    
    public static final Integer COUNT_LIMIT = 10;
    
    @TestSetup
    private static void setup() {
        
        
        Test.setMock(HttpCalloutMock.class, new ComplianceMockResponseGenerator());
        Compliance_Configuration__c complianceConfigSetting = Compliance_Configuration__c.getOrgDefaults();   
        complianceConfigSetting.EndPoint__c = 'https://text-azservices.ecustoms.com/edwinimport/EdwinImportPortal.asmx';
        complianceConfigSetting.Shipment_Status_Action__c = 'http://test-tempuri.org/GetShipmentStatus';
        complianceConfigSetting.Upload_File_Action__c = 'http://test-tempuri.org/Uploadfile';
        complianceConfigSetting.Is_Integration_Enable__c = true;
        upsert complianceConfigSetting;
        
        //Create a Account for Customer
        Account accRec = new Account();
        accRec.Name = 'TEST';
        accRec.inscor__Account_Number__c = '2';  
        insert accRec;
        
        Contact conRec = new Contact();
        conRec.LastName = 'TEST';
        conRec.Email = 'test@test.com';
        conRec.Phone = '+(011) 23400-0000';
        conRec.AccountId = accRec.Id;
        insert conRec;
        
        List<Account> accList = new List<Account>([SELECT Id,Name FROM Account LIMIT 1]);
        List<inscor__Customer_Quote__c> customerQuoteToInsertList = new List<inscor__Customer_Quote__c>();
        List<inscor__Customer_Quote_Line__c> customerQuoteLineToInsertList = new List<inscor__Customer_Quote_Line__c>();
        
        inscor__Company__c  company = new inscor__Company__c(
            inscor__Address_1__c = '1111', inscor__City__c = '1111', inscor__Company_Name__c = '1111', inscor__Zip_Code__c = '1111');
        insert company;
        inscor__Company_Location__c companyLoc = new inscor__Company_Location__c( inscor__Company__c =company.Id );
        insert companyLoc;
        
        inscor__Inventory_Location__c invLocation  = new inscor__Inventory_Location__c(
            inscor__Company_Location__c = companyLoc.Id );
        insert invLocation;
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Customer_Quote__c customerQuoteRec = new inscor__Customer_Quote__c();
            customerQuoteRec.inscor__Customer__c = accList[0].Id;
            customerQuoteRec.inscor__Company__c = company.Id;
            customerQuoteRec.inscor__Status__c = 'New';
            customerQuoteToInsertList.add(customerQuoteRec);
        }
        insert customerQuoteToInsertList;
        List<Opportunity> oppList = new List<Opportunity>([SELECT Id FROM Opportunity]);
        //system.assertEquals(oppList.size(), COUNT_LIMIT);
        Product2 productRec = new Product2(Name = 'Laptop X200', 
                                           Family = 'Hardware', inscor__Keyword__c ='test');
        insert productRec;
        
        for(inscor__Customer_Quote__c quoteRec : customerQuoteToInsertList){
            for(Integer i = 0; i< COUNT_LIMIT; i++) { 
                inscor__Customer_Quote_Line__c qouteLineRec = new inscor__Customer_Quote_Line__c();
                qouteLineRec.inscor__Customer_Quote__c = quoteRec.Id;
                qouteLineRec.inscor__Quantity__c = 10;
                qouteLineRec.inscor__Product__c = productRec.Id;
                qouteLineRec.inscor__Business_Category__c = 'Distribution';
                qouteLineRec.inscor__Quote_Type__c = 'No Quote';
                customerQuoteLineToInsertList.add(qouteLineRec);
            }  
        }
        //System.assert( false, productRec.Name + 'test--->'+ customerQuoteLineToInsertList.get(0).inscor__Customer_Part_Number__c );
        insert customerQuoteLineToInsertList;
        inscor__Condition_Code__c conditionCode = new inscor__Condition_Code__c(Name ='Condition Code 1', inscor__Show_in_Summary__c = false);
        insert conditionCode;
        
        inscor__Ship_Method__c shipMethod = new inscor__Ship_Method__c();
        shipMethod.Name ='FedEx ship via Freight';
        shipMethod.inscor__Company__c = company.Id;
        insert shipMethod;
    }
    
    @isTest
    static void triggerTest() {
        Test.setMock(HttpCalloutMock.class, new ComplianceMockResponseGenerator());
        Account accRec = [SELECT Id,Name FROM Account LIMIT 1];
        Contact conRec = [SELECT Id,Name FROM Contact LIMIT 1];
        inscor__Company__c company = [SELECT Id,Name FROM inscor__Company__c LIMIT 1];
        Product2 productRec = [ SELECT Id FROM Product2 LIMIT 1 ];
        inscor__Customer_Quote__c customerQuoteRec = new inscor__Customer_Quote__c();
        customerQuoteRec.inscor__Customer__c = accRec.Id;
        customerQuoteRec.inscor__Status__c = 'New';
        customerQuoteRec.inscor__Company__c = company.Id;
        insert customerQuoteRec;
        
        inscor__Sales_Order__c salesOrderRec = new inscor__Sales_Order__c();
        salesOrderRec.inscor__Quote_Number__c = customerQuoteRec.Id;
        salesOrderRec.inscor__Customer__c = accRec.Id;
        salesOrderRec.inscor__Contact__c = conRec.Id;
        salesOrderRec.inscor__Company__c = company.Id;
        insert salesOrderRec;
        
        inscor__Condition_Code__c conditionCode = [SELECT Id,Name FROM inscor__Condition_Code__c LIMIT 1];
        
        inscor__Sales_Order_Line__c salesOrderLineRec = new inscor__Sales_Order_Line__c();
        salesOrderLineRec.inscor__Order__c = salesOrderRec.Id;
        salesOrderLineRec.inscor__Condition_Code__c = conditionCode.Id;
        salesOrderLineRec.inscor__Quantity_Ordered__c = 10;
        salesOrderLineRec.inscor__Product__c = productRec.Id;
        insert salesOrderLineRec;
        
        inscor__Account_Ship_Address__c addRec = new inscor__Account_Ship_Address__c();
        addRec.inscor__Country__c = 'india';
        insert addRec;
        
        inscor__Release__c releaseRec = new inscor__Release__c();
        releaseRec.inscor__Ship_To_Address__c = addRec.Id;
        releaseRec.inscor__Sales_Order__c = salesOrderRec.Id;
        releaseRec.inscor__Status__c = 'In QC';
        releaseRec.Receivers_Email__c = 'mailTest@yue.com';
        insert releaseRec;
        
        //System.assert( false, [Select Id, Compliance_Response__c from inscor__Release__c where Id =: releaseRec.Id].get(0).Compliance_Response__c );
        system.assertEquals(1, [Select Id from inscor__Release__c where Id =: releaseRec.Id].size());
        releaseRec.inscor__Status__c = 'In_Picking';
        update releaseRec;
        releaseRec.inscor__Status__c = 'In QC';
        update releaseRec;
        delete releaseRec; 
        undelete releaseRec;
    }
    
    @isTest
    static void triggerTest02() {
        Test.setMock(HttpCalloutMock.class, new ComplianceMockResponseGenerator());
        Account accRec = [SELECT Id,Name FROM Account LIMIT 1];
        Contact conRec = [SELECT Id,Name FROM Contact LIMIT 1];
        inscor__Company__c company = [SELECT Id,Name FROM inscor__Company__c LIMIT 1];
        Product2 productRec = [ SELECT Id FROM Product2 LIMIT 1 ];
        inscor__Customer_Quote__c customerQuoteRec = new inscor__Customer_Quote__c();
        customerQuoteRec.inscor__Customer__c = accRec.Id;
        customerQuoteRec.inscor__Status__c = 'New';
        customerQuoteRec.inscor__Company__c = company.Id;
        insert customerQuoteRec;
        
        inscor__Sales_Order__c salesOrderRec = new inscor__Sales_Order__c();
        salesOrderRec.inscor__Quote_Number__c = customerQuoteRec.Id;
        salesOrderRec.inscor__Customer__c = accRec.Id;
        salesOrderRec.inscor__Contact__c = conRec.Id;
        salesOrderRec.inscor__Company__c = company.Id;
        insert salesOrderRec;
        
        inscor__Condition_Code__c conditionCode = [SELECT Id,Name FROM inscor__Condition_Code__c LIMIT 1];
        
        inscor__Sales_Order_Line__c salesOrderLineRec = new inscor__Sales_Order_Line__c();
        salesOrderLineRec.inscor__Order__c = salesOrderRec.Id;
        salesOrderLineRec.inscor__Condition_Code__c = conditionCode.Id;
        salesOrderLineRec.inscor__Quantity_Ordered__c = 10;
        salesOrderLineRec.inscor__Product__c = productRec.Id;
        insert salesOrderLineRec;
        
        inscor__Account_Ship_Address__c addRec = new inscor__Account_Ship_Address__c();
        insert addRec;
        
        inscor__Release__c releaseRec = new inscor__Release__c();
        releaseRec.inscor__Ship_To_Address__c = addRec.Id;
        releaseRec.inscor__Sales_Order__c = salesOrderRec.Id;
        releaseRec.inscor__Status__c = 'In QC';
        releaseRec.Receivers_Email__c = 'mailTest@yue.com';
        insert releaseRec;
        
        //System.assert( false, [Select Id, Compliance_Response__c from inscor__Release__c where Id =: releaseRec.Id].get(0).Compliance_Response__c );
        system.assertEquals(1, [Select Id from inscor__Release__c where Id =: releaseRec.Id].size());
        releaseRec.inscor__Status__c = 'In_Picking';
        update releaseRec;
        releaseRec.inscor__Status__c = 'In QC';
        update releaseRec;
        delete releaseRec; 
        undelete releaseRec;
    }
    
    @isTest
    private static void sendEmailOnReleaseStatusInvoicedTest() {
        try{
            Product2 productRec = [ SELECT Id FROM Product2 LIMIT 1 ];
            List<Account> accList = new List<Account>([SELECT Id,Name FROM Account LIMIT 1]);
            List<Contact> conList = new List<Contact>([SELECT Id,Name FROM Contact LIMIT 1]);
            inscor__Condition_Code__c conditionCode = [SELECT Id,Name FROM inscor__Condition_Code__c LIMIT 1];
            List<inscor__Customer_Quote__c> customerQuoteList = new List<inscor__Customer_Quote__c>([SELECT Id FROM inscor__Customer_Quote__c]);
            List<inscor__Sales_Order__c> salesOrderToInsertList = new List<inscor__Sales_Order__c>();
            Test.startTest();
            for(Integer i = 0; i< COUNT_LIMIT; i++) {
                inscor__Sales_Order__c salesOrderRec = new inscor__Sales_Order__c();
                salesOrderRec.inscor__Quote_Number__c = customerQuoteList[i].Id;
                salesOrderRec.inscor__Customer__c = accList[0].Id;
                salesOrderRec.inscor__Contact__c = conList[0].Id;
                salesOrderToInsertList.add(salesOrderRec);
            }
            insert salesOrderToInsertList;  
            system.assertEquals(salesOrderToInsertList.size(), COUNT_LIMIT);
            List<inscor__Sales_Order_Line__c> salesOrderLineToInsertList = new List<inscor__Sales_Order_Line__c>();
            for(Integer i = 0; i< COUNT_LIMIT; i++) {
                inscor__Sales_Order_Line__c salesOrderLineRec = new inscor__Sales_Order_Line__c();
                salesOrderLineRec.inscor__Order__c = salesOrderToInsertList[i].Id;
                salesOrderLineRec.inscor__Condition_Code__c = conditionCode.Id;
                salesOrderLineRec.inscor__Quantity_Ordered__c = 10;
                salesOrderLineRec.inscor__Product__c = productRec.Id;
                salesOrderLineToInsertList.add(salesOrderLineRec);
            }
            insert salesOrderLineToInsertList;
            inscor__Account_Ship_Address__c addRec = new inscor__Account_Ship_Address__c();
            insert addRec;
            List<inscor__Release__c> releaseListToInsert = new List<inscor__Release__c>();
            for(Integer i = 0; i< COUNT_LIMIT; i++) {
                inscor__Release__c releaseRec = new inscor__Release__c();
                releaseRec.inscor__Ship_To_Address__c = addRec.Id;
                releaseRec.inscor__Sales_Order__c = salesOrderToInsertList[i].Id;
                releaseRec.inscor__Status__c = 'Invoiced';
                releaseRec.inscor__Country__c = 'india';
                releaseRec.Receivers_Email__c = 'mailTest'+i+'@yue.com';
                releaseListToInsert.add(releaseRec);
            }
            insert releaseListToInsert;
            system.assertEquals(releaseListToInsert.size(), COUNT_LIMIT);
            for(inscor__Release__c relRec : releaseListToInsert) {
                relRec.inscor__Status__c = 'In QC';
            }
            update releaseListToInsert;
            ContentVersion contentVersion = new ContentVersion(
                Title = 'Penguins',
                PathOnClient = 'Penguins.jpg',
                VersionData = Blob.valueOf('Test Content'),
                IsMajorVersion = true
            );
            insert contentVersion;
            /**Content Insertion */
            List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
            //create ContentDocumentLink  record
            List<ContentDocumentLink> cdlList = new List<ContentDocumentLink>();
            for(inscor__Release__c relRec : releaseListToInsert) { 
                ContentDocumentLink cdl = New ContentDocumentLink();
                cdl.LinkedEntityId = relRec.id;
                cdl.ContentDocumentId = documents[0].Id;
                cdl.shareType = 'V';
                cdlList.add(cdl);
            }
            insert cdlList;
            
            for(inscor__Release__c relRec : releaseListToInsert) {
                relRec.inscor__Status__c = 'Invoiced';
            }
            update releaseListToInsert;
            Test.stopTest();
        }catch( exception e ){
            
        }
    }
    
    @isTest
    private static void sendEmailOnReleaseStatusInvoicedNegativeTest() {
        try{
            Product2 productRec = [ SELECT Id FROM Product2 LIMIT 1 ];
            List<Account> accList = new List<Account>([SELECT Id,Name FROM Account LIMIT 1]);
            List<Contact> conList = new List<Contact>([SELECT Id,Name FROM Contact LIMIT 1]);
            inscor__Company__c company = [SELECT Id,Name FROM inscor__Company__c LIMIT 1];
            List<inscor__Ship_Method__c> shipTo = new List<inscor__Ship_Method__c>([SELECT Id,Name FROM inscor__Ship_Method__c LIMIT 1]);
            List<User> currentUser = new List<User>([SELECT Id,Name FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1]);
            inscor__Condition_Code__c conditionCode = [SELECT Id,Name FROM inscor__Condition_Code__c LIMIT 1];
            List<inscor__Customer_Quote__c> customerQuoteList = new List<inscor__Customer_Quote__c>([SELECT Id FROM inscor__Customer_Quote__c]);
            List<inscor__Sales_Order__c> salesOrderToInsertList = new List<inscor__Sales_Order__c>();
            Test.startTest();
            for(Integer i = 0; i< COUNT_LIMIT; i++) {
                inscor__Sales_Order__c salesOrderRec = new inscor__Sales_Order__c();
                salesOrderRec.inscor__Quote_Number__c = customerQuoteList[i].Id;
                salesOrderRec.inscor__Customer__c = accList[0].Id;
                salesOrderRec.inscor__Contact__c = conList[0].Id;
                salesOrderRec.inscor__Billing_Contact__c = conList[0].Id;
                salesOrderRec.inscor__Customer_PO_Number__c = 'Cust. PO# 11';   
                salesOrderRec.inscor__Company__c = company.Id;
                salesOrderRec.inscor__Assigned_To__c = currentUser[0].Id;
                salesOrderToInsertList.add(salesOrderRec);
            }
            insert salesOrderToInsertList;  
            system.assertEquals(salesOrderToInsertList.size(), COUNT_LIMIT);
            List<inscor__Sales_Order_Line__c> salesOrderLineToInsertList = new List<inscor__Sales_Order_Line__c>();
            for(Integer i = 0; i< COUNT_LIMIT; i++) {
                inscor__Sales_Order_Line__c salesOrderLineRec = new inscor__Sales_Order_Line__c();
                salesOrderLineRec.inscor__Order__c = salesOrderToInsertList[i].Id;
                salesOrderLineRec.inscor__Condition_Code__c = conditionCode.Id;
                salesOrderLineRec.inscor__Quantity_Ordered__c = 10;
                salesOrderLineRec.inscor__Product__c = productRec.Id;
                salesOrderLineToInsertList.add(salesOrderLineRec);
            }
            insert salesOrderLineToInsertList;
            inscor__Account_Ship_Address__c addRec = new inscor__Account_Ship_Address__c();
            insert addRec;
            List<inscor__Release__c> releaseListToInsert = new List<inscor__Release__c>();
            for(Integer i = 0; i< COUNT_LIMIT; i++) {
                inscor__Release__c releaseRec = new inscor__Release__c();
                releaseRec.inscor__Ship_To_Address__c = addRec.Id;
                releaseRec.inscor__Sales_Order__c = salesOrderToInsertList[i].Id;
                releaseRec.inscor__Status__c = 'Invoiced';
                releaseRec.inscor__Country__c = 'india';
                releaseRec.Receivers_Email__c = 'mailTest'+i+'@yue.com';
                releaseRec.inscor__Shipped_Method__c = shipTo[0].Id;
                releaseListToInsert.add(releaseRec);
            }
            insert releaseListToInsert;
            system.assertEquals(releaseListToInsert.size(), COUNT_LIMIT);
            for(inscor__Release__c relRec : releaseListToInsert) {
                relRec.inscor__Status__c = 'In QC';
            }
            update releaseListToInsert;
            ContentVersion contentVersion = new ContentVersion(
                Title = 'Penguins',
                PathOnClient = 'Penguins.jpg',
                VersionData = Blob.valueOf('Test Content'),
                IsMajorVersion = true
            );
            insert contentVersion;
            /**Content Insertion */
            List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
            //create ContentDocumentLink  record
            List<ContentDocumentLink> cdlList = new List<ContentDocumentLink>();
            for(inscor__Release__c relRec : releaseListToInsert) { 
                ContentDocumentLink cdl = New ContentDocumentLink();
                cdl.LinkedEntityId = relRec.id;
                cdl.ContentDocumentId = documents[0].Id;
                cdl.shareType = 'V';
                cdlList.add(cdl);
            }
            insert cdlList;
            
            for(inscor__Release__c relRec : releaseListToInsert) {
                relRec.inscor__Status__c = 'Invoiced';
            }
            update releaseListToInsert;
            list<inscor__Release__c> releaseList = [ SELECT Id FROM inscor__Release__c WHERE inscor__Status__c = 'Invoiced' LIMIT 1 ];
            
            ReleaseBusinessUtility.sendInvoiceEmails(new List<Id>{ releaseList.get(0).Id });
        }catch( exception e ){
        }
    }
    
    @isTest
    public static void triggerDisabledFlagTest() { 
        //Trigger Disabled Coverage
        Trigger_Configuration__c tc = new Trigger_Configuration__c();
        tc.Release_Trigger_Disable__c  = TRUE;
        insert tc;
        Product2 productRec = [ SELECT Id FROM Product2 LIMIT 1 ];
        inscor__Company__c company = [SELECT Id,Name FROM inscor__Company__c LIMIT 1];
        List<Account> accList = new List<Account>([SELECT Id,Name FROM Account LIMIT 1]);
        inscor__Condition_Code__c conditionCode = [SELECT Id,Name FROM inscor__Condition_Code__c LIMIT 1];
        List<inscor__Customer_Quote__c> customerQuoteList = new List<inscor__Customer_Quote__c>([SELECT Id FROM inscor__Customer_Quote__c]);
        List<inscor__Sales_Order__c> salesOrderToInsertList = new List<inscor__Sales_Order__c>();
        Test.startTest();
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Sales_Order__c salesOrderRec = new inscor__Sales_Order__c();
            salesOrderRec.inscor__Quote_Number__c = customerQuoteList[i].Id;
            salesOrderRec.inscor__Customer__c = accList[0].Id;
            salesOrderRec.inscor__Company__c = company.Id;
            salesOrderToInsertList.add(salesOrderRec);
        }
        insert salesOrderToInsertList;  
        system.assertEquals(salesOrderToInsertList.size(), COUNT_LIMIT);
        List<inscor__Sales_Order_Line__c> salesOrderLineToInsertList = new List<inscor__Sales_Order_Line__c>();
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Sales_Order_Line__c salesOrderLineRec = new inscor__Sales_Order_Line__c();
            salesOrderLineRec.inscor__Order__c = salesOrderToInsertList[i].Id;
            salesOrderLineRec.inscor__Condition_Code__c = conditionCode.Id;
            salesOrderLineRec.inscor__Quantity_Ordered__c = 10;
            salesOrderLineRec.inscor__Product__c = productRec.Id;
            salesOrderLineToInsertList.add(salesOrderLineRec);
        }
        insert salesOrderLineToInsertList;
        inscor__Account_Ship_Address__c addRec = new inscor__Account_Ship_Address__c();
        insert addRec;
        List<inscor__Release__c> releaseListToInsert = new List<inscor__Release__c>();
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Release__c releaseRec = new inscor__Release__c();
            releaseRec.inscor__Ship_To_Address__c = addRec.Id;
            releaseRec.inscor__Country__c = 'india';
            releaseRec.inscor__Sales_Order__c = salesOrderToInsertList[i].Id;
            releaseRec.inscor__Status__c = 'Invoiced';
            releaseRec.Receivers_Email__c = 'mailTest'+i+'@yue.com';
            releaseListToInsert.add(releaseRec);
        }
        insert releaseListToInsert;
        system.assertEquals(releaseListToInsert.size(), COUNT_LIMIT);
        Test.StopTest();
    }    
    @isTest
    private static void sendEmailOnReleaseStatusInvoicedNegativeTest02() {
        Product2 productRec = [ SELECT Id FROM Product2 LIMIT 1 ];
        List<Account> accList = new List<Account>([SELECT Id,Name FROM Account LIMIT 1]);
        List<Contact> conList = new List<Contact>([SELECT Id,Name FROM Contact LIMIT 1]);
        inscor__Company__c company = [SELECT Id,Name FROM inscor__Company__c LIMIT 1];
        List<inscor__Ship_Method__c> shipTo = new List<inscor__Ship_Method__c>([SELECT Id,Name FROM inscor__Ship_Method__c LIMIT 1]);
        List<User> currentUser = new List<User>([SELECT Id,Name FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1]);
        inscor__Condition_Code__c conditionCode = [SELECT Id,Name FROM inscor__Condition_Code__c LIMIT 1];
        List<inscor__Customer_Quote__c> customerQuoteList = new List<inscor__Customer_Quote__c>([SELECT Id FROM inscor__Customer_Quote__c]);
        List<inscor__Sales_Order__c> salesOrderToInsertList = new List<inscor__Sales_Order__c>();
        Test.startTest();
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Sales_Order__c salesOrderRec = new inscor__Sales_Order__c();
            salesOrderRec.inscor__Quote_Number__c = customerQuoteList[i].Id;
            salesOrderRec.inscor__Customer__c = accList[0].Id;
            salesOrderRec.inscor__Contact__c = conList[0].Id;
            salesOrderRec.inscor__Billing_Contact__c = conList[0].Id;
            salesOrderRec.inscor__Customer_PO_Number__c = 'Cust. PO# 11';   
            salesOrderRec.inscor__Company__c = company.Id;
            salesOrderRec.inscor__Assigned_To__c = currentUser[0].Id;
            salesOrderToInsertList.add(salesOrderRec);
        }
        insert salesOrderToInsertList;  
        system.assertEquals(salesOrderToInsertList.size(), COUNT_LIMIT);
        List<inscor__Sales_Order_Line__c> salesOrderLineToInsertList = new List<inscor__Sales_Order_Line__c>();
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Sales_Order_Line__c salesOrderLineRec = new inscor__Sales_Order_Line__c();
            salesOrderLineRec.inscor__Order__c = salesOrderToInsertList[i].Id;
            salesOrderLineRec.inscor__Condition_Code__c = conditionCode.Id;
            salesOrderLineRec.inscor__Quantity_Ordered__c = 10;
            salesOrderLineRec.inscor__Product__c = productRec.Id;
            salesOrderLineToInsertList.add(salesOrderLineRec);
        }
        insert salesOrderLineToInsertList;
        inscor__Account_Ship_Address__c addRec = new inscor__Account_Ship_Address__c();
        insert addRec;
        List<inscor__Release__c> releaseListToInsert = new List<inscor__Release__c>();
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Release__c releaseRec = new inscor__Release__c();
            releaseRec.inscor__Ship_To_Address__c = addRec.Id;
            releaseRec.inscor__Sales_Order__c = salesOrderToInsertList[i].Id;
            releaseRec.inscor__Status__c = 'Invoiced';
            releaseRec.inscor__Country__c = 'india';
            releaseRec.Receivers_Email__c = 'mailTest'+i+'@yue.com';
            releaseRec.inscor__Ship_Method__c = shipTo[0].Id;
            releaseRec.inscor__AWB__c = 'test';
            releaseListToInsert.add(releaseRec);
        }
        insert releaseListToInsert;
        system.assertEquals(releaseListToInsert.size(), COUNT_LIMIT);
        for(inscor__Release__c relRec : releaseListToInsert) {
            relRec.inscor__Status__c = 'In QC';
        }
        update releaseListToInsert;
        
        for(inscor__Release__c relRec : releaseListToInsert) {
            relRec.inscor__Status__c = 'Invoiced';
        }
        update releaseListToInsert;
        list<inscor__Release__c> releaseList = [ SELECT Id FROM inscor__Release__c WHERE inscor__Status__c = 'Invoiced' LIMIT 1 ];
        
        ReleaseBusinessUtility.sendInvoiceEmails(new List<Id>{ releaseList.get(0).Id });
    }
}