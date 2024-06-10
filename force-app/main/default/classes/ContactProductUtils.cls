/**
* The purpose of this class is to handle the logic necessary to retrieve the Contact and Product details based on the Contact Id or Unique Identifier.
*/
public with sharing class ContactProductUtils {

    public static Contact getContactById(Id contactId) {
        
        try {
            Contact customerContact = [SELECT Id, Product__c, Home_Country__c
                                    FROM Contact
                                    WHERE Id =: contactId
                                    WITH SECURITY_ENFORCED
                                    LIMIT 1];
            return customerContact;
            
        } catch (Exception e) {
            throw new QueryException(e.getMessage());
        }
        
    }

    public static Contact getContactByUniqueIdentifier(String uniqueIdentiefier){

        try {
            Contact customerContact = [SELECT Id, Product__c, Home_Country__c
                                    FROM Contact
                                    WHERE Unique_Identifier__c =: uniqueIdentiefier
                                    WITH SECURITY_ENFORCED
                                    LIMIT 1];
        return customerContact;

        } catch (Exception e) {
            throw new QueryException(e.getMessage());
        }
        
    }

    public static Product2 getCustomerProduct(Contact customerContact) {
       
        try {
            
            System.debug('Customer Contact: ' + customerContact);

            //Query to get the Product details based on the Product Name and Home Country of the Contact
            Product2 customerProduct = [SELECT Id, Name,Home_Country__c, Cost_per_Calendar_Month__c, ATM_Fee_in_other_Currencies__c, Card_Replacement_Cost__c
                                        FROM Product2 
                                        WHERE Name =: customerContact.Product__c
                                        AND Home_Country__c =: customerContact.Home_Country__c
                                        WITH SECURITY_ENFORCED
                                        LIMIT 1];
                                        
            System.debug('Customer Product: ' + customerProduct);
            return customerProduct;

        } catch (Exception e) {
            throw new QueryException(e.getMessage());
        }
            
    }   
}