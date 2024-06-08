public with sharing class ContactProductUtils {

    public static Contact getContactById(Id contactId) {
        return [SELECT Id, Product__c, Home_Country__c
                FROM Contact
                WHERE Id =: contactId
                WITH SECURITY_ENFORCED
                LIMIT 1];
    }

    public static Contact getContactByUniqueIdentifier(String uniqueIdentiefier){
        return [SELECT Id, Product__c, Home_Country__c
                FROM Contact
                WHERE Unique_Identifier__c =: uniqueIdentiefier
                WITH SECURITY_ENFORCED
                LIMIT 1];
    }


    public static Product2 getCustomerProduct(Id contactId) {

        System.debug('Contact ID: ' + contactId);  
        
        try {
            //First Query to get the Product Name and Home Country of the Contact
            //TODO REWORKA IL CODICE PER FARE IN MODO CHE UN METODO GESTISCA LA QUERY CONTACT E UNO SEPARATO LA QUERY PRODUCT
            // IN QUESTO MODO POTRO' RIUSARE IL PIU' POSSIBILE IL CODICE ANCHE PER IL WEBSERVICE
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

    public static Product2 getCustomerProductTry(Contact customerContact) {
       
        try {
            
            System.debug('Customer Contact: ' + customerContact);

            //Query to get the Product details based on the Product Name and Home Country of the Contact
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