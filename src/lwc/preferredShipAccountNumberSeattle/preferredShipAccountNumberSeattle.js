import { LightningElement, track } from 'lwc';
import getPreferredShipAccountNumberDetails from '@salesforce/apex/GetPreferredShipAccountNumber.getPreferredShipAccountNumberDetails';

export default class PreferredShipAccountNumberSeattle extends LightningElement {
    @track shipAccountNumber;
    connectedCallback(){
        console.log('Reached here');
        getPreferredShipAccountNumberDetails()
        .then(result=>{
            this.shipAccountNumber = result;
        })
        .catch(error=>{
            console.log('Error: ',error);
        })
    }
}