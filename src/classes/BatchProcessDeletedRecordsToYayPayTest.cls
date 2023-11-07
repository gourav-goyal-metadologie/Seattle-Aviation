@isTest
public class BatchProcessDeletedRecordsToYayPayTest {
	
    @testSetup()
    private static void setup(){
        Test.setMock(HttpCalloutMock.class, new YayPayMockResponseGenerator());
        // —— DATA PREPARATION ——
        // insert 1 Account
        //Account acct = new Account(Name = 'Test Account');
        //insert acct;
        
        
        // insert 6 billing formats
        AcctSeed__Billing_Format__c[] PDFformats = new List<AcctSeed__Billing_Format__c>();
        PDFformats.add(
            new AcctSeed__Billing_Format__c(
                Name = 'Default Billing Product',
                AcctSeed__Visualforce_PDF_Page__c = 'BillingProductPDF',
                AcctSeed__Default_Email_Template__c = [Select Id, DeveloperName From EmailTemplate limit 1].DeveloperName,
                AcctSeed__Type__c = 'Billing',
                AcctSeed__Sort_Field__c = 'Name'
            )
        );
            
        PDFformats.add(
            new AcctSeed__Billing_Format__c(
                Name = 'Default Billing Service',
                AcctSeed__Visualforce_PDF_Page__c = 'BillingServicePDF',
                AcctSeed__Default_Email_Template__c = [Select Id, DeveloperName From EmailTemplate limit 1].DeveloperName,
                AcctSeed__Type__c = 'Billing',
                AcctSeed__Sort_Field__c = 'Name'
            )
        );
        
        PDFformats.add(
            new AcctSeed__Billing_Format__c (
                Name = 'Billing Outstanding Statement',
                AcctSeed__Visualforce_PDF_Page__c = 'BillingOutstandingStatementPDF',
                AcctSeed__Default_Email_Template__c = [Select Id, DeveloperName From EmailTemplate limit 1].DeveloperName,
                AcctSeed__ReplyTo_Email__c = 'test3463464364646@gmail.com',
                AcctSeed__Type__c = 'Outstanding Statement'
            )
        );
        
        PDFformats.add(
            new AcctSeed__Billing_Format__c (
                Name = 'Billing Activity Statement',
                AcctSeed__Visualforce_PDF_Page__c = 'BillingActivityStatementPDF',
                AcctSeed__Default_Email_Template__c = [Select Id, DeveloperName From EmailTemplate limit 1].DeveloperName,
                AcctSeed__ReplyTo_Email__c = 'test3463464364646@gmail.com',
                AcctSeed__Type__c = 'Activity Statement'
            )
        );
        // #4
        PDFformats.add(
            new AcctSeed__Billing_Format__c(
                Name = 'Default Purchase Order',
                AcctSeed__Visualforce_PDF_Page__c = 'BillingServicePDF',
                AcctSeed__Default_Email_Template__c = [Select Id, DeveloperName From EmailTemplate limit 1].DeveloperName,
                AcctSeed__Type__c = 'Purchase Order',
                AcctSeed__Sort_Field__c = 'Name'
            )
        );
        
        PDFformats.add(
            new AcctSeed__Billing_Format__c(
                Name = 'Default Packing Slip',
                AcctSeed__Visualforce_PDF_Page__c = 'BillingServicePDF',
                AcctSeed__Default_Email_Template__c = [Select Id, DeveloperName From EmailTemplate limit 1].DeveloperName,
                AcctSeed__Type__c = 'Packing Slip',
                AcctSeed__Sort_Field__c = 'Name'
            )
        );
        
        insert PDFformats;
        
        // create GL Accounts
        AcctSeed__GL_Account__c [] glAccounts = new List<AcctSeed__GL_Account__c>();
         glAccounts.add(
                 new AcctSeed__GL_Account__c(
                         Name = '1000-Cash',
                         AcctSeed__Active__c = true,
                         AcctSeed__Type__c = 'Balance Sheet',
                         AcctSeed__Bank__c = true,
                         AcctSeed__Sub_Type_1__c = 'Assets',
                         AcctSeed__Sub_Type_2__c = 'Cash'
                 )
         );
 		
        // 1
         glAccounts.add(
             new AcctSeed__GL_Account__c(
                 Name = '1205-Unapplied A/R',
                 AcctSeed__Active__c = true,
                 AcctSeed__Type__c = 'Balance Sheet',
                 AcctSeed__Sub_Type_1__c = 'Assets',
                 AcctSeed__Sub_Type_2__c = 'Cash'
                 
             )
         );
         
         // 2
         glAccounts.add(
         new AcctSeed__GL_Account__c(
         Name = '1200-Accounts Receivable',
         AcctSeed__Active__c = true,
         AcctSeed__Type__c = 'Balance Sheet',
         AcctSeed__Sub_Type_1__c = 'Assets',
         AcctSeed__Sub_Type_2__c = 'Current Assets'
         )
         );
         
         // 3
         glAccounts.add(
         new AcctSeed__GL_Account__c(
         Name = '1600-Work In Process',
         AcctSeed__Active__c = true,
         AcctSeed__Type__c = 'Balance Sheet',
         AcctSeed__Sub_Type_1__c = 'Assets',
         AcctSeed__Sub_Type_2__c = 'Current Assets'
         )
         );
         
         // 4
         glAccounts.add(
         new AcctSeed__GL_Account__c(
         Name = '2000-Accounts Payable',
         AcctSeed__Active__c = true,
         AcctSeed__Type__c = 'Balance Sheet',
         AcctSeed__Sub_Type_1__c = 'Liabilities',
         AcctSeed__Sub_Type_2__c = 'Current Liabilities'
         )
         );
         
         // 5
         glAccounts.add(
         new AcctSeed__GL_Account__c(
         Name = '2010-Vouchers Payable',
         AcctSeed__Active__c = true,
         AcctSeed__Type__c = 'Balance Sheet',
         AcctSeed__Sub_Type_1__c = 'Liabilities',
         AcctSeed__Sub_Type_2__c = 'Current Liabilities'
         )
         );
         
         // 6
         glAccounts.add(
         new AcctSeed__GL_Account__c(
         Name = '3050-Retained Earnings',
         AcctSeed__Active__c = true,
         AcctSeed__Type__c = 'Balance Sheet',
         AcctSeed__Sub_Type_1__c = 'Owners Equity',
         AcctSeed__Sub_Type_2__c = 'Equity'
         )
         );
         
         // 7
         glAccounts.add(
         new AcctSeed__GL_Account__c(
         Name = '3060-Current Year Earnings',
         AcctSeed__Active__c = true,
         AcctSeed__Bank__c = true,
         AcctSeed__Type__c = 'Balance Sheet',
         AcctSeed__Sub_Type_1__c = 'Owners Equity',
         AcctSeed__Sub_Type_2__c = 'Equity'
         )
         );
         
         // 8
         glAccounts.add(
         new AcctSeed__GL_Account__c(
         Name = '4000-Product Revenue',
         AcctSeed__Active__c = true,
         AcctSeed__Type__c = 'Revenue',
         AcctSeed__Sub_Type_1__c = 'Product Revenue',
         AcctSeed__Sub_Type_2__c = 'Product Family 1'
         )
         );
         
         // 9
         glAccounts.add(
         new AcctSeed__GL_Account__c(
         Name = '5010-Inventory Cost Variance',
         AcctSeed__Active__c = true,
         AcctSeed__Type__c = 'Expense',
         AcctSeed__Sub_Type_1__c = 'Cost of Goods Sold',
         AcctSeed__Sub_Type_2__c = 'Materials'
         )
         );
         
         // 10
         glAccounts.add(
         new AcctSeed__GL_Account__c(
         Name = '5040-Vendor Payment Discounts',
         AcctSeed__Active__c = true,
         AcctSeed__Type__c = 'Expense',
         AcctSeed__Sub_Type_1__c = 'Cost of Goods Sold',
         AcctSeed__Sub_Type_2__c = 'Materials'
         )
         );
         
         // 11
         glAccounts.add(
         new AcctSeed__GL_Account__c(
         Name = 'zLabor Clearing',
         AcctSeed__Active__c = true,
         AcctSeed__Type__c = 'Expense'
         )
         );
         
         // 12
         glAccounts.add(
         new AcctSeed__GL_Account__c(
         Name = 'zProject Labor',
         AcctSeed__Active__c = true,
         AcctSeed__Type__c = 'Expense'
         )
         );
         
         // 13
         glAccounts.add(
         new AcctSeed__GL_Account__c(
         Name = '4900-Customer Payment Discounts',
         AcctSeed__Active__c = true,
         AcctSeed__Bank__c = false,
         AcctSeed__Type__c = 'Revenue',
         AcctSeed__Sub_Type_1__c = 'Product Revenue',
         AcctSeed__Sub_Type_2__c = 'Product Family 1'
         )
         );
         
         // 14
         glAccounts.add(
         new AcctSeed__GL_Account__c(
         Name = '1400-Prepaid Expenses',
         AcctSeed__Active__c = true,
         AcctSeed__Bank__c = false,
         AcctSeed__Type__c = 'Balance Sheet',
         AcctSeed__Sub_Type_1__c = 'Assets',
         AcctSeed__Sub_Type_2__c = 'Current Assets'
         )
         );
                
         insert glAccounts;
 		
         AcctSeed__Ledger__c ledger = new AcctSeed__Ledger__c(
                 Name = 'Actual',
                 AcctSeed__Type__c = 'Transactional',
                 AcctSeed__Default_Bank_Account__c = glAccounts[7].id,
                 AcctSeed__Default_Billing_Format__c = PDFformats[0].Id,
                 AcctSeed__Billing_Outstanding_Statement_Format__c = PDFformats[2].Id,
                 AcctSeed__Billing_Activity_Statement_Format__c = PDFformats[3].Id,
                 AcctSeed__Default_Purchase_Order_Format__c = PDFformats[4].Id,
                 AcctSeed__Default_Packing_Slip_Format__c = PDFformats[5].Id);
 
         insert ledger;
 
         AcctSeed__Accounting_Settings__c settings = new AcctSeed__Accounting_Settings__c(
             Name = 'Test Settings',
             
             AcctSeed__Default_Ledger__c = ledger.Id,
             AcctSeed__Legacy_Default_Ledger__c = ledger.Id,
             AcctSeed__Enable_Product_Costing__c = true,
             AcctSeed__Display_Billable_Flag_in_Time_Card_Entry__c = true,
             AcctSeed__Enable_Billing_Period_Sensitive_Aging__c = true,
             AcctSeed__Enable_AP_Period_Sensitive_Aging__c = true,
             AcctSeed__Unapplied_Cash_GL_Account__c = glAccounts[1].Id,
             AcctSeed__AR_Control_GL_Account__c = glAccounts[2].Id,
             AcctSeed__Work_in_Process_GL_Account__c = glAccounts[3].Id,
             AcctSeed__AP_Control_GL_Account__c = glAccounts[4].Id,
             AcctSeed__Vouchers_Payable_GL_Account__c = glAccounts[5].Id,
             AcctSeed__Retained_Earnings_GL_Account__c = glAccounts[6].Id,
             AcctSeed__Current_Year_Earnings_GL_Account__c = glAccounts[0].Id,
             AcctSeed__Revenue_GL_Account__c = glAccounts[10].Id,
             AcctSeed__Inventory_Variance_GL_Account__c = glAccounts[13].Id,
             AcctSeed__Payment_Discount_GL_Account__c = glAccounts[14].Id
         );
         insert settings;
            
        Account acc = new Account();
        acc.Name ='Test Account' +Math.random();
        acc.inscor__Account_Number__c='155891';
        acc.inscor__Accounting_Type__c='Customer';
        insert acc;
        
        Contact con = new Contact();
        con.FirstName ='Test';
        con.LastName ='Contact';
        con.AccountId = acc.Id;
        con.Email ='test@etst.com';
        insert con;
        
        YayPay_Configuration__c yayPayConfigSetting = YayPay_Configuration__c.getOrgDefaults();   
        yayPayConfigSetting.EndPoint__c = 'https://developer.yaypay.com/api/v1/token';
        yayPayConfigSetting.Transaction_End_Time__c = 10;
        yayPayConfigSetting.Records_To_Query_Batch__c = '10';
        yayPayConfigSetting.Batch_Interval_Minutes__c = 10;
        yayPayConfigSetting.Is_Integration_Enable__c = true;
        yayPayConfigSetting.Client_Key__c = '45q70fmc8n1agi258vhnaoh99e';
        yayPayConfigSetting.Client_Secret__c = '1mqaafklenu997svqlcv8j7u5cifhchdbifd4fdopc759lejmj0';
        upsert yayPayConfigSetting;
        
        Product2 productRec = new Product2(Name = 'Laptop X200', 
                                     Family = 'Hardware', inscor__Keyword__c ='test', inscor__Description__c ='Test Desc.');
        insert productRec;
        
        
        inscor__Invoice__c inv = new inscor__Invoice__c();
        inv.inscor__Invoice_Date__c = Date.today();
        inv.inscor__Status__c ='Created';
        inv.inscor__Account__c = acc.Id;
        inv.YayPay_Last_Sync_Date__c = DateTime.now();
        inv.inscor__Billing_Contact__c = con.Id;
        insert inv;
        
        inscor__Invoice_Line__c invLine = new inscor__Invoice_Line__c();
        invLine.inscor__Price__c =200;
        invLine.inscor__Quantity__c = 2;
        invLine.inscor__Invoice__c = inv.Id;
        insert invLine;
        
    }    
    
