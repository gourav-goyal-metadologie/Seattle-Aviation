public with sharing class Utility {
    public static Map<String, String> relationshipNameToFieldNameMap = new Map<String, String>();

    public static Map<Integer, Map<String, String>> getChildObjectQueryMap(String parentObjectName) {
        Map<Integer, List<String>> childObjectMap = new Map<Integer, List<String>>();

        // To store inner query String for child objects
        Map<Integer, List<String>> childObjectQStringMap = new Map<Integer, List<String>>();
        Map<Integer, Map<String, String>> childObjectNameToQStringMap = new Map<Integer, Map<String, String>>();

        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        for(String ss1: Schema.getGlobalDescribe().keySet()){
            if(ss1.equalsIgnoreCase(parentObjectName)) {
                Schema.SObjectType objToken = schemaMap.get(ss1);
                Schema.DescribeSObjectResult objDescribe = objToken.getDescribe();

                List<Schema.ChildRelationship> childRelationshipList = objDescribe.getChildRelationships();
                System.debug('*********childRelationshipList size:'+childRelationshipList.size());
                for(Schema.ChildRelationship ss : childRelationshipList){
                    if(ss.getRelationshipName() != null){
                        Boolean isParentFieldUpdateable = ss.getField().getDescribe().isUpdateable();
                        if(!isParentFieldUpdateable) continue;

                        String RelationshipName = ss.getRelationshipName();
                        String childObjName = String.valueOf(ss.getChildSObject());
                        relationshipNameToFieldNameMap.put(RelationshipName, ss.getField().getDescribe().getName());

                        // Check if child object is isQueryable() or not
                        Schema.DescribeSObjectResult childObjDescribe = schemaMap.get(childObjName).getDescribe();
                        System.debug('*******childObjName:'+childObjName);
                        if(childObjDescribe.isQueryable()){
                            if(childObjectMap.size() == 0 || childObjectMap.get(childObjectMap.size()).size() == 20){
                                childObjectMap.put(childObjectMap.size()+1, new List<String>());
                                childObjectMap.get(childObjectMap.size()).add(RelationshipName);

                                childObjectQStringMap.put(childObjectQStringMap.size()+1, new List<String>());
                                childObjectQStringMap.get(childObjectQStringMap.size()).add('(SELECT Id FROM '+ RelationshipName + ' )');

                                childObjectNameToQStringMap.put(
                                        childObjectNameToQStringMap.size()+1,
                                        new Map<String, String>{RelationshipName => '(SELECT Id FROM '+ RelationshipName + ' )'}
                                );
                            }else{
                                childObjectMap.get(childObjectMap.size()).add(RelationshipName);
                                childObjectQStringMap.get(childObjectQStringMap.size()).add('(SELECT Id FROM '+ RelationshipName + ' )');

                                Map<String, String> relationshipNameToQueryMap = childObjectNameToQStringMap.get(childObjectNameToQStringMap.size());
                                relationshipNameToQueryMap.put(RelationshipName, '(SELECT Id FROM '+ RelationshipName + ' )');
                                childObjectNameToQStringMap.put(
                                        childObjectNameToQStringMap.size(),
                                        relationshipNameToQueryMap
                                );
                            }
                        }
                    }
                }
            }
        }

        System.debug('***childObjectmap.size():'+ childObjectMap.size());
        System.debug('***childObjectQStringmap.size():'+ childObjectQStringMap.size());
        System.debug('***childObjectQStringmap all:'+ childObjectQStringMap);

        return childObjectNameToQStringMap;
    }

    public static String createSingleQueryFromRelationshipNames(Map<String, String> relNameToQueryMap){
        String query = '';
        for(String relQuery : relNameToQueryMap.values()) {
            query += relQuery + ', ';
        }
        query = query.substring(0, query.length()-2);

        return query;
    }

    public static void mergeSObjectMaps(Map<String, List<SObject>> masterMap, Map<String, List<SObject>> mergingMap) {
        if(masterMap == null) masterMap = new Map<String, List<SObject>>();
        if(mergingMap == null || mergingMap.isEmpty()) return;

        for(String key : mergingMap.keySet()) {
            List<SObject> records = (masterMap.containsKey(key)) ? masterMap.get(key) : new List<SObject>();
            records.addAll(mergingMap.get(key));
            masterMap.put(key,records);
        }
    }
}