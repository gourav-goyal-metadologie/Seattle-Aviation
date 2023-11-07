import { LightningElement, wire } from 'lwc';
import customerQuoteReportByPartNameCtrl from '@salesforce/apex/customerQuoteReportByPartNameCtrl.getQuoteReportResults';

const columns = [
    { label: 'Part Numbers', fieldName: 'partNumber' },
    { label: 'PN Keyword', fieldName: 'pnKeyword', type: 'string' },
    { label: 'Total Quotes', fieldName: 'totalQuotes' },
    { label: 'Avg Pricing', fieldName: 'averagePrice', type: 'currency'},
    { label: 'Purchase Type', fieldName: 'purchaseType' },
    { label: 'Avg Qty', fieldName: 'averageQty' },
    { label: 'Max Qty', fieldName: 'maxQty' },
];
export default class MostQuotedPartsReport extends LightningElement {

    data = [];
    columns = columns;
    isLoading = true;

    @wire(customerQuoteReportByPartNameCtrl, {})
    getReportResults ({error, data}) {
        if (data) {
            this.data = data;
            this.isLoading = false;
        } else if (error) {
            console.log(error);
            this.isLoading = false;
            // TODO: Data handling
        }
    }
}