    @isTest
    static void batchWithParamTest() {
        Account acc = [ SELECT Id FROM Account LIMIT 1];
        Contact con = [ SELECT Id FROM Contact LIMIT 1];        
        Test.setMock(HttpCalloutMock.class, new YayPayMockResponseGenerator());
        
        AcctSeed__Accounting_Period__c acctPeriod = new AcctSeed__Accounting_Period__c(
            Name = '1991-10',
            AcctSeed__Start_Date__c = Date.newinstance(1991, 10, 1),
            AcctSeed__End_Date__c = Date.newinstance(1991, 10, 31),
            AcctSeed__Status__c = 'Open');
        insert acctPeriod;
        
        List<AcctSeed__GL_Account__c> glAcc = [Select Id from AcctSeed__GL_Account__c where Name = '1205-Unapplied A/R'];
        AcctSeed__Ledger__c ledger = [SELECT id from AcctSeed__Ledger__c limit 1];
        
        inscor__Invoice__c inv = [Select id , name from inscor__Invoice__c LIMIT 1 ];
        
        AcctSeed__Cash_Receipt__c rpt = new AcctSeed__Cash_Receipt__c(
            AcctSeed__Account__c = acc.Id,
            AcctSeed__Amount__c = 1,
            AcctSeed__Payment_Reference__c = '12345',
            AcctSeed__Credit_GL_Account__c = glAcc[0].Id,
            AcctSeed__Accounting_Period__c = acctPeriod.id,
            AcctSeed__Ledger__c = ledger.id,
            Payment_Type__c = 'Credit Card'
        );
        insert rpt;
        
        AcctSeed__Billing__c[] billings = new List <AcctSeed__Billing__c> ();
        billings.add(
                 new AcctSeed__Billing__c(
                         AcctSeed__Billing_Cycle_Start_Date__c = System.today(),
                         AcctSeed__Billing_Cycle_End_Date__c = System.today() + 30,
                         AcctSeed__Date__c = System.today(),
                         AcctSeed__Customer__c = acc.Id,
                     	 AcctSeed__Billing_Contact__c = con.Id,
                         AcctSeed__Status__c = 'Approved',
                         AcctSeed__Due_Date2__c = System.today() + 30,
                         AcctSeed__Ledger__c = ledger.Id,
                         AcctSeed__Proprietary_Billing_Number__c = inv.Name,
                     	 inscoras__Invoice__c = inv.Id,
                         AcctSeed__Accounting_Period__c = acctPeriod.id
                 )
         );
        insert billings;
        
        AcctSeed__Billing_Cash_Receipt__c billingCashReceipt = new AcctSeed__Billing_Cash_Receipt__c();            
        billingCashReceipt.AcctSeed__Billing__c = billings[0].Id;
        billingCashReceipt.AcctSeed__Cash_Receipt__c = rpt.Id;
        billingCashReceipt.AcctSeed__Accounting_Period__c = acctPeriod.Id;
        billingCashReceipt.AcctSeed__Applied_Amount__c = 0;
        insert billingCashReceipt;
        Database.executeBatch(new BatchProcessCashReceiptToYayPay());
        
        Deleted_Record__c delRecord = new Deleted_Record__c( Deleted_Record_Id__c = rpt.Id, Object_Type__c = 'payments');
        insert delRecord;
        
        system.assertEquals(1, [Select Id from AcctSeed__Cash_Receipt__c].size());
        Test.startTest();
        Database.executeBatch(new BatchProcessDeletedRecordsToYayPay());  
        Test.stopTest();
    }
    
}