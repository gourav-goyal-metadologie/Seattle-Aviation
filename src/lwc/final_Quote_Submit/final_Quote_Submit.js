import { LightningElement, track } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import createQuoteAndLine from '@salesforce/apex/CustomerQuoteController.createQuoteAndLine';
//import ProductName from '@salesforce/apex/CustomerQuoteController.ProductName';

export default class Final_Quote_Submit extends LightningElement {

    @track showQuoteList = false;
    //@track Submit_Quote = false;    
    @track View_Quote = false;
    @track JsonConvertProduct =[];
    //@track removeitem;
    //@track modifiedProductList =[]; 
    @track Final_Result =[]; 
    @track qtyList =[];
    @track add_quote=false;
    @track showViewQuoteList=false;
    @track showViewRequestQuote=false;
    @track IsSpinnerOn=false;
    @track displayName = '';
    @track view_quote_name = 'VIEW REQUEST QUOTE';
    @track totalQty=0;


    connectedCallback(){
        var listOfQuoteProduct = window.sessionStorage.getItem('products');
        this.totalQty =0;
        this.displayName='';
        if(JSON.stringify(listOfQuoteProduct) == "null" || listOfQuoteProduct == "null"){
            this.View_Quote = true;
        }
        //var qtyrecords = sessionStorage.getItem('productQty');
        //var listofqtyrecords = JSON.parse(qtyrecords);
        //console.log('listOfQuoteProduct => '+listOfQuoteProduct);

        if(JSON.stringify(listOfQuoteProduct) != "null" && listOfQuoteProduct != "null"){
            var listofqtyrecords = JSON.parse(listOfQuoteProduct);
            var total_qty=0;
            this.totalQty =0;
            if(listofqtyrecords.length>0){
                listofqtyrecords.forEach(prodrow =>{
                    total_qty = parseInt(total_qty) + parseInt(prodrow.qty)
                    //console.log('prodrow.qty => '+prodrow.qty);
                });
                this.displayName = this.view_quote_name+' ('+listofqtyrecords.length+')';
                //this.displayName = this.view_quote_name+' ('+total_qty+')';
                this.totalQty = total_qty;
                this.showViewRequestQuote = true;
            }
        } else {
            this.displayName = this.view_quote_name+' (0)';
        }
        //console.log('displayName => '+this.displayName);
    }

    // Quote line Product section show.
    viewQuote() {
        this.showQuoteList = true;
        var listOfQuoteProduct = window.sessionStorage.getItem('products');
        this.JsonConvertProduct = JSON.parse(listOfQuoteProduct);
        var Prodkey = [];
        this.JsonConvertProduct.forEach(prodrow =>{
            Prodkey.push(
                prodrow.key
            );
            this.qtyList.push({
                pid:prodrow.key,
                qty:1
            });
        });
        
        //var resetList = sessionStorage.setItem('products' , "null");
        //console.log('Get session Ids cart: ' + listOfQuoteProduct);
        //console.log('Json session Ids cart: ' + JSON.stringify(JSON.parse(listOfQuoteProduct)));
        //if(listOfQuoteProduct != "null") {
            this.Submit_Quote = true;
        //}
    }

    closeViewList() {
        this.showQuoteList = false;
    }

    deleteFromViewList(event){
        //this.removeitem = event.target.value;
        var pid = event.target.value;
        var cid = event.target.dataset.id;
        //console.log('Deleted product Id: ' + pid);
        //console.log('Deleted code Id: ' + cid);
        //console.log('type of Id: ' + typeof this.JsonConvertProduct);

        // Remove deleted partnumber from list.
        //this.JsonConvertProduct.splice(this.removeitem,1);  
        var qtytemplist = [];    
        var qtychangelist = [];    

        this.JsonConvertProduct.forEach(prodrow => {
            if(prodrow.key === pid && prodrow.code_id === cid){
                qtytemplist.push(prodrow);
            } else {
                qtychangelist.push(prodrow);
            }
        });    
        this.JsonConvertProduct =  qtychangelist;

        //this.JsonConvertProduct = this.JsonConvertProduct.filter(arr => arr.key !== this.removeitem);
        //this.qtyList = this.qtyList.filter(arr => arr.pid !== this.removeitem);

        if(this.JsonConvertProduct.length>0){
            sessionStorage.setItem('products' , JSON.stringify(this.JsonConvertProduct));
        } else {
            sessionStorage.setItem('products' , "null");
            //eval("$A.get('e.force:refreshView').fire();");
            this.View_Quote = true;
            this.showQuoteList = false;
            this.showViewRequestQuote = false;
        }

        //console.log('Deleted Ids: ' + JSON.stringify(this.JsonConvertProduct));
        //console.log('qtyList: ' + JSON.stringify(this.qtyList));

        this.connectedCallback();
    }

