public class CountryStateUtility {

    public static Map<String, String> countryMap;
    public static Map<String, String> stateMap;
    
    static{
        countryMap = new Map<String, String>();
        for(Country_Codes__mdt country : [SELECT MasterLabel, Country_Code__c FROM Country_Codes__mdt]){
            countryMap.put(country.MasterLabel.toLowerCase(), country.Country_Code__c);
        }
        
        stateMap = new Map<String, String>();
        for(State_Code__mdt state : [SELECT MasterLabel, State_Code__c FROM State_Code__mdt]){
            stateMap.put(state.MasterLabel.toLowerCase(), state.State_Code__c);
        }
    }
    
    public static String getCountryCode(String country){
        if(country != null && countryMap.containsKey(country.toLowerCase())){
            return countryMap.get(country.toLowerCase());
        }
        return null;
    }
    
    public static String getStateCode(String state){
        if(state != null && stateMap.containsKey(state.toLowerCase())){
            return stateMap.get(state.toLowerCase());
        }
        return state;
    }
}