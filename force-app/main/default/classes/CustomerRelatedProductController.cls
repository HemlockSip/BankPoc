public with sharing class CustomerRelatedProductController {
    @AuraEnabled
    public static Contact getRelatedContact(ID caseId){
        try { 
            // Debug log for caseId
            System.debug('Case ID: ' + caseId);


            // Query for the case details
            Case visualizedCase = [SELECT ContactId 
                                   FROM Case 
                                   WHERE Id = :caseId 
                                   WITH SECURITY_ENFORCED LIMIT 1];


            Contact contact = [SELECT Id, FirstName, LastName, Email, Phone, Home_Country__c, Product__c 
                                      FROM Contact 
                                      WHERE Id = :visualizedCase.ContactId
                                      WITH SECURITY_ENFORCED
                                      LIMIT 1];
            return contact;

        } catch (Exception e) {
            // Debug log for the exception
            System.debug('Exception: ' + e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Product2 getRelatedContactProduct(String homeCountry, String productId){  // Since I have to diploay only the Product Info on the UI, I could rework the two methods in just one and then call it from the LWC
        try {
            // Debug log for parameters
            System.debug('Home Country: ' + homeCountry);
            System.debug('Product ID: ' + productId);

            List<Product2> products = [SELECT Id, Name, ProductCode, Description, Family, IsActive, Home_Country__c, Cost_per_Calendar_Month__c, ATM_Fee_in_other_Currencies__c, Card_Replacement_Cost__c
                                       FROM Product2 
                                       WHERE Id = :productId
                                       WITH SECURITY_ENFORCED
                                       LIMIT 1];

            // Debug log for the query result
            System.debug('Products size: ' + products.size());

            if (!products.isEmpty()) {
                return products[0];
            } else {
                throw new AuraHandledException('No product found for the given home country and product ID.');
            }

        } catch (Exception e) {
            // Debug log for the exception
            System.debug('Exception: ' + e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }
}
