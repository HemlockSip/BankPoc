/**
* CustomerProductResource is a RESTful web service class that handles HTTP requests.
* This class manages GET requests to retrieve the Customer Product associated to a Contact record.
*/
@RestResource(urlMapping='/Contact/*')
global with sharing class CustomerProductResource {

    @HttpGet
    global static Product2 getCustomerProduct() {

        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        
        try {

            String uniqueIdentifier = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        
            Contact customerContact = ContactProductUtils.getContactByUniqueIdentifier(uniqueIdentifier);

            Product2 customerProduct = ContactProductUtils.getCustomerProduct(customerContact);

            return customerProduct;
            
        } catch (QueryException qe) {

            response.statusCode = 404;
            response.responseBody = Blob.valueOf('Product not found');
            return null;
            
        } catch (Exception e) {

            response.statusCode = 500;
            response.responseBody = Blob.valueOf('An unexpected error occurred: ' + e.getMessage());
            return null;
        }
        

    }
}