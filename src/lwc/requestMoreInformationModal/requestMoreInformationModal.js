import { api, LightningElement, wire } from 'lwc';
import { getRecord, getFieldValue} from 'lightning/uiRecordApi';
import { CloseActionScreenEvent } from 'lightning/actions';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import saveRequestMoreInformationMessage from '@salesforce/apex/RequestMoreInformationController.saveRequestMoreInformationMessage';
import getCustomerSummary from '@salesforce/apex/RequestMoreInformationController.getCustomerSummary';
import isCustomerExchangeFormResponseAvailable from '@salesforce/apex/RequestMoreInformationController.isCustomerExchangeFormResponseAvailable';
import EXCHANGE_STATUS_FIELD from '@salesforce/schema/inscor__Customer_Exchange_Summary__c.inscor__Exchange_Status__c';
import INSCOR__ORIGINAL_CORE_DUE_DATE_FIELD from '@salesforce/schema/inscor__Customer_Exchange_Summary__c.inscor__Original_Core_Due_Date__c';

const FIELDS = [EXCHANGE_STATUS_FIELD,
    INSCOR__ORIGINAL_CORE_DUE_DATE_FIELD
];

export default class RequestMoreInformationModal extends LightningElement {
    @api recordId;
    retrievedRecordId = false;
    responseAvailble = false;
    isLoading = true;
    isReady = false;
    textAreaValue = '';
    selectedFields = [];
    isValid = true;
    errorMessage = ''

    get availableFields() {
        return [
            { label: 'SN', value: 'SN' },
            { label: 'TSO', value: 'TSO' },
            { label: 'CSO', value: 'CSO' },
            { label: 'Aircraft Model', value: 'AircraftModel' },
            { label: 'ACTSN', value: 'ACTSN' },
            { label: 'ACCSN', value: 'ACCSN' },
            { label: 'AWB', value: 'AWB' },
            { label: 'Carrier', value: 'Carrier' },
            // { label: 'Agreement To Non-Incident', value: 'AgreementToNonIncident' },
        ];
    }
    
    renderedCallback() {
        if (!this.retrievedRecordId && this.recordId) {     
            this.retrievedRecordId = true;
            this.getCustomerExchangesummary();
        }
    }

    getCustomerExchangesummary(){
        getCustomerSummary({customerExchangeSummaryId : this.recordId})
            .then(result => {
                let summary = result;
                console.log(summary);
                this.errorMessage = summary.inscor__Exchange_Status__c !== 'Shipped' ? 'Exchange Status should be Shipped' : '';
                this.errorMessage = summary.inscor__Original_Core_Due_Date__c == null ? 'Original Due Date not available' : '';
                this.isValid =  this.errorMessage === '' ? true: false
                this.isReady = true;
                this.isLoading = false;
            })
            .catch(error => {
                // TODO Error handling
                console.error(error);
                this.isValid = false;
                this.errorMessage = 'Something went wrong';
                this.isReady = true;
                this.isLoading = false;
            });
    }
    
    handleSave() {
        let informationObject = {
            informationMessage : this.textAreaValue,
            selectedFields : this.selectedFields
        };

        let informationJson = JSON.stringify(informationObject);
        saveRequestMoreInformationMessage({ customerExchangeSummaryId: this.recordId, informationJSON: informationJson })
            .then(result => {
                console.log('success');
            })
            .catch(error => {
                console.log('error');
            });
        this.closeModal();
    }

    isFormResponseAvailable(){
        var textAreaField = this.template.querySelector('lightning-textarea');
        this.textAreaValue = textAreaField.value;
        
        if (this.textAreaValue == undefined || this.textAreaValue.trim() == '') {
            this.showToast('', 'Please fill the message', 'error');
            this.isLoading = false;
        } else {
            this.isLoading = true;
            isCustomerExchangeFormResponseAvailable({ customerExchangeSummaryId: this.recordId })
                .then(result => {
                    console.log(result);
                    if (result) {
                        this.handleSave();
                        this.showToast('', 'Request has been sent.', 'success');
                    } else {
                        this.showToast('', 'Excahnge Form Response Not available.', 'error');
                        this.handleCancel();

                    }
                })
                .catch(error => {
                    // TODO Error handling
                });
        }       
    }

    handleCancel(){
        this.closeModal();
    }

    closeModal(){
        console.log('test closeModal');
        this.dispatchEvent(new CloseActionScreenEvent());
    }

    showToast(title_Param, message_Param, variant_param) {
        const event = new ShowToastEvent({
            title: title_Param,
            message: message_Param,
            variant : variant_param,
        });
        this.dispatchEvent(event);
    }

    handleFieldSelection(event){
        this.selectedFields = event.detail.value;
    }

   
}