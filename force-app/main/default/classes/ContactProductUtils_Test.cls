@IsTest
private with sharing class ContactProductUtils_Test {
    
    
    @IsTest
    private static void positiveOutcome() {
        // the purpose of this test method is to verify a successful scenario where all the data is present and correct
        
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Contact testContact = new Contact(FirstName = 'Test', LastName = 'Contact', AccountId = testAccount.Id, Product__c = 'Standard', Home_Country__c = 'UK');
        insert testContact;

        Product2 testProduct = new Product2(Name = 'Standard', ProductCode = 'STD', Description = 'Standard Product', IsActive = true, Home_Country__c = 'UK', Cost_per_Calendar_Month__c = 0, ATM_Fee_in_other_Currencies__c = 1.7, Card_Replacement_Cost__c = 6);
        insert testProduct;

        Case testCase = new Case(ContactId = testContact.Id);
        insert testCase;

   
        Contact actualContact = ContactProductUtils.getContactById(testCase.ContactId);
        Product2 actualProduct = ContactProductUtils.getCustomerProduct(actualContact);
       

        System.assertEquals(testContact.Id, actualContact.Id, 'Contact Ids should match');
        System.assertEquals(testProduct.Id, actualProduct.Id, 'Product Ids should match');
    }
    @isTest
    private static void emptyContact() {
        // the purpose of this test method is to verify an unsuccessful scenario where a contact is missing some data and therefore no product will be found
        
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Contact testContact = new Contact(FirstName = 'Test', LastName = 'Contact', AccountId = testAccount.Id, Home_Country__c = 'UK');
        insert testContact;

        Product2 testProduct = new Product2(Name = 'Standard', ProductCode = 'STD', Description = 'Standard Product', IsActive = true, Home_Country__c = 'UK', Cost_per_Calendar_Month__c = 0, ATM_Fee_in_other_Currencies__c = 1.7, Card_Replacement_Cost__c = 6);
        insert testProduct;

        Case testCase = new Case(ContactId = testContact.Id);
        insert testCase;

        try {

            Contact actualContact = ContactProductUtils.getContactById(testCase.ContactId);
            Product2 actualProduct = ContactProductUtils.getCustomerProduct(actualContact);
            System.Assert.fail('Exception Expected as no product will be found');

        } catch (Exception ex) {
        // Check the exception type and message to ensure it's the expected exception
        System.assertEquals('System.QueryException', ex.getTypeName(), 'Unexpected exception type');
        
        // Optionally, log the exception details for debugging purposes
        System.debug('Expected exception caught: ' + ex.getMessage());
    }

    }

    @isTest
    private static void noContact() {
        // the purpose of this test method is to verify an unsuccessful scenario where the case has no related contact
        
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Contact testContact = new Contact(FirstName = 'Test', LastName = 'Contact', AccountId = testAccount.Id, Home_Country__c = 'UK');
        insert testContact;

        Product2 testProduct = new Product2(Name = 'Standard', ProductCode = 'STD', Description = 'Standard Product', IsActive = true, Home_Country__c = 'UK', Cost_per_Calendar_Month__c = 0, ATM_Fee_in_other_Currencies__c = 1.7, Card_Replacement_Cost__c = 6);
        insert testProduct;

        Case testCase = new Case();
        insert testCase;

        try {

            Contact actualContact = ContactProductUtils.getContactById(testCase.ContactId);
            Product2 actualProduct = ContactProductUtils.getCustomerProduct(actualContact);
            System.Assert.fail('Exception Expected as no product will be found');

        } catch (Exception ex) {
        // Check the exception type and message to ensure it's the expected exception
        System.assertEquals('System.QueryException', ex.getTypeName(), 'Unexpected exception type');
        
        // Optionally, log the exception details for debugging purposes
        System.debug('Expected exception caught: ' + ex.getMessage());
    }

    }
    // TO DO: Add the test to get a contact with unique identifier
}
