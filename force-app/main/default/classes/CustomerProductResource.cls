@RestResource(urlMapping='/Contact/*')
global with sharing class CustomerProductResource {

    @HttpGet
    global static Product2 getCustomerProduct() {
        
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        String uniqueIdentifier = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
       
        Contact customerContact = ContactProductUtils.getContactByUniqueIdentifier(uniqueIdentifier);

        Product2 customerProduct = ContactProductUtils.getCustomerProduct(customerContact);

        return customerProduct;

    }
}