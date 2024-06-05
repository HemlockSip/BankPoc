import { LightningElement, api, wire } from 'lwc';
import getRelatedContact from '@salesforce/apex/CustomerRelatedProductController.getRelatedContact';
import getRelatedContactProduct from '@salesforce/apex/CustomerRelatedProductController.getRelatedContactProduct';
import { getRecord } from 'lightning/uiRecordApi';

export default class CustomerRelatedProduct extends LightningElement {
    @api recordId;
    contact;
    product;
    error;

    @wire(getRecord, { recordId: '$recordId', fields: ['Case.ContactId'] })
    wiredCase({ error, data }) {
        if (data) {
            this.fetchRelatedContact(data.fields.ContactId.value);
        } else if (error) {
            this.error = 'Contact error is '+error;
            console.error(error);
        }
    }

    fetchRelatedContact(contactId) {
        getRelatedContact({ caseId: this.recordId })
            .then(result => {
                this.contact = result;
                return getRelatedContactProduct({ homeCountry: result.Home_Country__c, productId: result.Product__c });
            })
            .then(result => {
                this.product = result;
            })
            .catch(error => {
                this.error = 'product error is '+error;
                console.error(error);
            });
    }
}