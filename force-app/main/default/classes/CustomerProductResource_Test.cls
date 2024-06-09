@isTest
private with sharing class CustomerProductResource_Test {

    @IsTest
    private static void  positiveScenario() {

         // Create a mock Contact and Product2
         Contact testContact = new Contact(
            FirstName = 'Test',
            LastName = 'User',
            Unique_Identifier__c = '12345',
            Product__c = 'Standard',
            Home_Country__c = 'UK'
        );
        insert testContact;

        Product2 testProduct = new Product2(
            Name = 'Standard',
            Home_Country__c = 'UK',
            Cost_per_Calendar_Month__c = 100,
            ATM_Fee_in_other_Currencies__c = 10,
            Card_Replacement_Cost__c = 5,
            IsActive = true
        );
        insert testProduct;

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