    handleQuantityChange(event){
        var qty = event.target.value;
        var cid = event.target.dataset.id;
        var pid = event.target.name;
        var qtytemplist = [];    
        var qtychangelist = [];    

        /*this.JsonConvertProduct.forEach(prodrow => {
            if(prodrow.key === pid && prodrow.code_id === cid){
                qtytemplist.push(prodrow);
            } else {
                qtychangelist.push(prodrow);
            }
        });
        
        qtytemplist[0].qty = qty;
        qtychangelist.push(qtytemplist[0]);
        this.JsonConvertProduct = qtychangelist;
        console.log('qtytemplist array => '+ JSON.stringify(qtytemplist));
        console.log('qtychangelist array => '+ JSON.stringify(qtychangelist));*/

        /*qtytemplist = this.JsonConvertProduct.filter(arr => arr.key === pid);
        qtytemplist[0].qty = qty;
        this.JsonConvertProduct = this.JsonConvertProduct.filter(arr => arr.key !== pid);
        this.JsonConvertProduct.push(qtytemplist[0]);*/

        if(qty!=''){
            this.JsonConvertProduct.forEach(prodrow => {               
                if(prodrow.key === pid && prodrow.code_id === cid){
                    qtytemplist.push(prodrow);
                    prodrow.qty=qty;
                }
                qtychangelist.push(prodrow);
            });
        } else {
            this.JsonConvertProduct.forEach(prodrow => {               
                qtychangelist.push(prodrow);
            });
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'error!!',
                    message: 'Quantity shoud not blank',
                    variant: 'error',
                })
            );
        }
        this.JsonConvertProduct=qtychangelist;
        
        if(this.JsonConvertProduct.length>0){
            sessionStorage.setItem('products' , JSON.stringify(this.JsonConvertProduct));
        } else {
            sessionStorage.setItem('products' , "null");
            this.View_Quote = true;
            this.showQuoteList = false;
        }

        /*this.qtyList = this.qtyList.filter(arr => arr.pid !== pid);
        this.qtyList.push({pid:pid,qty:qty});*/

        console.log('Quantity: ' + qty);
        console.log('ConditionCodekey: ' + cid);
        console.log('Prodkey: ' + pid);
        console.log('Prod QTY LIST: ' + JSON.stringify(this.qtyList));
        this.connectedCallback();
    }

    handleQuantityValidation(event){
        
        //var regex = /\D/g;//new RegExp("^[0-9]+$");
        var enter_text = event.target.value; 
        var cid = event.target.dataset.id;
        var pid = event.target.name;    

        if(enter_text.includes('.')){
            //console.log('enter_text'+enter_text);
            enter_text = enter_text.replace(/\./g,'');
            //console.log('enter_text'+enter_text);
        }      

        if(enter_text>9999){
            enter_text = enter_text.slice(0,4);
            console.log('qty=> '+enter_text);
        }
        //console.log('qty=> '+enter_text);

        if(enter_text.trim()=='' || enter_text<1 ){
            var return_var;
            this.JsonConvertProduct.forEach(prodrow => {
                if(prodrow.key === pid && prodrow.code_id === cid){
                    return_var = prodrow.qty;
                } 
            });
            //console.log('qty inside array '+JSON.stringify(this.JsonConvertProduct));
                        
        } else {
            return_var = enter_text;
        }
        this.template.querySelector('[data-id=\'' + cid + '\']').value = return_var;
    }

    saveViewList() {
        this.showQuoteList = false;
        this.submitquote();
    }

    submitquote() {   

        var resetList = sessionStorage.setItem('products' , "null");
        var Prodkey = [];
        this.IsSpinnerOn=true;
        this.JsonConvertProduct.forEach(prodrow =>{
            Prodkey.push(
                prodrow.key
            );
        });
        console.log('Prodkey : ' + Prodkey);

        var sendToSaveStringify = JSON.stringify(Prodkey);
        console.log('sendToSaveStringify : ' + sendToSaveStringify);

        if(sendToSaveStringify != "null") {
            //createQuoteAndLine({productIdList: Prodkey,productQtyList: this.qtyList})
            createQuoteAndLine({productList: this.JsonConvertProduct})
            .then(result => {
                console.log(result);
                this.Final_Result = result;
                if(result){
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success!!',
                            message: 'You have submitted the quotation Successfully!',
                            variant: 'success',
                        }),
                    );
                    this.View_Quote = true;
                    this.showQuoteList = false;
                    this.IsSpinnerOn=false;
                    this.showViewRequestQuote = false;
                    this.connectedCallback();
                    //eval("$A.get('e.force:refreshView').fire();");
                }
            })
            .catch(error => {
                this.error = error;
                console.log(this.error);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error!!',
                        message: JSON.stringify(error),
                        variant: 'error',
                    }),
                );   
                this.View_Quote = true;
                this.showQuoteList = false;
                this.connectedCallback();  
            }); 
            //window.location.reload();     
            //this.connectedCallback();
        }
    }
}