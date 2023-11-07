public class TestDataFactory {
    public static void createAccountingSeedDataSet() {
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
    }
    public static void createReleaseAllocationDataSet(){
        //Create a Account for Customer
        Account accRec = new Account();
        accRec.Name = 'TEST';
        accRec.inscor__Account_Number__c = '2';  
        insert accRec;
        
        inscor__Customer_Quote__c customerQuoteRec = new inscor__Customer_Quote__c();
        customerQuoteRec.inscor__Customer__c = accRec.Id;
        customerQuoteRec.inscor__Status__c = 'New';
        insert customerQuoteRec;
        
        inscor__Sales_Order__c salesOrderRec = new inscor__Sales_Order__c();
        salesOrderRec.inscor__Quote_Number__c = customerQuoteRec.Id;
        salesOrderRec.inscor__Customer__c = accRec.Id;
        insert salesOrderRec;
        
        Product2 productRec = new Product2(Name = 'Laptop X200', 
                                           Family = 'Hardware', inscor__Keyword__c ='test');
        insert productRec;
        
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
        
        inscor__Release__c releaseRec = new inscor__Release__c();
        releaseRec.inscor__Ship_To_Address__c = addRec.Id;
        releaseRec.inscor__Sales_Order__c = salesOrderRec.Id;
        
        insert releaseRec;
        
        
        inscor__Condition_Code__c conditionalCode  = new inscor__Condition_Code__c( inscor__Show_in_Summary__c = false);
        insert conditionalCode;
        
        //---inscor__Company__c company = [ SELECT Id FROM inscor__Company__c LIMIT 1];
        inscor__Company__c  company = new inscor__Company__c(
            inscor__Address_1__c = '1111', inscor__City__c = '1111', inscor__Company_Name__c = '1111', inscor__Zip_Code__c = '1111');
        insert company;
        inscor__Company_Location__c companyLoc = new inscor__Company_Location__c( inscor__Company__c =company.Id );
        insert companyLoc;
        
        inscor__Inventory_Location__c invLocation  = new inscor__Inventory_Location__c(
            inscor__Company_Location__c = companyLoc.Id );
        insert invLocation;
        
        inscor__Owner_Code__c ownerCode = new inscor__Owner_Code__c();
        insert ownerCode;
        
        inscor__Warehouse__c warehouse = new inscor__Warehouse__c( 
            inscor__Company_Location__c = companyLoc.Id, inscor__Warehouse_Code__c ='1111' );
        insert warehouse;       
        
        inscor__Inventory_Line__c invLine = new inscor__Inventory_Line__c(
            
            inscor__Condition_Code__c = conditionalCode.Id , 
            inscor__Location__c  = invLocation.Id, 
            inscor__Owner_Code__c  = ownerCode.Id,
            inscor__Warehouse__c  = warehouse.Id
        );
        
        insert invLine;
        
        inscor__Allocation__c allocation = new inscor__Allocation__c();
        allocation.inscor__Sales_Order_Line__c = salesOrderLineRec.Id;
        allocation.inscor__Sales_Order__c = salesOrderRec.Id;
        allocation.inscor__Inventory_Line__c = invLine.Id;
        insert allocation;
        
        inscor__Release_Line__c releaseLineRec = new inscor__Release_Line__c();
        releaseLineRec.inscor__Release__c = releaseRec.Id;
        releaseLineRec.inscor__Sales_Order_Line__c = salesOrderLineRec.Id;
        releaseLineRec.inscor__Allocation__c = allocation.Id;
        insert releaseLineRec; 
        
    }
}