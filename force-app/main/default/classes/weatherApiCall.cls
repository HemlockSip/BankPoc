public with sharing class weatherApiCall {

    // Variables necessary for the GeoLocAPI

    private static String cityName;
    private static String stateCode;
    private static String countryCode;
    private static String limitQuery;
    private static Date eventThreshold = Date.today()+16; 

    // Variables necessary for the ForecastAPI

    private static String lat;
    private static String lon;

    // Api Key

    private static final String APIKEY = String.valueOf([SELECT api_key__c FROM API_Key__mdt WHERE DeveloperName = 'Weather_Api_Key' WITH SECURITY_ENFORCED]);

    // Endpoints

    private static final String geoEndPoint = 'https://api.openweathermap.org/geo/1.0/direct?q='+cityName+','+stateCode+','+countryCode+'&limit='+limitQuery+'&appid='+ApiKey;
    private static final String forecastEndPoint = 'https://api.openweathermap.org/data/2.5/forecast/daily?lat={lat}&lon={lon}&cnt={cnt}&appid={API key}';
    

    // Let's get all events that are scheduled to happen within the next 16 days, which is the API limit
    private static List<Event__c> getEventList(){
        return [SELECT Id, Name, Location__c, Location_Country__c, Event_Date__c FROM Event__c WHERE Event_Date__c >=: eventThreshold WITH security_enforced];
    } 
    
    // This method gets all the necessary parameters from the Event__c records
    private static Map<String, List<String>> getEventParameters(List<Event__c> eventList){
        Map<String, List<String>> parametersMap = new Map<String, List<String>>();
        for (Event__c e : eventList){
            List<String> parametersList = new List<String>();
            String eventId = e.Id;
            parametersList.add(e.Location__c);
            parametersList.add(e.Location_Country__c);
            parametersList.add(String.valueOf(e.Event_Date__c));
            parametersList.add(e.Id);
            parametersMap.put(eventId, parametersList);
        }
        return parametersMap;
    }


    // Let's create a method that iterates through the parameters and creates a map of Cities and Countries.
    // Countries will be the Key as no Country can have the same Name as another Country
    // While a City could have the same name as another City
    // The purpose is to minimize the amount of API call to get the Geo Coordinates

    private static Map<String, String> getCountryCityMap(Map<String, List<String>> parametersMap){
        Map<String, String> countryCityMap = new Map<String, String>();
        for (String key : parametersMap.keySet()){
            List<String> parametersList = parametersMap.get(key);
            String city = parametersList[0];
            String country = parametersList[1];
            countryCityMap.put(country, city);
        }
        return countryCityMap;
    }

    // TO DO: I will also need a method that for each Country, it will get its country code to be used as a parameter for the GeoLocAPI


    private static Map<String, String> getCountryCode(Set<String> setOfCountries){
        
        Map<String, String> countryCodeMap = new Map<String, String>();
        for(Country_Code__c code : [SELECT Name, Iso_Code__c FROM Country_Code__c WHERE Name IN :setOfCountries WITH Security_Enforced]){
            countryCodeMap.put((String)code.Name, (String)code.Iso_Code__c);
        }
        return countryCodeMap;
    }




    // I will need a method that for each City and Country, it gets the latitude and the longitude via API

    public static void getLatitudeAndLongitude(){






    }





    public weatherApiCall() {

    }
}