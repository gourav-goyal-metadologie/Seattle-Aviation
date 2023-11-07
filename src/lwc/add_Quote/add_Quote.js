import { LightningElement, track, api } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import createQuoteAndLine from '@salesforce/apex/CustomerQuoteController.createQuoteAndLine';
import ProductName from '@salesforce/apex/CustomerQuoteController.ProductName';
import USER_ID from '@salesforce/user/Id'; //this is how you will retreive the USER ID of current in user.
import { NavigationMixin } from 'lightning/navigation';
import ExternalId from '@salesforce/schema/Product2.ExternalId';

export default class Add_Quote extends NavigationMixin(LightningElement) {

    @track added_product;
    @track part_number;
    @track getsession = [];
    @track JsonConvertProduct =[];
    @track ObjectProductName =[];
    @track removeitem;  
    @track Final_Result =[]; 
    @track qtyList =[];
    @track JsonqtyList =[];
    @track add_quote=false;
    @track showViewQuoteList=false;
    @track showQuoteList=false;
    @track showRemoveButton=false;
    @track showaddButton=true;
    @track IsSpinnerOn=false;
    @api conditionCodeLabelQuote;
    @api conditionCodeIdQuote;
    

    connectedCallback(){
        //console.log('In connectedCallback() => ');
        //console.log('USER_ID => ' + USER_ID);
        var checkproduct = window.sessionStorage.getItem('products');  
        
        var checkproductexist = [];        
        
        var full_url = document.URL;
        var url_array = full_url.split('/');
        var array_size = url_array.length;
        var split_str = url_array[array_size - 1];
        if(split_str.includes('?t')){
        var splitstr = split_str.split('?t');
        var prodname = splitstr[0];
        } else {
            var prodname = split_str;
        }
        //this.conditionCodeLabelQuote = 'NE';
        //this.conditionCodeIdQuote= 'a095Y00001ARMPLQA5';
        //console.log('checkproduct => '+ checkproduct);

        if(JSON.stringify(checkproduct) != "null" && checkproduct != "null"){
            //console.log('checkproduct If loop => ');
            var jsoncheckproduct = JSON.parse(checkproduct);
            checkproductexist = jsoncheckproduct.filter(arr => arr.key === prodname);
            checkproductexist = checkproductexist.filter(arr => arr.code === this.conditionCodeLabelQuote);

            //console.log('jsoncheckproduct => '+ JSON.stringify(jsoncheckproduct));
            //console.log('this.added_product => '+ prodname);        
            //console.log('checkproductexist => '+ JSON.stringify(checkproductexist));
            
        }        
        //console.log('this.conditionCodeLabelQuote => '+ this.conditionCodeLabelQuote);
        //console.log('this.conditionCodeIdQuote => '+ this.conditionCodeIdQuote);
        
        if(typeof this.conditionCodeLabelQuote =="undefined"){
            this.add_quote = true;
            this.showaddButton = true;
        } else { 
            //console.log('checking this.conditionCodeLabelQuote => ');
            if(this.conditionCodeLabelQuote === null)  {
                this.add_quote = true;
                this.showaddButton = true;
            } else{
                if(checkproductexist.length>0){
                    this.add_quote = true;
                    this.showRemoveButton = true;
                    this.showaddButton = false;
                } else {
                    this.add_quote = false;
                    this.showRemoveButton = false;
                    this.showaddButton = true;
                }
            }
        } 
           
        
    }

    @api
    callConnCallback(code,code_id) {
        this.conditionCodeLabelQuote = code;
        this.conditionCodeIdQuote = code_id;
        console.log('code => '+code);
        console.log('code_id => '+code_id);
        this.connectedCallback();
    } 

