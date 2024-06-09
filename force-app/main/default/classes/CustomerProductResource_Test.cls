@isTest
private with sharing class CustomerProductResource_Test {

    @IsTest
    private static void  positiveScenario() {

        Account testAccount = TestDataFactory.TestAccount();
        // Create a mock Contact and Product2
        Contact testContact = TestDataFactory.TestFullContact(testAccount.Id);

        Product2 testProduct = TestDataFactory.TestProduct();

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
    
}