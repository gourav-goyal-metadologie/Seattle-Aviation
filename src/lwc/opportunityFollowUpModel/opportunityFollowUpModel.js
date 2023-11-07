import { api, LightningElement, track, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';
import getEmailBody from "@salesforce/apex/OpportunityFollowUpController.getEmailRenderedTemplate";
import getQuoteLines from "@salesforce/apex/OpportunityFollowUpController.getQuoteLines";
import sendFollowUpEmail from "@salesforce/apex/OpportunityFollowUpController.sendFollowUpEmail";
import CUSTOMER_QUOTE_FIELD from "@salesforce/schema/Opportunity.Customer_Quote__c";
import StayInTouchSignature from '@salesforce/schema/User.StayInTouchSignature';


export default class OpportunityFollowUpModel extends LightningElement {
    @api recordId;
    retrievedRecordId = false;
    isLoading = true;
    @track emailbody;
    isEmailBodyReady = false;
    vfPageName = '/apex/inscor__GenerateQuote_Master';
    pdfTitle = 'QUOTE';
    showPdf = false;

    
    @wire(getRecord, { recordId: '$recordId', fields: [ CUSTOMER_QUOTE_FIELD ] } )
    getOpportunityRecord ({error, data}) {
        if (error) {
            console.log('Error to get opportuniyt record');
        } else if (data) {
            console.log('Customer Quote Id:' + data.fields.Customer_Quote__c.value);
            //this.generateQuoteUrl = window.location.origin + '/apex/inscor__GenerateQuote_Master?id=' + data.fields.Customer_Quote__c.value;
            //this.showPdf = true;
        }
    }

    @wire(getQuoteLines, {opportunityId: '$recordId'})
    getQuoteLines ({error, data}) {
        if (error) {
            console.error(error);
            // TODO: Error handling
        } else if (data) {
            // TODO: Data handling
            let quoteId = '';
            let quoteLines = '';
            data.forEach(element => {
                quoteId = element.inscor__Customer_Quote__c;
                if (quoteLines != '') {
                    quoteLines += ',';
                }
                quoteLines += element.Id + ',';
            });
            if (quoteId != '') {
                this.generateQuoteUrl = this.vfPageName + '?id=' + quoteId + '&title=' + this.pdfTitle;
                if (quoteLines != '') {
                    this.generateQuoteUrl += '&cqid=' + quoteLines;
                }
                this.showPdf = true;
            }
        }
    }

    renderedCallback() {
        if (!this.retrievedRecordId && this.recordId) {     
            this.retrievedRecordId = true;
            this.getEmailRenderedTemplate();
        }
    }


    getEmailRenderedTemplate(){
        if(this.emailbody === undefined) {
            getEmailBody({ recordId: this.recordId })
            .then((result) => {
                this.emailbody = result;
                this.isEmailBodyReady = true;
                this.isLoading = false;
            })
            .catch((error) => {
                this.isLoading = false;
                this.showToastEvent('Error', error, 'Error');
                this.closeAction();
            });
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

    sendEmail(event){
        /**
         * Sanatizing the textbody
         */
        //this.emailbody.TextBody = this.emailbody.TextBody.replace( /(<([^>]+)>)/ig, '');
        sendFollowUpEmail({ recordId: this.recordId, emailBodyJSON: JSON.stringify(this.emailbody)})
            .then((result) => {
                if(result.includes('Success')) {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            variant: 'success'
                        }));
                        this.closeAction();
                } else {
                    console.error(result);
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error',
                            message: result,
                            variant: 'Error'
                        }));
                    this.closeAction();
                }
            })
            .catch((error) => {
                console.error(error);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: error, 
                        variant: 'Error',
                    }));
                this.closeAction();
            });
    }

    showToastEvent(param_title, param_messsage, param_variant){
        this.dispatchEvent(
            new ShowToastEvent({
                title: param_title,
                message: param_messsage, 
                variant: param_variant,
            })
        );
    }

    closeAction(){
        this.dispatchEvent(new CloseActionScreenEvent());
    }

}