    // Add to Quote...
    Addquote() {
        console.log('USER_ID => ' + USER_ID);
        console.log('typeof USER_ID => ' + typeof USER_ID);
        if(typeof USER_ID =="undefined"){
            //console.log('USER_ID => ' + USER_ID);
            this[NavigationMixin.Navigate]({
                type: 'comm__loginPage',
                attributes: {
                    actionName: 'login'
                }           
            });
            
        } else {
            // for getting data from url
            var full_url = document.URL;
            var url_array = full_url.split('/');
            var array_size = url_array.length;  
            //this.added_product = url_array[array_size - 1];
            this.part_number = url_array[array_size - 2];
            var split_str = url_array[array_size - 1];
            if(split_str.includes('?t')){
                var splitstr = split_str.split('?t');
                this.added_product = splitstr[0];
            } else {
                this.added_product = split_str;
            }
            //console.log('this.conditionCodeLabelQuote => '+ this.conditionCodeLabelQuote);
            //console.log('this.conditionCodeIdQuote => '+ this.conditionCodeIdQuote);

            /*if(this.added_product) {
                ProductName({productId: this.added_product})
                .then(result => {            
                    this.part_number = result;   
                    //console.log(result);         
                });
            }*/

            //console.log('full Url - ' + full_url);
            //console.log('split data - ' + url_array[array_size - 1]);
            //console.log('Session : ' + sessionStorage.getItem('products'));
            //console.log('part number ID - ' + this.part_number);

            // for session storage
            var records = sessionStorage.getItem('products');
            var qtyrecords = sessionStorage.getItem('productQty');
            //console.log('Type Of records - ' + typeof records);
            if(JSON.stringify(records) == "null" || records == "null"){
                //console.log('If Condition : ');
                this.getsession = [];
                this.ObjectProductName = [];
                this.qtyList = [];
                ProductName({productId: this.added_product})
                .then(result => {       
                    this.ObjectProductName.push({value:result, key:this.added_product, qty:1, code:this.conditionCodeLabelQuote, code_id:this.conditionCodeIdQuote});   
                    //this.part_number = result;   
                    this.JsonConvertProduct =  this.ObjectProductName;
                    sessionStorage.setItem('products' , JSON.stringify(this.ObjectProductName));
                    //console.log(result);         
                });
                this.getsession.push({value:this.part_number, key:this.added_product, qty:1}); //this.mapData.push({value:conts[key], key:key}); 
                this.qtyList.push({pid:this.added_product,qty:1});
                sessionStorage.setItem('products' , JSON.stringify(this.getsession));            
                sessionStorage.setItem('productQty' , JSON.stringify(this.qtyList));
                //sessionStorage.setItem('products' , this.added_product);

            } else {
                //console.log('Else Condition : '); 
                        
                this.getsession = JSON.parse(records);
                this.ObjectProductName = JSON.parse(records);
                this.qtyList = JSON.parse(qtyrecords);
                //this.getsession.push(this.added_product);            
                this.getsession.push({value:this.part_number, key:this.added_product, qty:1});
                this.qtyList.push({pid:this.added_product,qty:1});
                ProductName({productId: this.added_product})
                .then(result => {       
                    this.ObjectProductName.push({value:result, key:this.added_product, qty:1, code:this.conditionCodeLabelQuote, code_id:this.conditionCodeIdQuote});   
                    //this.part_number = result; 
                    this.JsonConvertProduct =  this.ObjectProductName;
                    sessionStorage.setItem('products' , JSON.stringify(this.ObjectProductName));
                    //console.log(result);         
                });
                sessionStorage.setItem('products' , JSON.stringify(this.getsession));
                sessionStorage.setItem('productQty' , JSON.stringify(this.qtyList));

                //sessionStorage.setItem('products' , null);
            } 
                    
            //console.log('Session : ' + sessionStorage.getItem('products'));
            //console.log('Session Qty : ' + sessionStorage.getItem('productQty'));
            //console.log('push session Ids: ' + this.getsession);
            //console.log('Session: ' + records);

            // for enabling and disabling the add quote button
            if(this.added_product){
                this.add_quote=true;
                this.showViewQuoteList = true;
                this.showRemoveButton = true;
                this.showaddButton = false;
            }     

            /*const evt = new ShowToastEvent({
                title: 'Toast Success',
                message: 'Item is successfully added to Request quote with Part Number - ' + this.part_number,
                variant: 'success',
                mode: 'dismissable'
            });
            this.dispatchEvent(evt);*/
        }
    }

    closeViewQuoteList(){
        this.showQuoteList = false;
        this.showViewQuoteList = false;
    }

    viewQuote() {
        this.showQuoteList = true;
        this.showViewQuoteList = false;
        if(this.ObjectProductName.length>0){
            sessionStorage.setItem('products' , JSON.stringify(this.ObjectProductName));
        }
        //console.log('JSON.stringify(this.ObjectProductName) '+JSON.stringify(this.ObjectProductName));
        var listOfQuoteProduct = window.sessionStorage.getItem('products');
        this.JsonConvertProduct = JSON.parse(listOfQuoteProduct);
        var listOfQuoteProductqty = window.sessionStorage.getItem('productQty');
        this.qtyList = JSON.parse(listOfQuoteProductqty);
        //var listOfProductQty = window.sessionStorage.getItem('productQty');
        //this.JsonqtyList = JSON.parse(listOfProductQty);        
        var Prodkey = [];

        this.JsonConvertProduct.forEach(prodrow =>{
            Prodkey.push(
                prodrow.key
            );
            //this.qtyList.push({
            //    pid:prodrow.key,
            //    qty:1
            //});
        });

        //var resetList = sessionStorage.setItem('products' , "null");
        //console.log('Get session Ids cart: ' + listOfQuoteProduct);
        //console.log('Json session Ids cart: ' + JSON.stringify(JSON.parse(this.JsonConvertProduct)));
        //if(listOfQuoteProduct != "null") {
            this.Submit_Quote = true;
        //}
    }

