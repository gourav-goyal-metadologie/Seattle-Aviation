import { LightningElement, track, api } from 'lwc';
import communityId from '@salesforce/community/Id';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
//import readCSV from '@salesforce/apex/MassUploadToCart.readCSVFile';
//import massProductUploadToCart from '@salesforce/apex/MassUploadToCart.massProductUploadToCart';
import massUploadToCart from '@salesforce/apex/MassUploadToCart.massUploadToCart';
import USER_ID from '@salesforce/user/Id'; //this is how you will retreive the USER ID of current in user.

export default class MassUploadToCart extends LightningElement {

    @api recordId;
    @track error;
    @track showMassUpload = true;
    @track showMassUploadcompo = false;
    @track showlink = true;
    //@track data;
    MAX_FILE_SIZE = 1500000;
    filesUploaded = [];
    fileName;
    fileReader;
    fileData;
    
    connectedCallback() {
        if(typeof USER_ID =="undefined"){
            console.log('USER_ID => ' + USER_ID);
            this.showMassUpload = false;
        }
    }

    ShowComponent(){
        this.showMassUploadcompo = true;
        this.showlink = false;
    }

    closeComponent(){
        this.showMassUploadcompo = false;
        this.showlink = true;
    }

    /*handleUploadFinished(event) {
        // Get the list of uploaded files
        console.log('Upload event ==> '+event);
        const uploadedFiles = event.detail.files;
        console.log('Upload File ==> '+uploadedFiles);
        
        // calling apex class
        console.log('reading Started ===> ');
        readCSV({idContentDocument : uploadedFiles[0].documentId})
        .then(result => {
            console.log('result ===> '+JSON.stringify(result));
            
            var acc = '0016s00000Dn3DtAAJ';
                
            massProductUploadToCart({
                accountId: acc,
                partNolist: result
            });
            
            if(result){
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success!!',
                        message: 'CSV file Uploaded successfully!!!',
                        variant: 'success',
                    }),
                );
            } else {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Warning!!',
                        message: 'Some unexpected error. Check CSV file data Format!!!',
                        variant: 'error',
                    }),
                );
            }
        })
        .catch(error => {
            this.error = error;
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error!!',
                    message: JSON.stringify(error),
                    variant: 'error',
                }),
            );     
        });      
        
    }*/


    handleUploadTOCart(event) {
        this.filesUploaded = event.target.files[0];
        this.fileName = event.target.files[0].name;
        var exe = this.fileName.split('.');
        var exe_list= ['xlsx', 'xls', 'csv'];
        
        if(exe_list.includes(exe[exe.length-1])){
            console.log('Upload File exe ==> '+exe);
            console.log('Upload File name ==> '+this.fileName);
            //console.log('File ==> '+JSON.stringify(this.filesUploaded));
            //console.log('communityId: '+communityId);
            //var acc = '0016s00000Dn3DtAAJ';

            if(this.filesUploaded.size > this.MAX_FILE_SIZE){
                window.console.log('File Size is to long');
            } else {
                this.fileReader = new FileReader();
                console.log('In fileReader ==> '+this.fileReader);
                this.fileReader.onload = (() => {
                    this.fileData = this.fileReader.result; 
                    this.AddToCart();             
                });            
                console.log('Out fileReader ==> '+this.fileReader);
                this.fileReader.readAsText(this.filesUploaded);
                //console.log('fileReader ==> '+JSON.stringify(this.fileData)); 
                //this.AddToCart(); 
                //readAsText(this.filesUploaded);
            }
        } else{
            this.dispatchEvent(
                new ShowToastEvent({
                    title: '',
                    message: 'Upload correct file or check your file format',
                    variant: 'error',
                }),
            );
        }
        //window.history.back();
    }

    AddToCart(){
        console.log('fileData ==> '+JSON.stringify(this.fileData));
        //var communityId = '0DB6s000000Gmmy';
        massUploadToCart({base64Data: JSON.stringify(this.fileData), NetworkId: communityId })
        .then(result => {
            console.log(result);
            if(result){
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success!!',
                        message: this.fileName + ' uploaded successfully!!!',
                        variant: 'success',
                    }),
                );
                
            } else {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: '',
                        message: 'Upload correct file or check your file format',
                        variant: 'error',
                    }),
                );
            }
            //window.location.reload();
            
        })
        .catch(error => {
            this.error = error;
            console.log(this.error);
            this.dispatchEvent(
                new ShowToastEvent({
                    title: '',
                    message: 'Upload correct file or check your file format',//JSON.stringify(error),
                    variant: 'error',
                }),
            );     
        }); 
        //this.connectedCallback();
       // window.location.reload();
    }
}