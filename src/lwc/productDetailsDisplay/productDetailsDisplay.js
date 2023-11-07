import { LightningElement, api,track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { refreshApex } from '@salesforce/apex';

//import getPriceBasedOnConditionCode from '@salesforce/apex/B2BGetInfo.getPriceBasedOnConditionCode';
import checkProductAddedIntoCartOrNot from '@salesforce/apex/B2BGetInfo.checkProductAddedIntoCartOrNot';


// A fixed entry for the home page.
const homePage = {
    name: 'Home',
    type: 'standard__namedPage',
    attributes: {
        pageName: 'home'
    }
};

/**
 * An organized display of product information.
 *
 * @fires ProductDetailsDisplay#addtocart
 * @fires ProductDetailsDisplay#createandaddtolist
 */
export default class ProductDetailsDisplay extends NavigationMixin(
    LightningElement
) {
    /**
     * An event fired when the user indicates the product should be added to their cart.
     *
     * Properties:
     *   - Bubbles: false
     *   - Composed: false
     *   - Cancelable: false
     *
     * @event ProductDetailsDisplay#addtocart
     * @type {CustomEvent}
     *
     * @property {string} detail.quantity
     *  The number of items to add to cart.
     *
     * @export
     */

    /**
     * An event fired when the user indicates the product should be added to a new wishlist
     *
     * Properties:
     *   - Bubbles: false
     *   - Composed: false
     *   - Cancelable: false
     *
     * @event ProductDetailsDisplay#createandaddtolist
     * @type {CustomEvent}
     *
     * @export
     */

    /**
     * A product image.
     * @typedef {object} Image
     *
     * @property {string} url
     *  The URL of an image.
     *
     * @property {string} alternativeText
     *  The alternative display text of the image.
     */

    /**
     * A product category.
     * @typedef {object} Category
     *
     * @property {string} id
     *  The unique identifier of a category.
     *
     * @property {string} name
     *  The localized display name of a category.
     */

    /**
     * A product price.
     * @typedef {object} Price
     *
     * @property {string} negotiated
     *  The negotiated price of a product.
     *
     * @property {string} currency
     *  The ISO 4217 currency code of the price.
     */

    /**
     * A product field.
     * @typedef {object} CustomField
     *
     * @property {string} name
     *  The name of the custom field.
     *
     * @property {string} value
     *  The value of the custom field.
     */

    /**
     * An iterable Field for display.
     * @typedef {CustomField} IterableField
     *
     * @property {number} id
     *  A unique identifier for the field.
     */

    /**
     * Gets or sets which custom fields should be displayed (if supplied).
     *
     * @type {CustomField[]}
     */
    @api
    customFields;

    /**
     * Gets or sets whether the cart is locked
     *
     * @type {boolean}
     */
    @api
    cartLocked;

    /**
     * Gets or sets the name of the product.
     *
     * @type {string}
     */
    @api
    description;

    /**
     * Gets or sets the product image.
     *
     * @type {Image}
     */
    @api
    image;

    /**
     * Gets or sets whether the product is "in stock."
     *
     * @type {boolean}
     */
    @api
    inStock = false;

    /**
     * Gets or sets the name of the product.
     *
     * @type {string}
     */
    @api
    name;

    /**
     * Gets or sets the price - if known - of the product.
     * If this property is specified as undefined, the price is shown as being unavailable.
     *
     * @type {Price}
     */
    @api
    price;

    /**
     * Gets or sets teh stock keeping unit (or SKU) of the product.
     *
     * @type {string}
     */
    @api
    sku;

    

    /**
     * Gets or sets expiration date of the product.
     */
    @api expirationdate;
    @api conditions;
    @api hazmat;
    @api keywords;
    @api corev;
    @api productRecordId;
    @api productQtyMap;
    @track showCartButton=true;
    @track conditionCodePrice;
    @track conditionCodePriceId;
    @track conditionCodeKey;
    @track conditionCodelabel;
    @track conditionCodeHasPrice=false;
    @track isConditionCodeSelected=false;
    @api uom;
    @track productAvailableQty;
    @api cartId;
    @track productAlreadyAddedIntoCart=false;
    @api conditionCodeAlreadyAdded;
    @track resultInstock;
    @track conditionCodeLabelQuote;
    @track conditionCodeIdQuote;
    @track priceType;
    @track hasPriceType=false;
    @api effectiveAccountId;
    @track IsAddToCartPopUp=false;

    @track isexpirationdatecheck;
    @track monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    
    /* check expiration date */
    get expirationdatecheck(){
        console.log('Expiration Date: ',this.expirationdate);
        if (this.expirationdate == undefined || this.expirationdate == '' || this.expirationdate == 'N/A') {
            this.expirationdate = "N/A";
            this.isexpirationdatecheck=false;
        }else{
            this.expirationdate = this.convertdateFormat();
            this.isexpirationdatecheck = true;
        }
    }

    convertdateFormat(){
        var d = new Date(this.expirationdate),
                month = '' + (d.getMonth()),
                day = '' + d.getDate(),
                year = '' + d.getFullYear();
        if (day.length < 2) 
            day = '0' + day;
        return [this.monthNames[month]+' '+day+', '+year];
    }

   /* Change Price per condition code.*/ 
    handleConditionCodeChange(event) {
        if (event.target.validity.valid && event.target.value) {
            this.isConditionCodeSelected=true;
            this.conditionCodeKey= event.target.value;
            this.conditionCodelabel = event.target.options.find(opt => opt.value === event.detail.value).label;
            this.conditionCodeLabelQuote =event.target.options.find(opt => opt.value === event.detail.value).label;
            this.conditionCodeIdQuote=event.target.value;

            for(var key in this.productQtyMap){

                if(key===this.conditionCodelabel){

                    if(this.productQtyMap[key].quantity>0 && this.productQtyMap[key].price>0 && this.productQtyMap[key].price!=undefined){
                        this.productAvailableQty=this.productQtyMap[key].availableQty;
                        this.conditionCodePrice=this.productQtyMap[key].price;
                        this.showCartButton=false;
                        this.conditionCodeHasPrice=true;
                        this.conditionCodePriceId=this.productQtyMap[key].conditionCodeId;
                        this.priceType=this.productQtyMap[key].priceType;
                    }else if(this.productQtyMap[key].quantity>0 && this.productQtyMap[key].price==0){
                        this.showCartButton=true;
                        this.conditionCodeHasPrice=false;
                        this.conditionCodePriceId=this.productQtyMap[key].conditionCodeId;
                        this.priceType=this.productQtyMap[key].priceType;
                    }else if((this.productQtyMap[key].quantity<0 || this.productQtyMap[key].quantity==undefined) && this.productQtyMap[key].price>0){
                        this.showCartButton=true;
                        this.conditionCodeHasPrice=false;
                        this.conditionCodePriceId=this.productQtyMap[key].conditionCodeId;
                        this.priceType=this.productQtyMap[key].priceType;
                    }else if(this.productQtyMap[key].quantity==undefined || this.productQtyMap[key].quantity==0 || this.productQtyMap[key].price==0){
                        this.showCartButton=true;
                        this.conditionCodeHasPrice=false;
                        this.conditionCodePriceId=this.productQtyMap[key].conditionCodeId;
                        this.priceType=this.productQtyMap[key].priceType;
                    }else if(this.productQtyMap[key].price==undefined){
                        this.showCartButton=true;
                        this.conditionCodeHasPrice=false;
                        this.conditionCodePriceId=this.productQtyMap[key].conditionCodeId;
                        this.priceType=this.productQtyMap[key].priceType;
                    }
                    
                }
            }
            if(this.priceType!=undefined){
                this.hasPriceType=true;
            }else{
                this.hasPriceType=false;
            }
            let labelConditionCode=this.conditionCodelabel;
            let priceConditionCode=this.conditionCodePrice;
            let conditionCodeId=this.conditionCodePriceId;
            let priceTypeValue=this.priceType;

             this.dispatchEvent(
                new CustomEvent('productconditioncodeandprice', {
                    detail: {
                        labelConditionCode,
                        priceConditionCode,
                        conditionCodeId,
                        priceTypeValue
                    }
                })
            );

            if(this.effectiveAccountId==='000000000000000'){
                this.showCartButton=false;
                this.isConditionCodeSelected=false;
            }else{
                this.checkProductExistIntoCartOrNot();
            }
            this.template.querySelector('c-add-_-quote').callConnCallback(this.conditionCodeLabelQuote,this.conditionCodeIdQuote);
       } 
    }

    checkProductExistIntoCartOrNot(){
        checkProductAddedIntoCartOrNot({productId:this.productRecordId,cartId:this.cartId}).then((resultInstock) => {
                if(resultInstock.Id!=undefined){
                    if(this.conditionCodelabel!=JSON.stringify(resultInstock.Condition_Code_Price_Type__c).replace(/"/g, "")){
                        this.showCartButton=true;
                        this.conditionCodeHasPrice=true;
                        this.productAlreadyAddedIntoCart=true;
                        this.conditionCodeAlreadyAdded=resultInstock.Condition_Code_Price_Type__c;
                    }else{
                        this.showCartButton=false;
                        this.conditionCodeHasPrice=true;
                        this.productAlreadyAddedIntoCart=false;
                        //this.getPriceByConditionCode();  
                    }
                }
        })
    }

    /*getPriceByConditionCode(){
        getPriceBasedOnConditionCode({conditionCodeId:this.conditionCodePriceId,productId:this.productRecordId}).then((result) => {

            if(result[this.conditionCodelabel]){
                this.conditionCodeHasPrice=true;
                for(var key in result){
                    this.conditionCodePrice= result[key].inscor__Price__c;
                    this.priceType= result[key].inscor__Price_Type__c;
                }
           }else{
                this.conditionCodeHasPrice=false;
                this.conditionCodePrice="";
            }

            if(this.priceType){
                this.hasPriceType=true;
            }else{
                this.hasPriceType=false;
            }
            
            for(var key in this.productQtyMap){
                if(this.productQtyMap[key].key===this.conditionCodelabel){
                    if(this.productQtyMap[key].value>0 && this.conditionCodePrice!=""){
                        this.productAvailableQty=this.productQtyMap[key].qty;
                        this.showCartButton=false;
                    }else if(((this.productQtyMap[key].value<=0 || this.productQtyMap[key].value===undefined) && this.conditionCodePrice!="")){
                        this.conditionCodeHasPrice=false;
                        this.showCartButton=true;
                    }else if(this.productQtyMap[key].value>0  && (this.conditionCodePrice==="" || this.conditionCodePrice===undefined)){
                        this.conditionCodeHasPrice=false;
                        this.showCartButton=true;
                    }
                    
                }
            }
        })
    }*/

    _invalidQuantity = false;
    _quantityFieldValue = 1;
    _categoryPath;
    _resolvedCategoryPath = [];

    // A bit of coordination logic so that we can resolve product URLs after the component is connected to the DOM,
    // which the NavigationMixin implicitly requires to function properly.
    _resolveConnected;
    _connected = new Promise((resolve) => {
        this._resolveConnected = resolve;
    });

    connectedCallback() {
        this._resolveConnected();
    }

    disconnectedCallback() {
        this._connected = new Promise((resolve) => {
            this._resolveConnected = resolve;
        });
    }

    /**
     * Gets or sets the ordered hierarchy of categories to which the product belongs, ordered from least to most specific.
     *
     * @type {Category[]}
     */
    @api
    get categoryPath() {
        return this._categoryPath;
    }

    set categoryPath(newPath) {
        this._categoryPath = newPath;
        this.resolveCategoryPath(newPath || []);
    }

    get hasPrice() {
        return ((this.price || {}).negotiated || '').length > 0;
    }

    /**
     * Gets whether add to cart button should be displabled
     *
     * Add to cart button should be disabled if quantity is invalid,
     * if the cart is locked, or if the product is not in stock
     */
    get _isAddToCartDisabled() {
        return this._invalidQuantity || this.cartLocked;
    }

    handleQuantityChange(event) {
        if (event.target.validity.valid && event.target.value) {
            this._invalidQuantity = false;
            this._quantityFieldValue = event.target.value;
        } else {
            this._invalidQuantity = true;
        }
    }

    /**
     * Emits a notification that the user wants to add the item to their cart.
     *
     * @fires ProductDetailsDisplay#addtocart
     * @private
     */
    notifyAddToCart() {
        let quantity = this._quantityFieldValue;
        this.dispatchEvent(
            new CustomEvent('addtocart', {
                detail: {
                    quantity
                }
            })
        );
        this.IsAddToCartPopUp = true;
    }

    // Nevgate to cat page.
    navigateToCartPage(){
        var CartId=this.cartId;//'0a66s00000001T9AAI';
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                //objectApiName: 'WebCart',
                //recordId: CartId    
                url: '/cart/'+ CartId           
            }
        }).then(generatedUrl => {
            window.open(generatedUrl);
        });
    }

    closeAddToCartPopUp(){
        this.IsAddToCartPopUp = false;
    }

    /**
     * Emits a notification that the user wants to add the item to a new wishlist.
     *
     * @fires ProductDetailsDisplay#createandaddtolist
     * @private
     */
    notifyCreateAndAddToList() {
        this.dispatchEvent(new CustomEvent('createandaddtolist'));
    }

    /**
     * Updates the breadcrumb path for the product, resolving the categories to URLs for use as breadcrumbs.
     *
     * @param {Category[]} newPath
     *  The new category "path" for the product.
     */
    resolveCategoryPath(newPath) {
        const path = [homePage].concat(
            newPath.map((level) => ({
                name: level.name,
                type: 'standard__recordPage',
                attributes: {
                    actionName: 'view',
                    recordId: level.id
                }
            }))
        );

        this._connected
            .then(() => {
                const levelsResolved = path.map((level) =>
                    this[NavigationMixin.GenerateUrl]({
                        type: level.type,
                        attributes: level.attributes
                    }).then((url) => ({
                        name: level.name,
                        url: url
                    }))
                );

                return Promise.all(levelsResolved);
            })
            .then((levels) => {
                this._resolvedCategoryPath = levels;
            });
    }

    /**
     * Gets the iterable fields.
     *
     * @returns {IterableField[]}
     *  The ordered sequence of fields for display.
     *
     * @private
     */
    get _displayableFields() {
        // Enhance the fields with a synthetic ID for iteration.
        return (this.customFields || []).map((field, index) => ({
            ...field,
            id: index
        }));
    }

    

    
}