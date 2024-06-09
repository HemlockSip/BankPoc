public with sharing class TestDataFactory {

    public static Account TestAccount() {

        Account testAccount = new Account(
                                        Name = 'Test Account'
                                        );
        insert testAccount;
        return testAccount;

    }

    public static Contact TestFullContact(Id accountId) {

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

    public static Contact TestIncompleteContact(Id accountId) {

        Contact testContact = new Contact(
                                        FirstName = 'Test',
                                        LastName = 'Contact',
                                        AccountId = accountId,
                                        Home_Country__c = 'UK'
                                        );
        insert testContact;
        return testContact;

    }



    public static Product2 TestProduct() {

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

    public static Case TestCase(Id contactId) {

        Case testCase = new Case(
                                ContactId = contactId
                                );
        insert testCase;
        return testCase;

    }

    public static Case TestCaseNoContact() {

        Case testCase = new Case();
        insert testCase;
        return testCase;

    }

}