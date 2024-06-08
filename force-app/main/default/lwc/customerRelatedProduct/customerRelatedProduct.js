import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
//import getCustomerProductComponent from '@salesforce/apex/CustomerRelatedProductController.getCustomerProductComponent';
//import getCustomerId from '@salesforce/apex/CustomerRelatedProductController.getCustomerId';
import getCustomerProductComponent2 from '@salesforce/apex/CustomerRelatedProductController.getCustomerProductComponent2';

const FIELDS = ['Case.ContactId'];
const PRODUCT_FIELDS = ['Product2.Name', 'Product2.Home_Country__c'];

export default class CustomerProduct extends LightningElement {
    @api recordId; // This is the Case record ID

    contactId;
    currency;
    Home_Country__c;

    // Get the ContactId from the Case record
    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    caseRecord({ error, data }) {
        if (data) {
            this.contactId = data.fields.ContactId.value;
        } else if (error) {
            console.error('Error fetching Case record:', error);
        }
    }

    product;
    error;

    // Fetch the Product2 data using the ContactId
    @wire(getCustomerProductComponent2, { contactId: '$contactId' })
    wiredProduct({ error, data }) {
        if (data) {
            this.product = data;
            console.log('Product:', this.product);
            const homeCountry = this.product.Home_Country__c;
            console.log('data e country:', data.Home_Country__c);
            if (homeCountry) {
                this.currency = this.getCurrency(homeCountry);
            } else {
                this.currency = 'Unknown'; // Default or fallback value
            }
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.product = undefined;
        }
    }

    get hasProduct() {
        return this.product !== undefined;
    }

    getCurrency(homeCountry){
        if (homeCountry == 'UK'){
            return 'GBP';
        }
        else{
            return 'EUR';
        }
    }


}