    closeViewList() {
        this.showQuoteList = false;
        this.showViewQuoteList = false;
    }

    deleteFromViewList(event){
        this.removeitem = null;
        var pid = event.target.value;
        var cid = event.target.dataset.id;
        var qtytemplist = [];    
        var qtychangelist = [];  
        //console.log('Deleted product Id: ' + pid);
        //console.log('Deleted code Id: ' + cid);

        //console.log('Deleted Id: ' + this.removeitem);
        //console.log('type of Id: ' + typeof this.JsonConvertProduct);

        if(pid === ""){
            //console.log('if product Id blank ');
            var full_url = document.URL;
            var url_array = full_url.split('/');
            var array_size = url_array.length;
            var split_str = url_array[array_size - 1];
            if(split_str.includes('?t')){
                var splitstr = split_str.split('?t');
                this.removeitem = splitstr[0];
            } else {
                this.removeitem = split_str;
            }            
            
            this.JsonConvertProduct.forEach(prodrow => {
                if(prodrow.key === this.removeitem && prodrow.code_id == this.conditionCodeIdQuote){
                    qtytemplist.push(prodrow);
                } else {
                    qtychangelist.push(prodrow);
                }
            });
            //this.conditionCodeIdQuote =null;
            //this.conditionCodeLabelQuote =null;

        } else { 

            this.JsonConvertProduct.forEach(prodrow => {
                if(prodrow.key === pid && prodrow.code_id === cid){
                    qtytemplist.push(prodrow);
                } else {
                    qtychangelist.push(prodrow);
                }
            }); 
        }

        this.JsonConvertProduct =  qtychangelist;
        // Remove deleted partnumber from list.
        //this.JsonConvertProduct.splice(this.removeitem,1);        
        //this.JsonConvertProduct = this.JsonConvertProduct.filter(arr => arr.key !== this.removeitem);
        //checkproductexist = this.JsonConvertProduct.filter(arr => arr.key === this.removeitem);
        //this.qtyList = this.qtyList.filter(arr => arr.pid !== this.removeitem);
        if(this.JsonConvertProduct.length>0){
            sessionStorage.setItem('products' , JSON.stringify(this.JsonConvertProduct));
            sessionStorage.setItem('productQty' , JSON.stringify(this.qtyList));
        } else {
            sessionStorage.setItem('products' , "null");            
            sessionStorage.setItem('productQty' , "null");
            //this.conditionCodeIdQuote = null;
            //this.conditionCodeLabelQuote = null;
            this.showQuoteList = false;
            this.showViewQuoteList = false;

        }
        if(this.removeitem != null || this.JsonConvertProduct.length==0){
            this.add_quote = true;
            this.showaddButton = true;
            this.showRemoveButton = false;
            this.removeitem = null;
        }

        //console.log('Deleted Ids: ' + JSON.stringify(this.JsonConvertProduct));
        //console.log('session data Ids: ' + window.sessionStorage.getItem('products'));
        //console.log('qtyList: ' + JSON.stringify(this.qtyList));
        //console.log('removeitem: ' + this.removeitem);
        this.connectedCallback();
    }

