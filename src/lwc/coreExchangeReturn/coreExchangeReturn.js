import { LightningElement, track, wire } from 'lwc';
import getCoreExchangeRecord from '@salesforce/apex/CoreExchangeReturnCtrl.getCoreExchangeRecord';
import saveCoreExchangeRecord from '@salesforce/apex/CoreExchangeReturnCtrl.saveCoreExchangeRecord';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import CUSTOMER_EX_SUM_FORM_OBJECT from '@salesforce/schema/Customer_Exchange_Summary_Form_Response__c';
import TSO_FIELD from '@salesforce/schema/Customer_Exchange_Summary_Form_Response__c.TSO__c';
import REASONFORREMOVAL_FIELD from '@salesforce/schema/Customer_Exchange_Summary_Form_Response__c.Reason_for_Removal__c';
import CARRIER_FIELD from '@salesforce/schema/Customer_Exchange_Summary_Form_Response__c.Carrier__c';
import CSO_FIELD from '@salesforce/schema/Customer_Exchange_Summary_Form_Response__c.CSO__c';
import SAS_LOGO from '@salesforce/resourceUrl/SAS_LOGO';
import AfterSubmitProcess from "@salesforce/apex/CoreExchangeReturnCtrl.AfterSubmitProcess";
import getPDFAsBase64 from "@salesforce/apex/CoreExchangeReturnCtrl.getPDFAsBase64";

export default class CoreExchangeReturn extends LightningElement {

    coreExchangeRecordId;
    logoImg = SAS_LOGO;
    @track exchangeRecord;
    formResponse;
    informationMessage = 'Please kindly fill-in information listed below to the best of your knowledge and sign.';
    requiredApiNames = [];
    fieldValidationChecked = true;

    /* pageTitle = 'Customer Exchange' */
    showForm = false;
    noRecord = false;
    formSuccess = false;
    locked = false;
    printButtonDisabled = true;
    formAlreadySubmmited = false;
    invalidLink = false;

    showTSOTextbox = false;
    showCSOTextbox = false;
    showRemovalComment = false;

    /* formError */

    isLoading = false;

    tsoHelpText = "TSO/TSN";
    csoHelpText = "CSO/CSN";
    pnHelpText = "PN";
    snHelpText = "SN";
    aircraftSNHelpText = "Aircraft SN";
    acTSNHelpText = "AC TSN";
    acCSNHelpText = "AC CSN";
    awbSNHelpText = "AWB";




    TSO_TSN_Title;
    CSO_CSN_Title;

