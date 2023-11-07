/**************************************************************************************************
Description: Controller class for CoreExchangeReturn LWCs
====================================================================================================
====================================================================================================
TestClass: CoreExchangeReturnCtrlTest
Code Coverage: %
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		08/28/2021		    Nikhil Kumar Srivastava		 Initial Creation
***************************************************************************************************/
public without sharing class CoreExchangeReturnCtrl 
{
    @Testvisible private static final String SUCCESS = 'Success';
    //private static final String CORE_UNIT_REPLACEMENT_INFORMATION_TEMPLATE = 'Core_Unit_Replacement_Information';
    //private static final String CORE_UNIT_REPLACEMENT_INFORMATION_TEMPLATE = 'Core_Unit_Replacement_Information_1';
    
    @AuraEnabled(cacheable=false)
    public static CustomerExchangeSummaryFormResponse getCoreExchangeRecord(String recordId) 
    {
        try 
        {
            System.debug(recordId);
            if(String.isNotBlank(recordId))
            {
               return new CustomerExchangeSummaryFormResponse(getCoreExchange(recordId));
            }
            
        } 
        catch (Exception e) 
        {
            LogService.createErrorLog('CoreExchangeReturnCtrl.apxc', NULL, e, NULL);
            System.debug('Debug** Error :  ' + e.getStackTraceString());
            throw new AuraHandledException('Failure ' + e.getMessage());
        }
        return NULL;
    }

    @AuraEnabled(cacheable=false)
    public static CustomerExchangeSummaryFormResponse saveCoreExchangeRecord(String customerExchangeSummaryJSON) 
    {
        try 
        {
            System.debug(customerExchangeSummaryJSON); 
            CustomerExchangeSummaryFormResponse cseFormResponseObj = (CustomerExchangeSummaryFormResponse)System.JSON.deserialize(customerExchangeSummaryJSON, 
                                                                                                                                CustomerExchangeSummaryFormResponse.class);
                                                            
            Customer_Exchange_Summary_Form_Response__c formResponse = saveCoreExchange(cseFormResponseObj);
            cseFormResponseObj.formResponseId = formResponse.Id;

            inscor__Customer_Exchange_Summary__c customerExchangeSummary = new inscor__Customer_Exchange_Summary__c();
            customerExchangeSummary.Id = formResponse.Customer_Exchange_Summary__c;
            customerExchangeSummary.Is_Exchange_Form_Submmited__c = true;
            customerExchangeSummary.Request_More_Information_JSON__c = null;
            //update customerExchangeSummary;
            fireExchangeFormResponseEvent(formResponse);
            return cseFormResponseObj;
        } 
        catch (Exception e) 
        {
            LogService.createErrorLog('CoreExchangeReturnCtrl.apxc', NULL, e, NULL);
            System.debug('Debug** Error :  ' + e.getStackTraceString());
            System.debug('Debug** Error :  ' + e.getMessage());
            throw new AuraHandledException('Failure ' + e.getMessage());
        }
    }

    private static void fireExchangeFormResponseEvent(Customer_Exchange_Summary_Form_Response__c formResponse) {
        Exchange_Form_Response__e formResponseEvent = new Exchange_Form_Response__e();
        formResponseEvent.Exchange_Summary_Id__c = formResponse.Customer_Exchange_Summary__c;
        Eventbus.publish(formResponseEvent);
    }

    @AuraEnabled
    public static void AfterSubmitProcess(String customerExchangeSummaryJSON){
        try {
            CustomerExchangeSummaryFormResponse cseFormResponseObj = (CustomerExchangeSummaryFormResponse)System.JSON.deserialize(customerExchangeSummaryJSON, 
                                                                                                                                CustomerExchangeSummaryFormResponse.class);
            addExchangeFormPDF(cseFormResponseObj.customerExchangeSummaryId, cseFormResponseObj.formResponseId);
            sendReplacementEmail(cseFormResponseObj.customerExchangeSummaryId, cseFormResponseObj.formResponseId);          
        } catch (Exception e) {
            LogService.createErrorLog('CoreExchangeReturnCtrl.apxc', NULL, e, NULL);
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled 
    public static String getPDFAsBase64(String formResponseId) {
        Blob bodyBlob = generatePDF(formResponseId); 
        return EncodingUtil.base64Encode(bodyBlob);
      }
        
    private static inscor__Customer_Exchange_Summary__c getCoreExchange(String recordId)
    { 
        return 
        [ 
            SELECT 
                ID,
                inscor__Customer__c,
                inscor__Original_SO_ID__r.inscor__Customer_PO_Number__c,
                inscor__Original_Product__c,
                inscor__Original_Product__r.Name, Request_More_Information_JSON__c
            FROM inscor__Customer_Exchange_Summary__c
            WHERE Id = :recordId
            LIMIT 1
        ]; 
    }

    public class CustomerExchangeSummaryFormResponse
    {
        @AuraEnabled public Id customerExchangeSummaryId { get; set; }
        @AuraEnabled public Id formResponseId { get; set; }
        @AuraEnabled public Id SOId { get; set; }
        @AuraEnabled public String CompanyName { get; set; }
        @AuraEnabled public String CustomerPO { get; set; }
        @AuraEnabled public String PN { get; set; }
        @AuraEnabled public Id PN_ID { get; set; }
        
        @AuraEnabled public String SN { get; set; }
        @AuraEnabled public String TSO { get; set; }
        @AuraEnabled public String TSO_TSN { get; set; }
        @AuraEnabled public String CSO { get; set; }
        @AuraEnabled public String CSO_CSN { get; set; }
        @AuraEnabled public String ReasonForRemoval { get; set; }
        @AuraEnabled public String RemovalComment { get; set; }
        @AuraEnabled public String AircraftModel { get; set; }
        @AuraEnabled public String AircraftSN { get; set; }
        @AuraEnabled public String ACTSN { get; set; }
        @AuraEnabled public String ACCSN { get; set; }
        @AuraEnabled public String AWB { get; set; }
        @AuraEnabled public String Carrier { get; set; }
        @AuraEnabled public String FormResponseTitle { get; set; }
        @AuraEnabled public Boolean AgreementToNonIncident { get; set; }
        @AuraEnabled public Id ParentFormResponse { get; set; }
        @AuraEnabled public Boolean Locked { get; set; } 
        @AuraEnabled public Boolean printButtonDisabled { get; set; } 
        @AuraEnabled public String requestinfoJSON { get; set; }
        @AuraEnabled public String Address { get; set; }
        @AuraEnabled public String Position { get; set; }
        @AuraEnabled public String CustomerName { get; set; }
        @AuraEnabled public Integer numberOfDayResponseCreated { get; set; }


        public CustomerExchangeSummaryFormResponse(inscor__Customer_Exchange_Summary__c customerExchangeSummary)
        {
            List<Customer_Exchange_Summary_Form_Response__c> formResponses = getCurrentActiveResponse(customerExchangeSummary.Id);
            this.customerExchangeSummaryId = customerExchangeSummary.Id;
            this.CompanyName = customerExchangeSummary.inscor__Customer__c;
            this.CustomerPO = customerExchangeSummary.inscor__Original_SO_ID__r?.inscor__Customer_PO_Number__c;
            this.PN = customerExchangeSummary.inscor__Original_Product__r?.Name;
            this.PN_ID = customerExchangeSummary.inscor__Original_Product__c;
            this.SOId = customerExchangeSummary.inscor__Original_SO_ID__c;
            this.Locked = formResponses != null && !formResponses.isEmpty() ? formResponses[0].Locked__c : false;
            this.printButtonDisabled = formResponses != null && !formResponses.isEmpty() ? false : true;
            if (String.isNotBlank(customerExchangeSummary.Request_More_Information_JSON__c)) {
                this.requestinfoJSON = customerExchangeSummary.Request_More_Information_JSON__c;
            }
            if (formResponses != null && !formResponses.isEmpty()) {//Added By Vinod Kumar Sharma for pre-populated values
                this.formResponseId = formResponses[0].Id;
                this.SN = formResponses[0].SN__c;
                this.TSO = formResponses[0].TSO__c;
                this.CSO = formResponses[0].CSO__c;
                if(String.isNotBlank(formResponses[0].TSO__c))
                {
                    if(formResponses[0].TSO__c == 'TSO')
                    {
                        this.TSO_TSN = formResponses[0].TSO_Value__c;
                    } 
                    else 
                    {
                        this.TSO_TSN = formResponses[0].TSN_Value__c;
                    }
                }
                if(String.isNotBlank(formResponses[0].CSO__c))
                {
                    if(formResponses[0].CSO__c == 'CSO')
                    {
                        this.CSO_CSN = formResponses[0].CSO_Value__c;
                    } 
                    else 
                    {
                        this.CSO_CSN = formResponses[0].CSN_Value__c;
                    }
                }
                this.ReasonForRemoval = formResponses[0].Reason_for_Removal__c;
                this.RemovalComment = formResponses[0].Reason_for_Removal_Comments__c;
                this.AircraftModel = formResponses[0].Aircraft_Model__c;
                this.AircraftSN = formResponses[0].Aircraft_SN__c;
                this.ACTSN = formResponses[0].AC_TSN__c;
                this.ACCSN = formResponses[0].AC_CSN__c;
                this.AWB = formResponses[0].AWB__c;
                this.Carrier = formResponses[0].Carrier__c;
                this.AgreementToNonIncident = formResponses[0].Agreement_to_Non_Incident_Statement__c;
                this.ParentFormResponse = formResponses[0].Parent_Form_Response__c;
                this.CustomerName = formResponses[0].Name__c;
                this.Address = formResponses[0].Address__c;
                this.Position = formResponses[0].Position__c;
                Date createDate = Date.newinstance(formResponses[0].CreatedDate.year(), formResponses[0].CreatedDate.month(), formResponses[0].CreatedDate.day());
                this.numberOfDayResponseCreated = createDate.daysBetween(System.today());
            }

        }
    }

    private static Customer_Exchange_Summary_Form_Response__c saveCoreExchange(CustomerExchangeSummaryFormResponse cseFormResponseObj)
    {
        Customer_Exchange_Summary_Form_Response__c cseFormResponse = getCustomerExchangeSummaryFormResponse(cseFormResponseObj);
        if (cseFormResponse.Id != Null) {
            cseFormResponse.Locked__c = true;
            List<Customer_Exchange_Summary_Form_Response__c> responsesToUpsert = new List<Customer_Exchange_Summary_Form_Response__c>();
            responsesToUpsert.add(cseFormResponse);
            upsert responsesToUpsert;
        }else {
            insert cseFormResponse;
        }
        return cseFormResponse;
    }

    private static Customer_Exchange_Summary_Form_Response__c getCustomerExchangeSummaryFormResponse(CustomerExchangeSummaryFormResponse cseFormResponseObj)
    {
        Customer_Exchange_Summary_Form_Response__c cseFormResponse = new Customer_Exchange_Summary_Form_Response__c();
        cseFormResponse.Customer_Exchange_Summary__c = cseFormResponseObj.customerExchangeSummaryId;
        cseFormResponse.Customer_Name__c = cseFormResponseObj.CompanyName;
        cseFormResponse.Customer_PO_Number__c = cseFormResponseObj.CustomerPO;
        cseFormResponse.PN__c = cseFormResponseObj.PN_ID;
        cseFormResponse.SN__c = cseFormResponseObj.SN;
        cseFormResponse.TSO__c = cseFormResponseObj.TSO;
        cseFormResponse.CSO__c = cseFormResponseObj.CSO;
        cseFormResponse.Reason_for_Removal__c = cseFormResponseObj.ReasonForRemoval;
        cseFormResponse.Reason_for_Removal_Comments__c = cseFormResponseObj.RemovalComment;
        cseFormResponse.Aircraft_Model__c = cseFormResponseObj.AircraftModel;
        cseFormResponse.Aircraft_SN__c = cseFormResponseObj.AircraftSN;
        cseFormResponse.AC_TSN__c = cseFormResponseObj.ACTSN;
        cseFormResponse.AC_CSN__c = cseFormResponseObj.ACCSN;
        cseFormResponse.AWB__c = cseFormResponseObj.AWB;
        cseFormResponse.Carrier__c = cseFormResponseObj.Carrier;
        cseFormResponse.Agreement_to_Non_Incident_Statement__c = cseFormResponseObj.AgreementToNonIncident;
        cseFormResponse.Parent_Form_Response__c = cseFormResponseObj.ParentFormResponse;
        cseFormResponse.Sales_Order__c = cseFormResponseObj.SOId;
        //Start : Added by Vinod for only one response for one customer exchange summary
        cseFormResponse.Address__c = cseFormResponseObj.Address;
        cseFormResponse.Position__c = cseFormResponseObj.Position;
        cseFormResponse.Name__c = cseFormResponseObj.CustomerName;
        cseFormResponse.Id = cseFormResponseObj.formResponseId; 
        //End : Added by Vinod for only one response for one customer exchange summary
        cseFormResponse.TSO_Value__c = '';
        cseFormResponse.TSN_Value__c = '';
        cseFormResponse.CSO_Value__c = '';
        cseFormResponse.CSN_Value__c = '';
        if(String.isNotBlank(cseFormResponse.TSO__c))
        {
            if(cseFormResponse.TSO__c == 'TSO')
            {
                cseFormResponse.TSO_Value__c = cseFormResponseObj.TSO_TSN;
            } 
            else 
            {
                cseFormResponse.TSN_Value__c = cseFormResponseObj.TSO_TSN;
            }
        }
        if(String.isNotBlank(cseFormResponse.CSO__c))
        {
            if(cseFormResponse.CSO__c == 'CSO')
            {
                cseFormResponse.CSO_Value__c = cseFormResponseObj.CSO_CSN;
            } 
            else 
            {
                cseFormResponse.CSN_Value__c = cseFormResponseObj.CSO_CSN;
            }
        }

        return cseFormResponse;
    }

    
    public static void sendReplacementEmail(Id customerExchangeSummaryId, Id formResponseId)
    {
        try 
        {
            if(String.isNotBlank(customerExchangeSummaryId)) 
            {
                List<inscor__Customer_Exchange_Summary__c> customerExchangeSummary =  new List<inscor__Customer_Exchange_Summary__c>
                                                                                    ([
                                                                                        SELECT 
                                                                                            Id,
                                                                                            inscor__Original_SO_ID__c, 
                                                                                            inscor__Original_SO_ID__r.inscor__Assigned_To__r.Email,
                                                                                            inscor__Original_SO_ID__r.inscor__Contact__r.Email,
                                                                                            inscor__Original_SO_ID__r.inscor__Dropship_ATTN__r.Email
                                                                                        FROM inscor__Customer_Exchange_Summary__c
                                                                                        WHERE Id =: customerExchangeSummaryId
                                                                                    ]);
                if(customerExchangeSummary != NULL && !customerExchangeSummary.isEmpty())
                {
                    Id emailTemplateId = [  SELECT Id FROM EmailTemplate 
                                            WHERE DeveloperName =: Constants.EMAIL_TEMPLATE_SUBMIT_CORE_EXCHANGE_FORM 
                                            LIMIT 1]?.Id;
                    inscor__Customer_Exchange_Summary__c iceRec = customerExchangeSummary[0];
                    if(emailTemplateId == NULL) 
                    {
                        LogService.createErrorLog('FollowUpEmailCtrl.cls', NULL, NULL, Constants.EMAIL_TEMPLATE_SUBMIT_CORE_EXCHANGE_FORM+ ' Email template does not exist.');
                        return;
                    }
                    /* Assumption : Only one record will come because we have recordId Check in Query */
                    Map<Id, List<String>> cseIdtoTOAddressMap = new Map<Id, List<String>>();
                    Map<Id, List<String>> objIdtoCCAddress = new Map<Id, List<String>>();
                    List<String> ccEmailAddresses = new List<String>{Label.Core_Exchange_Customer_CC_EmailAddress};
                    if(!cseIdtoTOAddressMap.containsKey(iceRec.Id))
                    { 
                        cseIdtoTOAddressMap.put(iceRec.Id, new List<String>());
                        objIdtoCCAddress.put(iceRec.Id, ccEmailAddresses);
                        if(String.isNotBlank(iceRec.inscor__Original_SO_ID__c))
                        {
                            if(iceRec.inscor__Original_SO_ID__r.inscor__Contact__r != NULL && iceRec.inscor__Original_SO_ID__r.inscor__Contact__r.Email != NULL){
                                cseIdtoTOAddressMap.get(iceRec.Id)
                                    .add(iceRec.inscor__Original_SO_ID__r.inscor__Contact__r.Email);
                            }else if (iceRec.inscor__Original_SO_ID__r.inscor__Dropship_ATTN__r != NULL && iceRec.inscor__Original_SO_ID__r.inscor__Dropship_ATTN__r.Email != NULL) {
                                cseIdtoTOAddressMap.get(iceRec.Id)
                                    .add(iceRec.inscor__Original_SO_ID__r.inscor__Dropship_ATTN__r.Email);
                            }
                            
                            if(iceRec.inscor__Original_SO_ID__r.inscor__Assigned_To__r != NULL && iceRec.inscor__Original_SO_ID__r.inscor__Assigned_To__r.Email != NULL)
                                cseIdtoTOAddressMap.get(iceRec.Id)
                                    .add(iceRec.inscor__Original_SO_ID__r.inscor__Assigned_To__r.Email);
                                
                        }
                        cseIdtoTOAddressMap.get(iceRec.Id)
                                    .add(System.Label.Customer_Support_Email);
                    }
                    Blob bodyBlob = generatePDF(formResponseId);
                    System.debug('sendReplacementEmail.cseIdtoTOAddressMap' + JSON.serializePretty(cseIdtoTOAddressMap));
                    CommonUtility.sendEmailWithAttachment(emailTemplateId, cseIdtoTOAddressMap, objIdtoCCAddress, NULL, bodyBlob, 'CoreExchangeFormResponse', '.pdf');
                } 
                else 
                {
                    LogService.createErrorLog('FollowUpEmailCtrl.cls', NULL, NULL, 'No Customer Exchange Record exists with this Id ' + customerExchangeSummaryId);
                }                                                                    
            }
            else 
            {
                LogService.createErrorLog('FollowUpEmailCtrl.cls', NULL, NULL, 'No Customer Exchange Record exists with this Id ' + customerExchangeSummaryId);
            }
            if(Test.isRunningTest())
                Integer i = 1/0;  
        } 
        catch (Exception e) 
        {
            System.debug('Exception Occured: '+e.getMessage());
            LogService.createErrorLog('FollowUpEmailCtrl.cls', NULL, e, NULL);
        }
    }

    /**
     * @author : Vinod Kumar Sharma
     * @date : 08/09/2021
     * @description : Method used to get the current active Customer Exchange Summary Form Response
     * @lastModifiedDate : 08/09/2021
     */
    private static List<Customer_Exchange_Summary_Form_Response__c> getCurrentActiveResponse(String customerExchangeSummaryId) {
        List<Customer_Exchange_Summary_Form_Response__c> activeExchangeSummaryFormResponseList = [SELECT 
                                                                                                    Id, 
                                                                                                    Active__c,
                                                                                                    Locked__c,
                                                                                                    SN__c,
                                                                                                    TSO__c,
                                                                                                    CSO__c,
                                                                                                    Reason_for_Removal__c,
                                                                                                    Reason_for_Removal_Comments__c,
                                                                                                    Aircraft_Model__c,
                                                                                                    Aircraft_SN__c,
                                                                                                    AC_TSN__c,
                                                                                                    AC_CSN__c,
                                                                                                    AWB__c,
                                                                                                    Carrier__c,
                                                                                                    Agreement_to_Non_Incident_Statement__c,
                                                                                                    Parent_Form_Response__c,
                                                                                                    TSO_Value__c,
                                                                                                    TSN_Value__c,
                                                                                                    CSO_Value__c,
                                                                                                    CSN_Value__c,
                                                                                                    Address__c,
                                                                                                    Name__c,
                                                                                                    Position__c,
                                                                                                    CreatedDate
                                                                                                FROM Customer_Exchange_Summary_Form_Response__c 
                                                                                                WHERE  Customer_Exchange_Summary__c = :customerExchangeSummaryId AND Active__c = true
                                                                                                LIMIT 1];
        return activeExchangeSummaryFormResponseList;
    }

    /**
     * @description : Method used to attach pdf with customer exchange form response record when form submmited
     */
    private static void addExchangeFormPDF(Id customerExchangeSummaryId, Id formResponseId) {
        List<Attachment> existAttachments = [SELECT Id FROM Attachment WHERE ParentId = :formResponseId];
        Blob bodyBlob = generatePDF(formResponseId); 
        Attachment attach = new Attachment();
        attach.Body = bodyBlob;
        attach.Name = 'ExchangeFormResopnse_Ver_' + (existAttachments.size() + 1) + '.pdf';
        attach.IsPrivate = false;
        attach.ParentId = formResponseId;
        insert attach;
    }

    /**
     * @author : Vinod Kumar Sharma
     * @description : it will generate the pdf of exchange response form
     */
    public static Blob generatePDF(String customerExchangeFormResponseId) {
        try {
            PageReference page = new PageReference('/apex/CoreExchangeFormResponsePDF');
            page.getParameters().put('Id', customerExchangeFormResponseId);
            return (!Test.isRunningTest()) ? page.getContent() : Blob.valueOf('Test Class Page Content!');
            //return page.getContent();
        } catch (Exception error) {
            LogService.createErrorLog('FollowUpEmailCtrl.cls', NULL, error, NULL);
            return null;
        }
    }



}