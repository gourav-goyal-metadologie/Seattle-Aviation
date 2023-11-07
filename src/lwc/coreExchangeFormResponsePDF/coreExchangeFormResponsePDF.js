import { LightningElement,api } from 'lwc';
import getCurrentPageReference from '@salesforce/apex/CoreExchangeFormResponsePDFCtrl.getCurrentPageReference';

export default class CoreExchangeFormResponsePDF extends LightningElement {

    @api responseId;
    
    siteURL;

    connectedCallback() {

        getCurrentPageReference()
            .then((result) => {
                console.log(result);
            })
            .catch((error) => {
                console.error(error);
            });
        
        this.siteURL = 'https://ggdevmay16-seattleav.cs171.force.com/apex/CoreExchangeFormResponsePDF';

    }
}