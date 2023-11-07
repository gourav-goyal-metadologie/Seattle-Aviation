public class LeadUtilityCntrl {

    /**
     * @description : method used to calculate conversion probablity on the basis of number of follow ups made on the lead
     * created Reason : Under SS-22
     */
    public static void updateLeadConversionProbablity(Set<Id> leads){
        Map<String,Lead_Managment__mdt> leadManagmentSettings = Lead_Managment__mdt.getall();
        //Integer conversionProbablityToAddByDefault = 2;
        Decimal noOfFollowup = Decimal.valueOf(leadManagmentSettings.containsKey('FollowUp_Count') ? 
                   ( leadManagmentSettings.get('FollowUp_Count').Value__c != null ? 
                    leadManagmentSettings.get('FollowUp_Count').Value__c : '10' ) : '10');
        Integer conversionProbablityToAddByDefault = Integer.valueOf(leadManagmentSettings.containsKey('Probablity_to_add_Until_followup_count') ? 
                    (leadManagmentSettings.get('Probablity_to_add_Until_followup_count').Value__c != null ?  
                    leadManagmentSettings.get('Probablity_to_add_Until_followup_count').Value__c : '2') : '2');
        List<Lead> leadRecs = [Select Id,Conversion_Probablity__c,(Select Id from Tasks),(Select Id from Events) from Lead where Id IN: leads];
        for(Lead leadRec :  leadRecs){
            decimal totalCount = leadRec.Tasks.size() + leadRec.Events.size();
            if(totalCount <= noOfFollowup){
                leadRec.Conversion_Probablity__c =  leadRec.Conversion_Probablity__c + conversionProbablityToAddByDefault > 100 ? 100 : leadRec.Conversion_Probablity__c + conversionProbablityToAddByDefault;
            } else{
                Decimal conversionProbabilityToAdd = (100/totalCount);
                leadRec.Conversion_Probablity__c =  leadRec.Conversion_Probablity__c + conversionProbabilityToAdd > 100 ? 100 : leadRec.Conversion_Probablity__c + conversionProbabilityToAdd;
            }
        }
        if(leadRecs.size() > 0){
            update leadRecs;
        }
    }
}