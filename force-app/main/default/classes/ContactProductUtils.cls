public with sharing class ContactProductUtils {
    public static Product2 getCustomerProduct(Id contactId) {

        System.debug('Contact ID: ' + contactId);  
        
        try {
            //First Query to get the Product Name and Home Country of the Contact
            Contact customerContact = [SELECT Id, Product__c,Home_Country__c
                                        FROM Contact
                                        WHERE Id =: contactId
                                        WITH SECURITY_ENFORCED
                                        LIMIT 1];
            System.debug('Customer Contact: ' + customerContact);

            //Second Query to get the Product details based on the Product Name and Home Country of the Contact
            Product2 customerProduct = [SELECT Id, Name, ProductCode, Description, Family, IsActive, Home_Country__c, Cost_per_Calendar_Month__c, ATM_Fee_in_other_Currencies__c, Card_Replacement_Cost__c
                                        FROM Product2 
                                        WHERE Name =: customerContact.Product__c
                                        AND Home_Country__c =: customerContact.Home_Country__c
                                        WITH SECURITY_ENFORCED
                                        LIMIT 1];
                                        
            System.debug('Customer Product: ' + customerProduct);
            return customerProduct;

        } catch (Exception excep) {
            throw new AuraHandledException(excep.getMessage());
        }
            
    }   
}