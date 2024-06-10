/**
* The purpose of this class is to be the controller for the CustomerRelatedProduct component
* It returns the Product record by providing the ContactId
*/
public with sharing class CustomerRelatedProductController {
    
    @AuraEnabled(cacheable=true)
    public static Product2 getCustomerProductComponent(Id contactId) {
        Contact customerContact = ContactProductUtils.getContactById(contactId);
        return ContactProductUtils.getCustomerProduct(customerContact);
    }

}