    @wire(getObjectInfo, { objectApiName: CUSTOMER_EX_SUM_FORM_OBJECT })
    objectInfo; 

    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: TSO_FIELD})
    TSOPicklistValues;
    
    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: REASONFORREMOVAL_FIELD})
    ReasonForRemovalPicklistValues;
    
    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: CARRIER_FIELD})
    CarrierPicklistValues;
    
    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: CSO_FIELD})
    CSOPicklistValues;
    
    get today(){
        return new Date().toDateString();
    }

    connectedCallback(){
        this.parameters = this.getQueryParameters();
        this.isLoading = true;
        if(this.parameters != '' && this.parameters != undefined ){
            if(this.parameters.id != '' && this.parameters.id != undefined){
                this.coreExchangeRecordId = this.parameters.id;
            }
        }    

        if(!this.coreExchangeRecordId){
            console.error('Invalid Id');
            this.showForm = false;
            this.noRecord = true;
            this.isLoading = false;
        } else {
            console.log(this.coreExchangeRecordId);
            this.getCoreExchangeRecord();
        }
    }

    renderedCallback(){
        if (!this.fieldValidationChecked) {
            this.handleMoreInformation();
        }
    }

    getQueryParameters() {
        var params = {};
        var search = location.search.substring(1);
        if (search) {
            params = JSON.parse('{"' + search.replace(/&/g, '","').replace(/=/g, '":"') + '"}', (key, value) => {
                return key === "" ? value : decodeURIComponent(value);
            });
        }
        return params;
    }    

    getCoreExchangeRecord(){
        getCoreExchangeRecord({ recordId: this.coreExchangeRecordId })
            .then((result) => {
                if(result != null && result != undefined){
                    this.exchangeRecord = result;
                    this.locked = this.exchangeRecord.Locked;
                    this.showForm = true;
                    if (this.locked) {
                        this.showForm = false;
                        if (this.exchangeRecord.formResponseId && this.exchangeRecord.formResponseId != '') {
                            let daysBetweenCreated = parseInt(this.exchangeRecord.numberOfDayResponseCreated);
                            if (daysBetweenCreated > 30) {
                                this.invalidLink = true;
                            }else{
                                this.formAlreadySubmmited = true;
                                this.printButtonDisabled = false;
                            }
                        }
                    }else{
                        if (this.exchangeRecord.requestinfoJSON != undefined) {
                            let requestInfo = JSON.parse(this.exchangeRecord.requestinfoJSON);
                            this.informationMessage = requestInfo.informationMessage;
                            this.requiredApiNames = requestInfo.selectedFields;
                            if (this.requiredApiNames != undefined && Array.isArray(this.requiredApiNames) && this.requiredApiNames.length > 0) {
                                this.fieldValidationChecked = false;
                            }
                        }
                    }
                    this.renderTSOTextBox(); //Update during SS-161
                    this.renderCSOTextBox(); //Update during SS-161
                    this.renderRemovalComment();
                }
                this.isLoading = false;   
            })
            .catch((error) => {
                this.isLoading = false;
                console.error(error);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: error, 
                        variant: 'Error',
                    }));
                this.noRecord = true;    
            });
    } 
    
    inputChangeHandler(event) {
        const inputName = event.target.name;
        if(inputName === 'SN'){
            this.exchangeRecord.SN = event.target.value;
        } else if(inputName === 'TSO'){
            this.exchangeRecord.TSO = event.target.value;
            this.exchangeRecord.TSO_TSN = undefined; //Updated during SS-161
            this.renderTSOTextBox();
        } else if(inputName === 'CSO'){
            this.exchangeRecord.CSO = event.target.value;
            this.exchangeRecord.CSO_CSN = undefined; //Updated during SS-161
            this.renderCSOTextBox();
        } else if(inputName === 'TSO_TSN'){
            this.exchangeRecord.TSO_TSN = event.target.value;
        } else if(inputName === 'CSO_CSN'){
            this.exchangeRecord.CSO_CSN = event.target.value;
        } else if(inputName === 'ReasonForRemoval'){
            this.exchangeRecord.ReasonForRemoval = event.target.value;
            this.exchangeRecord.RemovalComment = undefined;
            this.renderRemovalComment();
        } else if(inputName === 'RemovalComment'){
            this.exchangeRecord.RemovalComment = event.target.value;
        } else if(inputName === 'AircraftSN'){
            this.exchangeRecord.AircraftSN = event.target.value;
        } else if(inputName === 'ACTSN'){
            this.exchangeRecord.ACTSN = event.target.value;
        } else if(inputName === 'ACCSN'){
            this.exchangeRecord.ACCSN = event.target.value;
        } else if(inputName === 'Carrier'){
            this.exchangeRecord.Carrier = event.target.value;
        } else if(inputName === 'AWB'){
            this.exchangeRecord.AWB = event.target.value; 
        } else if(inputName === 'AgreementToNonIncident'){
            this.exchangeRecord.AgreementToNonIncident = event.target.checked;
        } else if(inputName === 'AircraftModel'){
            this.exchangeRecord.AircraftModel = event.target.value;
        }else if(inputName === 'Address'){ //Added by Vinod 
            this.exchangeRecord.Address = event.target.value;
        }else if(inputName === 'CustomerName'){ //Added by Vinod
            this.exchangeRecord.CustomerName = event.target.value;
        }else if(inputName === 'Position'){ //Added by Vinod
            this.exchangeRecord.Position = event.target.value;
        }
        try {
            this.template.querySelector('[data-name= "' + inputName + '"]').classList.remove('slds-has-error');
        } catch (error) {
            
        }
    }

    renderTSOTextBox(){
        this.showTSOTextbox = this.exchangeRecord.TSO != undefined;
        this.TSO_TSN_Title = this.exchangeRecord.TSO;
    }

    renderCSOTextBox(){
        this.showCSOTextbox = this.exchangeRecord.CSO != undefined;
        this.CSO_CSN_Title = this.exchangeRecord.CSO;
    }

    get showTSO_CSO(){
        return this.exchangeRecord != undefined &&
            (this.exchangeRecord.TSO != undefined || this.exchangeRecord.CSO != undefined);
    }

    renderRemovalComment(){
        if(this.exchangeRecord.ReasonForRemoval == 'Others'){
            this.showRemovalComment = true;
        } else {
            this.showRemovalComment = false;
        }
    }

    submitForm(event){
        this.isLoading = true;
        console.log(this.exchangeRecord);
        console.log(JSON.stringify(this.exchangeRecord));
        if(this.validateRequest()){
            saveCoreExchangeRecord({ customerExchangeSummaryJSON: JSON.stringify(this.exchangeRecord) })
            .then((result) => {
                //this.isLoading = false;
                if(result != null && result != undefined){
                    console.log(result);
                    this.exchangeRecord = result;
                    this.afterSubmitProcess(); //Added by Vinod Sharma Under SS-214
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Success', 
                            variant: 'Success',
                        }));

                    this.formSuccess = true;
                    this.showForm = false;    
                }   
            })
            .catch((error) => {
                this.isLoading = false;
                console.error(error);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: error, 
                        variant: 'Error',
                    }));
            });
        } else {
            this.isLoading = false;
        }
    } 

    validateRequest(){
        var isValid = true;
        var inValidMessage = '';
        if(!this.exchangeRecord.AgreementToNonIncident){
            isValid = false;
            inValidMessage = 'Please provide agreement Non Incident Statement';
        }

        if(!isValid){
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: inValidMessage, 
                    variant: 'Error',
                }));    
        }
        return isValid;
    }

    //Added by Vinod Sharma Under SS-214
    afterSubmitProcess(){
        this.printButtonDisabled = false;
        this.locked = true;
        AfterSubmitProcess({customerExchangeSummaryJSON: JSON.stringify(this.exchangeRecord)})
            .then(result => {
                console.log('After Submit Process Completed');
            })
            .catch(error => {
                console.log('error');
                console.log(error);
            });
        this.isLoading = false;
    }

    handlePrint(event){
        console.log('responseId ->' + this.exchangeRecord.formResponseId);
        let redirectURL = '/sfdcpage/%2Fapex%2FCoreExchangeFormResponsePDF%3F%26id%3D' + this.exchangeRecord.formResponseId;
        let urlString = window.location.href;
        let baseURL = urlString.substring(0, urlString.indexOf('/s/'));
        console.log('Base Url : ' + baseURL);
        if (redirectURL != undefined) {
            console.log('Redirect URL : ' + (baseURL +'/s'+ redirectURL));
            window.location = baseURL+'/s'+ redirectURL;
        }else {
            console.log('Error');
        }
        
    }

    handleSaveAsPdf(){
        this.isLoading = true;
        getPDFAsBase64({formResponseId : this.exchangeRecord.formResponseId})
            .then(result => {
                let downloadLink = document.createElement("a");
                downloadLink.href = "data:text/html;base64,"+result;
                downloadLink.download = "CoreExchangeFormResponse.pdf";
                downloadLink.click();
                this.isLoading = false;
            })
            .catch(error => {
                // TODO Error handling
                console.log(error);
                this.isLoading = false;
            });
    }


    handleMoreInformation(){
        try {
            for (let index = 0; index < this.requiredApiNames.length; index++) {
                const fieldApiName = this.requiredApiNames[index];
                this.template.querySelector('[data-name= "' + fieldApiName + '"]').classList.add('slds-has-error');
            }
            this.fieldValidationChecked = true;
        } catch (error) {
            console.log(error);
        }
    }



}