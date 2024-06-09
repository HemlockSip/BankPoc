@IsTest
private with sharing class CustomerRelatedProductController_Test {
    // Test method for getCustomerProductComponent
    @isTest
    static void testGetCustomerProductComponent() {

        Account testAccount = TestDataFactory.TestAccount();
        Contact testContact = TestDataFactory.TestFullContact(testAccount.Id);
        
        Product2 testProduct = TestDataFactory.TestProduct();
        

        Test.startTest();
        
        Product2 resultProduct = CustomerRelatedProductController.getCustomerProductComponent(testContact.Id);

        Test.stopTest();

        System.assertNotEquals(null, resultProduct, 'Product2 should not be null');
        System.assertEquals(testProduct.Id, resultProduct.Id, 'The retrieved Product2 should match the test Product2');
    }

}
