/**
* The purpose of this class is to create test data for all the involved test classes.
* It returns a record for each Object
* Account
* Contact
* Product2
* Case
*/
public with sharing class TestDataFactory {

    public static Account testAccount() {

        Account testAccount = new Account(
                                        Name = 'Test Account'
                                        );
        insert testAccount;
        return testAccount;

    }

    // Create a full contact with all the necessary fields for successfull scenarios
    public static Contact testFullContact(Id accountId) {

        Contact testContact = new Contact(
                                        FirstName = 'Test',
                                        LastName = 'Contact',
                                        AccountId = accountId,
                                        Product__c = 'Standard',
                                        Unique_Identifier__c = '12345',
                                        Home_Country__c = 'UK'
                                        );
        insert testContact;
        return testContact;

    }

    // Create a contact with missing fields for negative scenarios
    public static Contact testIncompleteContact(Id accountId) {

        Contact testContact = new Contact(
                                        FirstName = 'Test',
                                        LastName = 'Contact',
                                        AccountId = accountId,
                                        Home_Country__c = 'UK'
                                        );
        insert testContact;
        return testContact;

    }



    public static Product2 testProduct() {

        Product2 testProduct = new Product2(
                                        Name = 'Standard',
                                        ProductCode = 'STD',
                                        Description = 'Standard Product',
                                        IsActive = true,
                                        Home_Country__c = 'UK',
                                        Cost_per_Calendar_Month__c = 0,
                                        ATM_Fee_in_other_Currencies__c = 1.7,
                                        Card_Replacement_Cost__c = 6
                                        );
        insert testProduct;
        return testProduct;

    }

    // Create a case associated with a Contact
    public static Case testCase(Id contactId) {

        Case testCase = new Case(
                                ContactId = contactId
                                );
        insert testCase;
        return testCase;

    }

    // Create a case not associated with a Contact
    public static Case testCaseNoContact() {

        Case testCase = new Case();
        insert testCase;
        return testCase;

    }

}