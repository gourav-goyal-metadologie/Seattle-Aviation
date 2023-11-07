import { LightningElement, api, wire, track } from 'lwc';
import getEmailRenderedTemplate from '@salesforce/apex/FollowUpEmailCtrl.getEmailRenderedTemplate';
import sendFollowUpEmail from '@salesforce/apex/FollowUpEmailCtrl.sendFollowUpEmail';
import getFollowUpWrapper from '@salesforce/apex/FollowUpEmailCtrl.getFollowUpWrapper';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';

export default class FollowUp extends LightningElement {
    @api recordId;
    retrievedRecordId = false;
    responseAvailble = false;
    isLoading = true;
    isReady = false;
    textAreaValue = '';
    selectedFields = [];
    isValid = true;
    @track emailbody;

    renderedCallback() {
        if (!this.retrievedRecordId && this.recordId) {     
            this.retrievedRecordId = true;
            this.getCustomerExchangesummary();
        }
    }

    inputChangeHandler(event) {
        const inputName = event.target.name;
        if(inputName === 'Subject'){
            this.emailbody.Subject = event.target.value;
        } else if(inputName === 'TextBody'){
            this.emailbody.TextBody = event.target.value;
            this.emailbody.HtmlBody = event.target.value;
        }
    }

    getCustomerExchangesummary(){
        getFollowUpWrapper({customerExchangeSummaryId : this.recordId})
            .then(result => {
                let summary = result;
                if (!summary.isValid && summary.errorMessage != '') {
                    this.showToast('Error', summary.errorMessage, 'error');
                    this.closeAction();
                    this.isLoading = false;
                }else{
                    this.getEmailRenderedTemplate();
                    //this.isReady = true;
                }
                
            })
            .catch(error => {
                // TODO Error handling
                console.error(error);
                this.showToast('Error', 'Something went wrong!', 'error');
                this.closeAction();
            });
    }

    getEmailRenderedTemplate(){
        if(this.emailbody === undefined) {
            getEmailRenderedTemplate({ recordId: this.recordId })
            .then((result) => {
                this.emailbody = result;
                this.isReady = true;
                this.isLoading = false;
            })
            .catch((error) => {
                console.error(error);
                this.showToast('Error', error, 'error');
                this.closeAction();
            });
        }
        
    }

    sendEmail(event){
        /**
         * Sanatizing the textbody
         */
        //this.emailbody.TextBody = this.emailbody.TextBody.replace( /(<([^>]+)>)/ig, '');
        sendFollowUpEmail({ recordId: this.recordId, emailBodyJSON: JSON.stringify(this.emailbody) })
            .then((result) => {
                if(result.includes('Success')) {
                    this.showToast('Success', 'Follow up email has been sent.', 'success');
                    this.closeAction();
                } else {
                    this.showToast('Error', error.body.message, 'error');
                    console.error(error);
                }
            })
            .catch((error) => {
                this.showToast('Error', error.body.message, 'error');
                console.error(error);
            });
    }

    closeAction(){
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
}