    handleQuantityChange(event){
        var qty = event.target.value;
        var cid = event.target.dataset.id;
        var pid = event.target.name;
        var qtytemplist = [];    
        var qtychangelist = [];    
        
        //console.log('qty1 '+qty);
        

        /*this.JsonConvertProduct.forEach(prodrow => {
            if(prodrow.key === pid && prodrow.code_id === cid){
                qtytemplist.push(prodrow);
            } else {
                qtychangelist.push(prodrow);
            }
        });
        
        qtytemplist[0].qty = qty;
        qtychangelist.push(qtytemplist[0]);
        this.JsonConvertProduct = [];
        this.JsonConvertProduct = qtychangelist;*/

        if(qty!=''){
            
            this.JsonConvertProduct.forEach(prodrow => {
                
                if(prodrow.key === pid && prodrow.code_id === cid){
                    qtytemplist.push(prodrow);
                    prodrow.qty=qty;
                } //else {
                    //qtychangelist.push(prodrow);
                //}
                qtychangelist.push(prodrow);
            });
        } else {
            this.JsonConvertProduct.forEach(prodrow => {               
                qtychangelist.push(prodrow);
            });
            //console.log('qtychangelist=> '+JSON.stringify(qtychangelist));
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'error!!',
                    message: 'Quantity shoud not blank',
                    variant: 'error',
                })
            );
        }
        
        //this.JsonConvertProduct.clear();
        this.JsonConvertProduct = qtychangelist;
        //this.JsonConvertProduct.sort();
        //console.log('qtytemplist array => '+ JSON.stringify(qtytemplist));
        //console.log('qtychangelist array => '+ JSON.stringify(qtychangelist));
        //console.log('JsonConvertProduct array => '+ JSON.stringify(this.JsonConvertProduct));
        /*qtytemplist = this.JsonConvertProduct.filter(arr => arr.key === pid);
        qtytemplist[0].qty = qty;
        this.JsonConvertProduct = this.JsonConvertProduct.filter(arr => arr.key !== pid);
        this.JsonConvertProduct.push(qtytemplist[0]);

        this.qtyList = this.qtyList.filter(arr => arr.pid !== pid);
        this.qtyList.push({pid:pid,qty:qty});*/
        
        if(this.JsonConvertProduct.length>0){
            sessionStorage.setItem('products' , JSON.stringify(this.JsonConvertProduct));
            sessionStorage.setItem('productQty' , JSON.stringify(this.qtyList));
        } else {
            sessionStorage.setItem('products' , "null");
            sessionStorage.setItem('productQty' , "null");
        }        
        //console.log('session Data: ' + sessionStorage.getItem('products'));
        //console.log('Quantity: ' + qty);
        //console.log('condtionCodekey: ' + cid);
        //console.log('Prodkey: ' + pid);
        //console.log('Prod QTY LIST: ' + JSON.stringify(this.qtyList));
        //console.log('QTY LIST: ' + JSON.stringify(qtytemplist[0]));
        //console.log('Actual Prod QTY LIST: ' + JSON.stringify(this.JsonConvertProduct.sort()));
    }

    handleQuantityValidation(event){
        
        var regex = /\D/g;//new RegExp("^[0-9]+$");
        var enter_text = event.target.value;
        var cid = event.target.dataset.id;
        var pid = event.target.name;  
        
        var qtychangelist = [];  
        //var enter_text = event.key;//String.fromCharCode(!event.charCode ? event.which : event.charCode);
        //enter_text.replace(/[^0-9]/, '');
        //enter_text.replace(/\./g,'');
        //enter_text.match(/\./g).join('');
        //console.log('qty=> '+enter_text);
        //if (!regex.test(enter_text)) {
            if(enter_text.includes('.')){
                console.log('enter_text'+enter_text);
                enter_text = enter_text.replace(/\./g,'');
                console.log('enter_text'+enter_text);
            }
            
            if(enter_text>9999){
                enter_text = enter_text.slice(0,4);
                console.log('qty=> '+enter_text);
            }
            //console.log('prodrow.key '+prodrow.key);
                //console.log('pid '+pid);
                //console.log('prodrow.code_id '+prodrow.code_id);
                //console.log('cid '+cid);
        
        if(enter_text.trim()=='' || enter_text<1){
            var return_var;
            //var return_var = enter_text.match(/\d/g);
            //return_var = return_var.join("");
            //console.log('qty inside '+return_var);
            this.JsonConvertProduct.forEach(prodrow => {
                if(prodrow.key === pid && prodrow.code_id === cid){
                    //qtytemplist.push(prodrow);
                    return_var = prodrow.qty;
                } 
                qtychangelist.push(prodrow);
            });
            this.JsonConvertProduct = qtychangelist;
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
        sessionStorage.setItem('products' , "null");
        sessionStorage.setItem('productQty' , "null");
        this.IsSpinnerOn=true;
        var Prodkey = [];
        this.JsonConvertProduct.forEach(prodrow =>{
            Prodkey.push(
                prodrow.key
            );
        });
        //console.log('sendToSaveStringify : ' + Prodkey);

        var sendToSaveStringify = JSON.stringify(Prodkey);
        //console.log('sendToSaveStringify : ' + sendToSaveStringify);

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
                    this.add_quote = false;
                    this.showRemoveButton = false;
                    this.showaddButton = true;
                    this.IsSpinnerOn=false;
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
                this.add_quote = false;
                this.showRemoveButton = false;
                this.showaddButton = true;     
            });    
        }
    }
}