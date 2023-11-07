public class YayPayRequestHelper {
    
    public static String createRequestJSONToCustomer(List<Account> accountList) {
       
        CustomerWrapper wrapper = new CustomerWrapper();
        list<Cls_Items_Customer> items = new list<Cls_Items_Customer>();
        
        for( Account acc : accountList ){
            
            Cls_Customer cust = new Cls_Customer();
            cust.company_name = acc.Name;
            cust.currncy = 'USD';
            
            cust.duns_number = YayPayUtility.nullStringRemoval( acc.DNBI__DnB_DUNS_NO__c );
            
            Cls_Custom_Fields_Customer customFlds = new Cls_Custom_Fields_Customer();
            customFlds.region = YayPayUtility.nullStringRemoval( acc.inscor__Account_Region__c );
            
            cust.custom_fields = customFlds;
            cust.credit_limit = acc.inscor__Credit_Limit__c;
            cust.payment_terms = acc.inscor__Account_Terms__c != null ?
                acc.inscor__Account_Terms__r.Name : '';
            
            cust.tax_id = YayPayUtility.nullStringRemoval( acc.AcctSeed__Taxpayer_Identification_Number__c );
            
            Cls_Address_Customer address = new Cls_Address_Customer();
            address.city = acc.ShippingCity;
            address.country = acc.Shippingcountry;
            address.email = acc.inscor__Billing_Contact__r.Email;
            address.line1 = acc.ShippingStreet;
            address.phone = acc.Phone;
            address.state = acc.ShippingState;
            address.zip = acc.ShippingPostalCode;
            address.www = acc.Website;
            cust.address = address;
            Cls_Integration_Customer integration = new Cls_Integration_Customer();
            integration.internal_id = acc.Id;
            
            Cls_Items_Customer clsItem = new Cls_Items_Customer();
            clsItem.customer = cust;
            clsItem.integration = integration;
            items.add( clsItem );
        }         
        wrapper.items = items;
        
        String requestJSON = JSON.serialize(wrapper);
        requestJSON= requestJSON.replace('"currncy":', '"currency":');
        return requestJSON;
    }
    
    
    public static String createRequestJSONToContacts(list<Contact> contacts ) {
        
        ContactWrapper wrapper = new ContactWrapper();
         list<Cls_Items_Contact> items = new list<Cls_Items_Contact>();
         
         for( Contact con : contacts ){
             
             Cls_Contact_Customer cust = new Cls_Contact_Customer();
             cust.internal_id = con.AccountId;
             
             Cls_Integration_Contact integration = new Cls_Integration_Contact();
             integration.internal_id = con.Id;
             
             Cls_Contact contact = new Cls_Contact();
             contact.customer = cust;
             contact.email = con.Email;
             contact.first_name = con.FirstName;
             contact.last_name = con.LastName;
             contact.mobile_phone = con.MobilePhone;
             contact.phone = con.Phone;
             if( con.inscor__Contact_Options__c != null && con.inscor__Contact_Options__c.contains('Receive Invoice') ){
                 contact.primary = true;
             }else{
                 contact.primary = false;
             }
             
             contact.title = con.Title;
            
             Cls_Items_Contact clsItem = new Cls_Items_Contact();
             clsItem.contact = contact;
             clsItem.integration = integration;
             items.add( clsItem );
         }         
         wrapper.items = items;
         
         String requestJSON = JSON.serialize(wrapper);
        
        return requestJSON;
    }
    
    
    public static String createRequestJSONToInvoice(inscor__Invoice__c invoice ) {
       
        YayPay_Configuration__c config = YayPay_Configuration__c.getOrgDefaults();
        
        list<inscor__Invoice__c> invoiceList = new list<inscor__Invoice__c>();
        invoiceList.add( invoice );
        InvoiceWrapper wrapper = new InvoiceWrapper();
        list<Cls_Items_Invoice> items = new list<Cls_Items_Invoice>();
        
        Decimal paidAmount = 0;
        
        List<AcctSeed__Billing__c> billings = [SELECT Id, AcctSeed__Received_Amount__c, 
                                              AcctSeed__Cash_Application_Adjustment_Amount__c,
                                              AcctSeed__Credit_Memo_Applied_Amount__c
                                              FROM AcctSeed__Billing__c
                                               WHERE inscoras__Invoice__c = :invoice.Id
                                               AND AcctSeed__Status__c = 'Posted'
                                               AND AcctSeed__Type__c = 'Invoice'];
        
        for(AcctSeed__Billing__c billing : billings){
            if(billing.AcctSeed__Received_Amount__c != null){
              paidAmount += billing.AcctSeed__Received_Amount__c;    
            }
            if(billing.AcctSeed__Cash_Application_Adjustment_Amount__c != null){
              paidAmount += billing.AcctSeed__Cash_Application_Adjustment_Amount__c;    
            }
            if(billing.AcctSeed__Credit_Memo_Applied_Amount__c != null){
              paidAmount += billing.AcctSeed__Credit_Memo_Applied_Amount__c;    
            }
        }

        for( inscor__Invoice__c inv : invoiceList ){
            
            Cls_Contact_Invoice contactObj = new Cls_Contact_Invoice();
            contactObj.internal_id = inv.inscor__Billing_Contact__r.Id;
            
            Cls_Customer_Invoice customerObj = new Cls_Customer_Invoice();
            customerObj.internal_id = inv.inscor__Account__r.Id;
            
            Cls_Invoice invoiceObj = new Cls_Invoice();
            Date myDate = inv.inscor__Invoice_Date__c;
            Time myTime;
            if( config.Due_Date_Time_Instance__c != null && config.Due_Date_Time_Instance__c != '' ){
                myTime = Time.newInstance( integer.valueOf( config.Due_Date_Time_Instance__c ) , 0, 0, 0 );
            }else{
                myTime = Time.newInstance(0, 0, 0, 0);
            }
            DateTime dt;
            if( myDate != null ){
                dt = DateTime.newInstance(myDate, myTime);
            }
      
            Cls_Custom_Fields_Invoice customFieldObj = new Cls_Custom_Fields_Invoice();
            customFieldObj.PO_Number_SF = inv.inscor__Customer_PO_Number__c;
      list<Cls_Items_InvoiceLine> invoiceLines = new list<Cls_Items_InvoiceLine>();
            for( inscor__Invoice_Line__c invLine : inv.inscor__Invoice_Lines__r ){
                
                Cls_Integration_InvoiceLine integration = new Cls_Integration_InvoiceLine();
                integration.internal_id = invLine.Id;
                
                Cls_Items_InvoiceLine invLineObj = new Cls_Items_InvoiceLine();
                invLineObj.amount = invLine.inscor__Extended_Price__c;
                if( invLine.inscor__Item__c != null ){
                    invLineObj.description = invLine.inscor__Item__r.inscor__Description__c != null ?
                                  invLine.inscor__Item__r.inscor__Description__c : 'Test Description' ;
                }
                
                invLineObj.integration = integration;
                invLineObj.name = invLine.inscor__Item__r.Name;
                invLineObj.quantity =  Integer.valueOf(invLine.inscor__Quantity__c );
                invLineObj.rate = invLine.inscor__Price__c ;
                invoiceLines.add( invLineObj );
            }   
            
            invoiceObj.close_date = dt != null ? dt.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'') : null;
            invoiceObj.contact = contactObj ;
            invoiceObj.contact_email = inv.inscor__Billing_Contact__r.Email ;
            invoiceObj.currncy = 'USD';
            if( inv.inscor__Invoice_Date__c  < date.newInstance(2021, 05, 15) && inv.inscor__Status__c == 'Paid' ){
                invoiceObj.paid = inv.inscor__Total_Invoice__c;
            }else{
                invoiceObj.paid = paidAmount;
            }
            
            invoiceObj.custom_fields = customFieldObj;
            invoiceObj.customer =customerObj ;
            invoiceObj.distribution_channel = 'EINV' ;
            
            DateTime dueDate = dt;
            if( inv.inscor__Account_Terms__r != null 
               && inv.inscor__Account_Terms__r.inscor__Number_of_Days__c != null ){
                dueDate = dt.addDays( Integer.valueOf( inv.inscor__Account_Terms__r.inscor__Number_of_Days__c ) );
            }
            invoiceObj.due_date = dueDate != null ? dueDate.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'') : null;
            invoiceObj.exchange_rate = 1;
            invoiceObj.invoice_date = dt != null ? dt.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'') : null;
            invoiceObj.invoice_number = inv.Name;
            invoiceObj.items = invoiceLines;
            invoiceObj.status =  inv.inscor__Status__c == 'Paid' ? 'PAID' : 'UNPAID';
            invoiceObj.sub_total = inv.inscor__Total_Invoice__c;
            invoiceObj.terms = 'Net 30';
            invoiceObj.total = inv.inscor__Total_Invoice__c ;
                        
            Cls_Integration_Invoice integration = new Cls_Integration_Invoice();
            integration.internal_id = inv.Id;
             
            Cls_Items_Invoice clsItem = new Cls_Items_Invoice();
            clsItem.invoice = invoiceObj;
            clsItem.integration = integration;
            
            items.add( clsItem );
        }         
        wrapper.items = items;
        
        String requestJSON = JSON.serialize(wrapper);
        requestJSON= requestJSON.replace('"currncy":', '"currency":');
        return requestJSON;
        
    }
    
   
    public static String createRequestJSONToPayments(list<inscor__Activity__c> payments ) {
        /*
        PaymentWrapper wrapper = new PaymentWrapper();
        list<Cls_Items_Payment> items = new list<Cls_Items_Payment>();
        
        for( inscor__Activity__c pymt : payments ){
            
            Cls_Invoice_Payment invoiceObj = new Cls_Invoice_Payment();
            invoiceObj.internal_id = pymt.inscor__INVC__r.Id;
            
            Cls_Customer_Payment customerObj = new Cls_Customer_Payment();
            customerObj.internal_id = pymt.inscor__Customer_Vendor__r.Id;
                
            Date myDate = pymt.inscor__INVC_Date__c;
            Time myTime = Time.newInstance(0, 0, 0, 0);
            DateTime dt;
            if( myDate != null ){
                dt = DateTime.newInstance(myDate, myTime);
            }
                        
            list<Cls_Apply_List_Payment> applyList = new list<Cls_Apply_List_Payment>();
            
            Cls_Apply_List_Payment applyObj = new Cls_Apply_List_Payment();
            applyObj.amount = Integer.valueOf( pymt.inscor__Line_Value__c );
            applyObj.applied_amount = Integer.valueOf( pymt.inscor__Line_Value__c );
            applyObj.invoice = invoiceObj;
            applyObj.payment_date = dt != null ? dt.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'') : null;
            applyList.add( applyObj );
            
            Cls_Payment paymentObj = new Cls_Payment();
            paymentObj.amount = Integer.valueOf( pymt.inscor__Line_Value__c );
            paymentObj.applied_amount = Integer.valueOf( pymt.inscor__Line_Value__c );
            paymentObj.channel = 'CASH' ;
            paymentObj.currncy = 'USD' ;
            paymentObj.exchange_rate = 1  ;
            paymentObj.external_id = pymt.inscor__External_Reference_ID__c ;
            paymentObj.payment_date =  dt != null ? dt.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'') : null;
            paymentObj.reference_number = pymt.Name ;
            paymentObj.customer = customerObj;
            paymentObj.apply_list = applyList;
            
            Cls_Integration_Payment integration = new Cls_Integration_Payment();
            integration.internal_id = pymt.Id;
            
            Cls_Items_Payment clsItem = new Cls_Items_Payment();
            clsItem.payment = paymentObj;
            clsItem.integration = integration;
            
            items.add( clsItem );
        }         
        wrapper.items = items;
        
        String requestJSON = JSON.serialize(wrapper);
        requestJSON= requestJSON.replace('"currncy":', '"currency":');
    */
        return null;
        
    }
    
    
    public static String createRequestJSONToDocuments(list<ContentDocumentLink> contentDocumentLinks ) {
       
        
        YayPay_Configuration__c config = YayPay_Configuration__c.getOrgDefaults();
        String fileNamePrefix = config.File_Name_Prefix_Invoice__c;
        
        FileWrapper wrapper = new FileWrapper();
        list<Cls_Items_File> items = new list<Cls_Items_File>();
        
        Map<String, ContentDocumentLink> mapContentDocIdToContentDocLink = new map<String, ContentDocumentLink>();
        set<String> contentDocumentIds = new set<String>();
        
        for( ContentDocumentLink cdLink : contentDocumentLinks ){
            contentDocumentIds.add( cdLink.ContentDocumentId );
            mapContentDocIdToContentDocLink.put( cdLink.ContentDocumentId, cdLink );
        }
        
        List<ContentVersion> ContentVersionList = [ SELECT VersionData, ContentDocumentId,
                                                   Title, FileExtension
                                                   FROM ContentVersion 
                                                   WHERE ContentDocumentId IN: contentDocumentIds 
                                                   AND IsLatest = TRUE  ];
        
        for( ContentVersion cv : ContentVersionList ){
            
            Cls_Invoice_File integrationInvoice = new Cls_Invoice_File();
            if( mapContentDocIdToContentDocLink.size() > 0 && mapContentDocIdToContentDocLink.containsKey( cv.ContentDocumentId ) ){
                integrationInvoice.internal_id = mapContentDocIdToContentDocLink.get( cv.ContentDocumentId ).LinkedEntityId;
            }
            
            
            integrationInvoice.source = 'OTHER';
            
            Cls_Content_File fileObj = new Cls_Content_File();
            fileObj.base64_content = EncodingUtil.Base64Encode(cv.VersionData);
            fileObj.content_type = 'application/'+ cv.FileExtension;
            fileObj.file_name = (cv.Title != null ? cv.Title.substringBefore('.') : '') + '.' +cv.FileExtension;
            fileObj.integration = integrationInvoice; 
            
          
            if( cv.Title.startsWith( fileNamePrefix ) ){
              fileObj.supplementary_type ='ERP_INVOICE_PDF';  
            }else{
                fileObj.supplementary_type ='INVOICE';  
            }            
                
            Cls_Integration_File integration = new Cls_Integration_File();
            integration.internal_id = cv.Id;
            integration.source = 'OTHER';
            
            Cls_Items_File clsItem = new Cls_Items_File();
            clsItem.content = fileObj;
            clsItem.integration = integration;
            
            items.add( clsItem );
        }         
        wrapper.items = items;
        
        String requestJSON = JSON.serialize(wrapper);
        return requestJSON;
        
    }
    
    //JSON for Customer billing.
    public static String createRequestJSONToBilling(list<AcctSeed__Billing__c> BillingList ) {
        
        List<YayPay_Other_Charges_Configuration__mdt> YayPayOtherCharges = [ SELECT Id, DeveloperName, MasterLabel 
                                                                                      FROM YayPay_Other_Charges_Configuration__mdt ];
        Map<String, YayPay_Other_Charges_Configuration__mdt> mapYayPayOtherCharges = new Map<String, YayPay_Other_Charges_Configuration__mdt>();
        
        for( YayPay_Other_Charges_Configuration__mdt meta : YayPayOtherCharges ){
            mapYayPayOtherCharges.put( meta.MasterLabel, meta );
        }
        CreditMemoWrapper wrapper = new CreditMemoWrapper();
        list<Cls_Items_CreditMemo> items = new list<Cls_Items_CreditMemo>();
        set<String> invoiceNumbers = new set<String>();
    
        for( AcctSeed__Billing__c ab : BillingList ){
            
            Decimal totalOtherCharges =0;
            for( AcctSeed__Billing_Credit_Memo__c cm : ab.AcctSeed__Billing_Credit_Memos__r ){ 
                //Total Other Charges.
                totalOtherCharges = totalOtherCharges + ab.AcctSeed__Total__c;
                
            }
            list<Cls_Apply_Invoice_List_Credit> invCreditList = new list<Cls_Apply_Invoice_List_Credit>();
            for( AcctSeed__Billing_Credit_Memo__c cm : ab.AcctSeed__Billing_Credit_Memos__r ){                
                if( mapYayPayOtherCharges.containsKey( cm.AcctSeed__Billing_Invoice__r.AcctSeed__Billing_Comment__c ) ){
                    Cls_Customer_Credit customerInt = new Cls_Customer_Credit();
                    customerInt.internal_id = ab.AcctSeed__Customer__c;
                    
                    Date myDate = ab.AcctSeed__Date__c;
                    Time myTime = Time.newInstance(0, 0, 0, 0);
                    DateTime dt;
                    if( myDate != null ){
                        dt = DateTime.newInstance(myDate, myTime);
                    }
                    
                    Cls_Credit_Memo memo = new Cls_Credit_Memo();
                    memo.amount = (ab.AcctSeed__Total__c != null ? -1 * ab.AcctSeed__Total__c : null) + Integer.valueOf( totalOtherCharges );
                    memo.applied_amount = (ab.AcctSeed__Credit_Memo_Applied_Amount__c != null ? -1 * ab.AcctSeed__Credit_Memo_Applied_Amount__c : null) + Integer.valueOf( totalOtherCharges );
                    memo.currncy = 'USD';
                    memo.customer = customerInt;
                    memo.exchange_rate = 1;
                    
                    memo.payment_date = dt != null ? dt.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'') : null;
                    memo.reference_number = ab.Name + '-' + cm.AcctSeed__Billing_Invoice__r.AcctSeed__Billing_Comment__c;           
                    
                    Cls_Integration_Credit integration = new Cls_Integration_Credit();
                    integration.internal_id = ab.Id + '' + cm.Id;
                    
                    Cls_Items_CreditMemo clsItem = new Cls_Items_CreditMemo();
                    clsItem.integration = integration;
                    clsItem.credit_memo = memo;
                    
                    items.add( clsItem );
                }
                else{
                    Cls_Apply_Entity_Credit invInt = new Cls_Apply_Entity_Credit();
                    
                    invInt.internal_id = cm.AcctSeed__Billing_Invoice__r.inscoras__Invoice__c;
                    
                    Cls_Apply_Invoice_List_Credit invCredit = new Cls_Apply_Invoice_List_Credit();
                    invCredit.amount = (cm.AcctSeed__Amount__c != null ? -1 * cm.AcctSeed__Amount__c : null);
                    invCredit.apply_entity = invInt;
                    
                    Date myDate01 = cm.AcctSeed__Applied_Date__c;
                    Time myTime01 = Time.newInstance(0, 0, 0, 0);
                    DateTime dt01;
                    if( myDate01 != null ){
                        dt01 = DateTime.newInstance(myDate01, myTime01);
                    }
                    invCredit.payment_date = dt01 != null ? dt01.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'') : null;
                    
                    invCreditList.add( invCredit );
                }
            }
            Cls_Customer_Credit customerInt = new Cls_Customer_Credit();
            customerInt.internal_id = ab.AcctSeed__Customer__c;
            
            Date myDate = ab.AcctSeed__Date__c;
            Time myTime = Time.newInstance(0, 0, 0, 0);
            DateTime dt;
            if( myDate != null ){
                dt = DateTime.newInstance(myDate, myTime);
            }
            
            Cls_Credit_Memo memo = new Cls_Credit_Memo();
            memo.amount = (ab.AcctSeed__Total__c != null ? -1 * ab.AcctSeed__Total__c : null);
            memo.applied_amount = (ab.AcctSeed__Credit_Memo_Applied_Amount__c != null ? -1 * ab.AcctSeed__Credit_Memo_Applied_Amount__c : null);
            memo.currncy = 'USD';
            memo.customer = customerInt;
            memo.exchange_rate = 1;
            memo.apply_invoice_list = invCreditList;
            
            memo.payment_date = dt != null ? dt.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'') : null;
            memo.reference_number = ab.Name;           
            
            Cls_Integration_Credit integration = new Cls_Integration_Credit();
            integration.internal_id = ab.Id;
            
            Cls_Items_CreditMemo clsItem = new Cls_Items_CreditMemo();
            clsItem.integration = integration;
            clsItem.credit_memo = memo;
            
            items.add( clsItem );
        }         
        wrapper.items = items;
        
        String requestJSON = JSON.serialize(wrapper);
        requestJSON= requestJSON.replace('"currncy":', '"currency":');

        return requestJSON;
    }
    
    
    //JSON for Customer billing.
    public static String createRequestJSONToReceipt(list<AcctSeed__Cash_Receipt__c> receiptList ) {
      
        List<YayPay_Other_Charges_Configuration__mdt> YayPayOtherCharges = [ SELECT Id, DeveloperName, MasterLabel 
                                                                                      FROM YayPay_Other_Charges_Configuration__mdt ];
        Map<String, YayPay_Other_Charges_Configuration__mdt> mapYayPayOtherCharges = new Map<String, YayPay_Other_Charges_Configuration__mdt>();
        
        for( YayPay_Other_Charges_Configuration__mdt meta : YayPayOtherCharges ){
            mapYayPayOtherCharges.put( meta.MasterLabel, meta );
        }
        
        PaymentWrapper wrapper = new PaymentWrapper();
        list<Cls_Items_Payment> items = new list<Cls_Items_Payment>();
        
        set<String> invoiceNumbers = new set<String>();
        
        map<String, inscor__Invoice__c> mapInvoiceNumberToInvoice = new map<String, inscor__Invoice__c>();
        list<inscor__Invoice__c> relatedInvoices = [ SELECT Id, Name 
                                                    FROM inscor__Invoice__c 
                                                    WHERE Name IN : invoiceNumbers ];
                
        for( AcctSeed__Cash_Receipt__c rpt : receiptList ){
          
            Cls_Customer_Payment customerObj = new Cls_Customer_Payment();
            customerObj.internal_id = rpt.AcctSeed__Account__c;
            
            Date myDate = rpt.AcctSeed__Receipt_Date__c;
            Time myTime = Time.newInstance(0, 0, 0, 0);
            DateTime dt;
            if( myDate != null ){
                dt = DateTime.newInstance(myDate, myTime);
            }
            
            list<Cls_Apply_List_Payment> applyList = new list<Cls_Apply_List_Payment>();
            Decimal totalOtherCharges =0;
            
            for( AcctSeed__Billing_Cash_Receipt__c bcrpt : rpt.AcctSeed__Billing_Cash_Receipts__r ){
                //Total Other Charges.
                if( mapYayPayOtherCharges.containsKey( bcrpt.AcctSeed__Billing__r.AcctSeed__Billing_Comment__c ) ){
                    totalOtherCharges = totalOtherCharges + bcrpt.AcctSeed__Billing__r.AcctSeed__Received_Amount__c;
                }
            }
            for( AcctSeed__Billing_Cash_Receipt__c bcrpt : rpt.AcctSeed__Billing_Cash_Receipts__r ){
                
                //Other Charges.
                if( mapYayPayOtherCharges.containsKey( bcrpt.AcctSeed__Billing__r.AcctSeed__Billing_Comment__c ) ){
                    Cls_Payment paymentObj = new Cls_Payment();
                    paymentObj.amount = Integer.valueOf(bcrpt.AcctSeed__Billing__r.AcctSeed__Received_Amount__c);
                    paymentObj.applied_amount = Integer.valueOf(bcrpt.AcctSeed__Billing__r.AcctSeed__Received_Amount__c);
                    paymentObj.channel = 'CASH' ;
                    paymentObj.currncy = 'USD' ;
                    paymentObj.exchange_rate = 1  ;
                    paymentObj.payment_date =  dt != null ? dt.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'') : null;
                    paymentObj.reference_number = rpt.Name + '-' + bcrpt.AcctSeed__Billing__r.AcctSeed__Billing_Comment__c ;
                    paymentObj.customer = customerObj;
                    
                    Cls_Integration_Payment integration = new Cls_Integration_Payment();
                    integration.internal_id = rpt.Id + '' + bcrpt.Id;
                    
                    Cls_Items_Payment clsItem = new Cls_Items_Payment();
                    clsItem.payment = paymentObj;
                    clsItem.integration = integration;
                    
                    items.add( clsItem );
                }
                //Other Charges.
                else{
                    Cls_Invoice_Payment invPayment = new Cls_Invoice_Payment();
                    invPayment.internal_id = bcrpt.AcctSeed__Billing__r.inscoras__Invoice__c;
                    
                    Cls_Apply_List_Payment applyObj = new Cls_Apply_List_Payment();
                    applyObj.amount = Integer.valueOf( rpt.AcctSeed__Amount__c ) - Integer.valueOf(totalOtherCharges);
                    applyObj.applied_amount = Integer.valueOf( rpt.AcctSeed__Applied_Amount__c ) - Integer.valueOf(totalOtherCharges);
                    applyObj.invoice = invPayment;
                    applyObj.payment_date = dt != null ? dt.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'') : null;
                    applyList.add( applyObj );
                }   
                
            }            
            Cls_Payment paymentObj = new Cls_Payment();
            paymentObj.amount = Integer.valueOf( rpt.AcctSeed__Amount__c ) - Integer.valueOf( totalOtherCharges );
            paymentObj.applied_amount = Integer.valueOf( rpt.AcctSeed__Applied_Amount__c ) - Integer.valueOf( totalOtherCharges );
            paymentObj.channel = 'CASH' ;
            paymentObj.currncy = 'USD' ;
            paymentObj.exchange_rate = 1  ;
            paymentObj.apply_list = applyList;
            paymentObj.payment_date =  dt != null ? dt.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'') : null;
            paymentObj.reference_number = rpt.Name ;
            paymentObj.customer = customerObj;
            
            Cls_Integration_Payment integration = new Cls_Integration_Payment();
            integration.internal_id = rpt.Id;
            
            Cls_Items_Payment clsItem = new Cls_Items_Payment();
            clsItem.payment = paymentObj;
            clsItem.integration = integration;
            
            items.add( clsItem );
        }         
        wrapper.items = items;
        
        String requestJSON = JSON.serialize(wrapper);
        requestJSON= requestJSON.replace('"currncy":', '"currency":');

        return requestJSON;
    }
    
    
    //JSON for Customer billing.
    public static String deleteItemRequestJSON( List<String> recordIds, String objectName ) {
        
        DeleteItemWrapper deleteWrapper = new DeleteItemWrapper();
                
        List<cls_deleted_entities> deleteEntities = new List<cls_deleted_entities>();
        for( String str : recordIds ){
            
            cls_integration intergrationId = new cls_integration();
            intergrationId.internal_id = str;
            
            cls_deleted_entities  entityObj = new cls_deleted_entities();
            entityObj.entity_type = objectName.toUpperCase() ;
            entityObj.integration = intergrationId;            
            
            deleteEntities.add( entityObj );
        }
        deleteWrapper.deleted_entities = deleteEntities;
        
        String requestJSON = JSON.serialize(deleteWrapper);        
        return requestJSON;

    }
    
     public class CustomerWrapper{
        public Cls_Items_Customer[] items;
    }
    class Cls_Items_Customer {
        public Cls_Customer customer;
        public Cls_Integration_Customer integration;
    }
    class Cls_Customer {
        public Cls_Address_Customer address;
        public Double balance;  //543566.1123
        public String company_name;  //Test Inc.
        public Decimal credit_limit;  //10000000
        public String currncy;  //USD
        public Cls_Custom_Fields_Customer custom_fields;
        public String duns_number;  //string
        public String region;  //string
        public String invoice_delivery_method;  //NONE
        public String parent_id;  //parent_id
        public String payment_terms;  //NET30
        public String tax_id;  //3425543
    }
    class Cls_Address_Customer {
        public String city;  //Cupertino
        public String country;  //United States
        public String email;  //example@email.com
        public String line1;  //1 Apple Park Way
        public String line2;  //string
        public String mobile;  //string
        public String phone;  //1800-900-3454
        public String state;
        public String www;
        public String zip;
    }
    class Cls_Custom_Fields_Customer {
        public String TERMS;
        public Integer SF_ID;
        public String region;
    }
    class Cls_Integration_Customer {
        public String internal_id;
    }
    
    //Contact JSON Wrapper Cls
    public class ContactWrapper {
        public Cls_Items_Contact[] items;
    }
    
  class Cls_Items_Contact {
    public Cls_Contact contact;
    public Cls_Integration_Contact integration;
  }
  class Cls_Contact {
    public Cls_Contact_Customer customer;
    public String email;  //cfo@example.com
    public String first_name;  //Bill
    public String last_name;  //Adib
    public String mobile_phone;  //1-517-432-3344
    public String phone;  //1-800-432-4455
    public boolean primary;
    public String title;  //CFO
  }
  class Cls_Contact_Customer {
    public String internal_id;  //some_uniq_id
  }
  class Cls_Integration_Contact {
    public String internal_id;  //some_uniq_id
  }
    
    
    //Invoice Wrapper
    
     public class InvoiceWrapper{
       public Cls_Items_Invoice[] items;
    }
    class Cls_Items_Invoice {
    public Cls_Invoice invoice;
    public Cls_Integration_Invoice integration;
  }
  class Cls_Items_InvoiceLine {
    public Double amount;  //1200.45
    public Cls_Custom_Fields_Invoice custom_fields;
    public String description;  //With 50% faster peak speeds in more than 450 cities from coast to coast.
    public Cls_Integration_InvoiceLine integration;
    public String name;  //Apple iPhone 12 Pro Max
    public Integer quantity;  //1
    public Decimal rate;  //0
  }
  class Cls_Integration_Invoice {
    public String internal_id;  //some_uniq_id
  }
    class Cls_Integration_InvoiceLine {
    public String internal_id;  //some_uniq_id
  }
  class Cls_Invoice {
    public String close_date;  //2030-01-01T00:00:00Z
    public Cls_Contact_Invoice contact;
    public String contact_email;  //cfo@example.com
    public String currncy;  //USD
    public Cls_Custom_Fields_Invoice custom_fields;
    public Cls_Customer_Invoice customer;
    public String distribution_channel;  //EINV
    public String due_date;  //2020-12-17T00:00:00Z
    public Integer exchange_rate;  //1
    public String invoice_date;  //2020-11-17T00:00:00Z
    public String invoice_number;  //INVAPP-43212342
    public Cls_Items_InvoiceLine[] items;
    public String notes;  //Some important information
    public Double paid;  //2000
    public String status;  //UNPAID
    public Double sub_total;  //9500.23
    public Integer tax_amount;  //500
    public String terms;  //Net 30
    public Double total;  //10000.23
  }
  class Cls_Contact_Invoice {
    public String internal_id;  //some_uniq_id
  }
  class Cls_Custom_Fields_Invoice {
    public String PO_Number_SF;  //black
  }
  class Cls_Customer_Invoice {
    public String internal_id;  //some_uniq_id
  }
    
    
    
    //Payment Wrapper
    
    public class PaymentWrapper{
       public Cls_Items_Payment[] items;
    }
  class Cls_Items_Payment {
    public Cls_Integration_Payment integration;
    public Cls_Payment payment;
  }
  class Cls_Integration_Payment {
    public String internal_id;  //some_uniq_id
  }
  class Cls_Payment {
    public Integer amount;  //2500
    public Integer applied_amount;  //1000
    public Cls_Apply_List_Payment[] apply_list;
    public String channel;  //CASH
    public String currncy;  //USD
    public Cls_Customer_Payment customer;
    public Integer exchange_rate;  //1
    public String external_id;  //Yaypay-10015-6140223508-1b7eb6833179bd68
    public String payment_date;  //2020-11-17T00:00:00Z
    public String reference_number;  //PAYCH456743
  }
  class Cls_Apply_List_Payment {
    public Integer amount;  //1000
    public Integer applied_amount;  //1000
    public Cls_Invoice_Payment invoice;
    public String payment_date;  //2020-11-17T00:00:00Z
  }
  class Cls_Invoice_Payment {
    public String internal_id;  //some_uniq_id
  }
  class Cls_Customer_Payment {
    public String internal_id;  //some_uniq_id
  }
    
    
    //Files Wrapper
     public class FileWrapper{
       public Cls_Items_File[] items;
    }
    
    class Cls_Items_File {
        public Cls_Content_File content;
        public Cls_Integration_File integration;
    }
    class Cls_Content_File {
        public String base64_content;  //JVBER
        public String content_type;  //application/pdf
        public String file_name;  //INV_43212342.pdf
        public Cls_Invoice_File integration;
        public String supplementary_type;  //INVOICE
    }
    class Cls_Integration_File {
        public String internal_id;  //INVPDF111
        public String source;  //OTHER
    }
    class Cls_Invoice_File {
        public String internal_id;  //INVPDF111
        public String source;  //OTHER
    }
    
    //Credit Memo Wrapper.
    public class CreditMemoWrapper{
        public Cls_Items_CreditMemo[] items;
    }
    
  class Cls_Items_CreditMemo {
    public Cls_Credit_Memo credit_memo;
    public Cls_Integration_Credit integration;
  }
  class Cls_Credit_Memo {
    public Decimal amount;  //5000
    public Decimal applied_amount;  //1000
    public Cls_Apply_Invoice_List_Credit[] apply_invoice_list;
    public String currncy;  //USD
    public Cls_Customer_Credit customer;
    public Integer exchange_rate;  //1
    public String payment_date;  //2020-11-17T00:00:00Z
    public String reference_number;  //REF008887
  }
  class Cls_Apply_Invoice_List_Credit {
    public Decimal amount;  //1000
    public Cls_Apply_Entity_Credit apply_entity;
    public String payment_date;  //2020-11-17T00:00:00Z
  }
  class Cls_Apply_Entity_Credit {
    public String internal_id;  //some_uniq_id
  }
  class Cls_Customer_Credit {
    public String internal_id;  //some_uniq_id
  }
  class Cls_Integration_Credit {
    public String internal_id;  //some_uniq_id
  }
    class Cls_Integration_Credit_Invoice {
    public String internal_id;  //some_uniq_id
  }
    
    
    //delete entity Wrapper.
    public class DeleteItemWrapper{
        public cls_deleted_entities[] deleted_entities;
    }    
  class cls_deleted_entities {
    public String entity_type;  //CUSTOMERS
    public cls_integration integration;
  }
  class cls_integration {
    public String internal_id;  //some_uniq_id
  }
}