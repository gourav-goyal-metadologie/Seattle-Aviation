import { LightningElement, track,api } from 'lwc';
import getPreferredShipAccountNumberDetails from '@salesforce/apex/GetPreferredShipAccountNumber.getPreferredShipAccountNumberDetails';

export default class PreferredShipAccountNumber extends LightningElement {
    /*@wire(getPreferredShipAccountNumberDetails) accountNumber;
    console.log('details',accountNumber);*/
    @api strRecordId = '{!$GlobalConstant.False}';
    @api recordId = '{!cartId}';
    @track myString;
    connectedCallback(){
        getPreferredShipAccountNumberDetails()
        .then(result=>{
            this.myString = result;
            console.log('result: ',result);
        })
        .catch(error=>{
            console.log('Error: ',error);
        })
    }
}