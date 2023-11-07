import { LightningElement,track } from 'lwc';
import shippingNewAddress from '@salesforce/apex/shippingNewAddressController.shippingNewAddress';

export default class New_Address extends LightningElement {
    @track showaddressForm = false;
    strStreet;
    strCity;
    strState;
    strCountry;
    strPostalCode;
    @track shippingName = '';//Implemented By Ritesh

    
    show_Form() {
     
        this.showaddressForm = true;
    }
    close_Form() {
     
        this.showaddressForm = false;
    }
    save_Form() {
        //console.log('Address Added');
        //console.log('PostalCode1 ' + this.strPostalCode);
        this.showaddressForm = false;
        var IsError= false;
        if(this.strStreet == null || this.strStreet.trim() ==''||
        this.strCity == null || this.strCity.trim() ==''||
        this.strState == null || this.strState.trim() ==''||
        this.strCountry == null || this.strCountry.trim() ==''||
        this.strPostalCode == null || this.strPostalCode.trim() =='' || this.shippingName == null || this.shippingName.trim() ==''){//||this.shippingName == null || this.shippingName.trim() ==''
            IsError= true;
        }
        if(!IsError){
        shippingNewAddress ({street:this.strStreet,city:this.strCity,state:this.strState,postalcode:this.strPostalCode,country:this.strCountry,name:this.shippingName})
            .then(result => {
                this.Final_Result = result;
                if(result){
                    //this.dispatchEvent(
                      //  new ShowToastEvent({
                        //    title: 'Success!!',
                          //  message: 'You have change address Successfully!',
                            //variant: 'success'
                        //}),
                   // );
                   window.location.reload();
                }
            })
            .catch(error => {
                this.error = error;
                console.log(this.error);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error!!',
                        message: JSON.stringify(error),
                        variant: 'error'
                    }),
                );     
            });
        }
    }
   // get New_Address(){
        //return this.New_Address[this.New_Address]
    //}
    handelchange(event) {
        this.strCity = event.detail.city;
        this.strStreet = event.detail.street;
        this.strState = event.detail.province;
        this.strCountry = event.detail.country;
        this.strPostalCode = event.detail.postalCode;
      
    }

    //Implemented By Ritesh
    handleNameChange(event){
        this.shippingName = event.detail.value;
    }
    
}