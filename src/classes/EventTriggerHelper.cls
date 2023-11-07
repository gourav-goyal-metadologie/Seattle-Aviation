public class EventTriggerHelper {
	Public static List<Event> newList = new List<Event>();
    Public static List<Event> oldList = new List<Event>();
    Public static Map<Id,Event> newMap = new Map<Id,Event>();
    Public static Map<Id,Event> oldMap = new Map<Id,Event>();
    
    public static void updateLeadProbablityOnInsert(){
        Set<Id> leadIds = new Set<Id>();
        for(Event eventRec :  newList){
            if(eventRec.WhoId != null && ((String)(eventRec.WhoId)).StartsWith('00Q')){
                leadIds.add(eventRec.WhoId);
            }
        }
        LeadUtilityCntrl.updateLeadConversionProbablity(leadIds);
    }
    
    public static void updateLeadProbablityOnUpdate(){
        Set<Id> leadIds = new Set<Id>();
        for(Event eventRec :  newList){
            if(eventRec.WhoId != null && ((String)(eventRec.WhoId)).StartsWith('00Q') && eventRec.WhoId != oldMap.get(eventRec.Id).WhoId){
                leadIds.add(eventRec.WhoId);
                leadIds.add(oldMap.get(eventRec.Id).WhoId);
            }
        }
        LeadUtilityCntrl.updateLeadConversionProbablity(leadIds);
    }
    
    public static void updateLeadProbablityOnDelete(){
        Set<Id> leadIds = new Set<Id>();
        for(Event eventRec :  oldList){
            if(eventRec.WhoId != null && ((String)(eventRec.WhoId)).StartsWith('00Q')){
                leadIds.add(eventRec.WhoId);
            }
        }
        LeadUtilityCntrl.updateLeadConversionProbablity(leadIds);
    }
}