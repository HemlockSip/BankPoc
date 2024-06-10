/**
* The purpose of this class is to test successful and unsuccessfull scenarios when using the CustomerProductResource class.
*/
@isTest
private with sharing class CustomerProductResource_Test {

    @IsTest
    private static void  positiveScenario() {
        //In this scenario all the Data is present

        Account testAccount = TestDataFactory.testAccount();
        // Create a mock Contact and Product2
        Contact testContact = TestDataFactory.testFullContact(testAccount.Id);

        Product2 testProduct = TestDataFactory.testProduct();

        // Create a new RestRequest
        RestRequest req = new RestRequest();
        req.requestUri = '/services/apexrest/Contact/12345';
        req.httpMethod = 'GET';

        // Create a new RestResponse
        RestResponse res = new RestResponse();

        // Set the RestContext with the request and response
        RestContext.request = req;
        RestContext.response = res;

        // Call the method
        Test.startTest();
        Product2 result = CustomerProductResource.getCustomerProduct();
        Test.stopTest();

        // Validate the response
        System.assertNotEquals(null, result, 'The returned product should not be null.');
        System.assertEquals(testProduct.Id, result.Id, 'The product Id should match the expected test product Id.');
        System.assertEquals(testProduct.Name, result.Name, 'The product Name should match the expected test product Name.');
        System.assertEquals(testProduct.Home_Country__c, result.Home_Country__c, 'The product Home Country should match the expected test product Home Country.');
    }

    @IsTest
    private static void  negativeScenario404() {

        //In this scenario no contact with unique identifier is found, leading to a null product

        Account testAccount = TestDataFactory.testAccount();
        // Create a mock Contact and Product2
        Contact testContact = TestDataFactory.testIncompleteContact(testAccount.Id);

        Product2 testProduct = TestDataFactory.testProduct();

        // Create a new RestRequest
        RestRequest req = new RestRequest();
        req.requestUri = '/services/apexrest/Contact/12345';
        req.httpMethod = 'GET';

        // Create a new RestResponse
        RestResponse res = new RestResponse();

        // Set the RestContext with the request and response
        RestContext.request = req;
        RestContext.response = res;

        // Call the method
        Test.startTest();
        try {

            Product2 result = CustomerProductResource.getCustomerProduct();
            System.assertEquals(null, result, 'The returned product should not be null.');

        } catch (Exception e) {
            System.assertEquals(404, res.statusCode,'Status Code should be 404');
            System.assertEquals('System.QueryException', e.getTypeName(), 'The expected Exception was not returned.');
        }
        Test.stopTest();

    }

    @IsTest
    private static void  negativeScenario500() {

        //In this scenario no contact with unique identifier is found, leading to a null product

        Account testAccount = TestDataFactory.testAccount();
        // Create a mock Contact and Product2
        Contact testContact = TestDataFactory.testIncompleteContact(testAccount.Id);

        Product2 testProduct = TestDataFactory.testProduct();

        // Create a new RestRequest
        RestRequest req = new RestRequest();
        req.requestUri = '/services/apexrest/Contact/12345';
        req.httpMethod = 'GET';

        // Create a new RestResponse
        RestResponse res = new RestResponse();

        // Set the RestContext with the request and response
        RestContext.request = req;
        RestContext.response = res;

        res.statusCode = 500;

        // Call the method
        Test.startTest();
        try {

            Product2 result = CustomerProductResource.getCustomerProduct();
            System.assertEquals(null, result, 'The returned product should not be null.');

        } catch (Exception e) {
            System.assertEquals('System.QueryException', e.getTypeName(), 'The expected Exception was not returned.');
        }
        Test.stopTest();

    }

    
}