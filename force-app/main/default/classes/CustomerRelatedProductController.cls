public with sharing class CustomerRelatedProductController {
    
    //Reworked Method that leverages two methods for the Utils class to retrieve the Product Information

    @AuraEnabled(cacheable=true)
    public static Product2 getCustomerProductComponent(Id contactId) {
        Contact customerContact = ContactProductUtils.getContactById(contactId);
        return ContactProductUtils.getCustomerProduct(customerContact);
    }

}