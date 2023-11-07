import { LightningElement,track,api } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import Internalcomments from '@salesforce/apex/InterncalcommentController.Internalcomments';
import InternalCommentscartitemstatus from '@salesforce/apex/InterncalcommentController.internalcartitems';
//import checkProductAddedIntoCartOrNot from '@salesforce/apex/B2BGetInfo.checkProductAddedIntoCartOrNot';
export default class InternalComments extends LightningElement {

    @api Internalcomments='';
    @api Linelevelcomments='';
    @track Final_Result;
    @track recordId;
    @track url;
    @track WebCartId;
    @track cartId;
    @track disabled=true;
    @track hideinternalcomment=true;
    @track cartitems;
    @track Final_Result2;

        // checking cartitems availability
        // checkinternalcartitemsavailability (){

        // }

        handleChangecomments(event){
            this.Internalcomments = event.detail.value;
            console.log('Internal comments : ', this.Internalcomments);
            console.log('Cart status : ', this.recordId);
            if(this.InternalComments != ''){
                this.disabled=false;
            }

            // if (this.Internalcomments.length === 0 && event.which === 32) event.preventDefault();
              
            //  $(function() {
            //     $('body').on('keydown', '#firstspacenotallowed', function(event) {
            //       console.log(this.value);
            //        if (event.which === 32 &&  event.target.selectionStart === 0) {
            //          return event.preventDefault();
            //        }  
            //      });
            //    });

            // $(document).ready(function(){
            //     $("#letterandspaces").keydown(function(event){
            //         var inputValue = event.which;
            //         // allow letters and whitespaces only.
            //         if(!(inputValue >= 65 && inputValue <= 120) && (inputValue != 32 && inputValue != 0)) { 
            //             event.preventDefault(); 
            //         }
            //     });
            // });

            //   //dont allow blankspace
            //   var code = (event.which) ? event.which : event.keyCode;
            //   if (code === 32 &&  code.selectionStart === 0) {
            //     event.preventDefault();
            //   }  
        }

            
        handleChange(event){
            this.Linelevelcomments = event.detail.value;
            console.log('Line level comments :', this.Linelevelcomments);
            if(this.Linelevelcomments != ''){
                this.disabled=false;
            }

            // $("#QBQuestion").keypress(function (evt) {
            //     var kc = evt.data.keyCode;
            //     var qbQuestion = $('#QBQuestion').summernote('code');
            //     if (kc === 32 && qbQuestion.length === 0) {
            //             event.preventDefault();
            //        }
            // });

        }

        notallowNumbersOnly(e) {
            var code = (e.which) ? e.which : e.keyCode;
            if (!(code > 31 &&  (code < 48 || code > 57))) {
                e.preventDefault();
            }
        }

        // Using connectedCallback href 
        connectedCallback(){
        // this.url = window.location.href;
        // this.url = this.url .split( '/' );
        // console.log('url after split : ', this.url);
        // this.url = this.url[ this.url.length - 1 ] ;
        var full_url = window.location.href;
        //var full_url = document.URL;
        var url_array = full_url.split('/');
        var array_size = url_array.length;
        var split_str = url_array[array_size - 1];
        if(split_str.includes('?')){
            var splitstr = split_str.split('?');
            this.cartId = splitstr[0];
        } else {
            this.cartId = split_str;
        }
        this.url = this.cartId;
        this.WebCartId = this.url;
        console.log('url final cartId: ', this.WebCartId);

        // checking internal cartitems
        // InternalCommentscartitemstatus({cartId: this.WebCartId});
        // this.cartitems  
        InternalCommentscartitemstatus({cartId: this.WebCartId})
        // console.log('Cart availability check :  ' , this.cartitems);
        .then(result => {
            console.log('Cart availability check2 :  ' , result);
            if(result > 0){
                this.hideinternalcomment=false;
            } else { 
                // eval("$A.get('e.force:refreshView').fire();");
                //this.template.querySelector('c-internal-comments').connectedCallback();
  
            }

        });

        
    }


       save_comment(){
        var IsError= false;
        if (this.Internalcomments == '' || this.Internalcomments.trim() =='') {
            if(this.Linelevelcomments == '' || this.Linelevelcomments.trim() == '' ){
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error!!',
                    message: 'Sorry invalid data !',
                    variant: 'success',
                }),
            );
            IsError= true;
            eval("$A.get('e.force:refreshView').fire();");
            } else if (this.Internalcomments == '' || this.Internalcomments.trim() ==''){
                IsError=false;
                this.Internalcomments = 'blankspace';
            }else{

                IsError= false;
            }
        } else if (this.Linelevelcomments == '' || this.Linelevelcomments.trim() == '' ){
            if(this.Internalcomments == '' || this.Internalcomments.trim() ==''){
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error!!',
                        message: 'Sorry invalid data!',
                        variant: 'success',
                    }),
                );
                IsError= true;
                eval("$A.get('e.force:refreshView').fire();");
                } else if (this.Linelevelcomments == '' || this.Linelevelcomments.trim() ==''){
                    IsError=false;
                    this.Linelevelcomments = 'blankspace';
                }else{
                    IsError= false;
                }
        }
            console.log(typeof this.Internalcomments);
            console.log('comment passes : ', this.Internalcomments);
            console.log('commnet passes order level: ', this.Linelevelcomments);
            if(!IsError){
                Internalcomments({cartId:this.WebCartId, comment:this.Internalcomments, commentlinelevel:this.Linelevelcomments})
                .then(result => {
                    this.Final_Result = result;
                    console.log('Result : ' , JSON.stringify(this.Final_Result));
                    if(result){
                        // window.setInterval('refresh()', 10000); 	
                        // refresh();
                        // window.location.reload();
                        // setTimeout(location.reload.bind(location), 60000);
                        setTimeout(function(){
                            window.location.reload(1);
                         }, 5000);
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Success!!',
                                message: 'You have Inserted the comment Successfully!',
                                variant: 'success',
                            }),
                        );
                    }
                })
                .catch(error => {
                    this.error = error;
                    console.log(this.error);
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error!! Contact Administartor',
                            message: JSON.stringify(error),
                            variant: 'error'
                        }),
                    );     
                });


            }

        }

}