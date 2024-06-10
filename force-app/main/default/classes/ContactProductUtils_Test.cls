/**
* The purpose of this class is to test successful and unsuccessfull scenarios when using the ContactProductUtils class.
*/
@IsTest
private with sharing class ContactProductUtils_Test {
    
    @IsTest
    private static void positiveOutcome() {
        // The purpose of this test method is to verify a successful scenario where all the data is present and correct
        
        Account testAccount = TestDataFactory.testAccount();
        
        Contact testContact = TestDataFactory.testFullContact(testAccount.Id);
        
        Product2 testProduct = TestDataFactory.testProduct();
        
        Case testCase = TestDataFactory.testCase(testContact.Id);
        
   
        Contact actualContact = ContactProductUtils.getContactById(testCase.ContactId);
        Product2 actualProduct = ContactProductUtils.getCustomerProduct(actualContact);
       

        System.assertEquals(testContact.Id, actualContact.Id, 'Contact Ids should match');
        System.assertEquals(testProduct.Id, actualProduct.Id, 'Product Ids should match');
    }

    @isTest
    private static void emptyContact() {
        // the purpose of this test method is to verify an unsuccessful scenario where a contact is missing some data and therefore no product will be found
        
        Account testAccount = TestDataFactory.testAccount();
        
        Contact testContact = TestDataFactory.testIncompleteContact(testAccount.Id);
        
        Product2 testProduct = TestDataFactory.testProduct();
        
        Case testCase = TestDataFactory.testCase(testContact.Id);

        try {

            Contact actualContact = ContactProductUtils.getContactById(testCase.ContactId);
            Product2 actualProduct = ContactProductUtils.getCustomerProduct(actualContact);
            System.Assert.fail('Exception Expected as no product will be found');

        } catch (Exception ex) {
        // Check the exception type and message to ensure it's the expected exception
        System.assertEquals('System.QueryException', ex.getTypeName(), 'Unexpected exception type');
        
        // Log the exception details for debugging purposes
        System.debug('Expected exception caught: ' + ex.getMessage());
    }

    }

    @isTest
    private static void noContact() {
        // The purpose of this test method is to verify an unsuccessful scenario where the case has no related contact
        
        Account testAccount = TestDataFactory.testAccount();
        
        Contact testContact = TestDataFactory.testIncompleteContact(testAccount.Id);
        
        Product2 testProduct = TestDataFactory.testProduct();
        
        Case testCase = TestDataFactory.testCaseNoContact();

 
        try {

            Contact actualContact = ContactProductUtils.getContactById(testCase.ContactId);
            Product2 actualProduct = ContactProductUtils.getCustomerProduct(actualContact);
            
            System.Assert.fail('Exception Expected as no product will be found');

        } catch (Exception ex) {
            // Check the exception type and message to ensure it's the expected exception
            System.assertEquals('System.QueryException', ex.getTypeName(), 'Unexpected exception type');
        
            // Log the exception details for debugging purposes
            System.debug('Expected exception caught: ' + ex.getMessage());
        }
        
    }
 
}
