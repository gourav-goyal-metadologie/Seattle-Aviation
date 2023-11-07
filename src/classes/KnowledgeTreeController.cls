public class KnowledgeTreeController {

    @AuraEnabled(cacheable=true)
    public static String getTreeView(){
        Map<String, List<String>> picklistMap = PicklistHelper.getDependentMap(new Knowledge__c(), 
                                                                               'Group_Category__c',
                                                                               'Article_Category__c');
        List<Knowledge__c> kbs = getHighlightedKnowledgeArticle();
        Set<String> articleTypes = new Set<String>();
        for (Knowledge__c kb : kbs) {
            articleTypes.add(kb.Article_Category__c);
        }

        List<TreeWrapper> jsonArr = new List<TreeWrapper>();
        for(String groupCategory : picklistMap.keySet()){
            TreeWrapper tWrapper = new TreeWrapper();
            tWrapper.label = groupCategory;
            tWrapper.name = groupCategory;
            tWrapper.expanded = true;
            tWrapper.selected = false;
            tWrapper.items = new List<Item>();
            
            for(String articleType : picklistMap.get(groupCategory)){
                Item itemObj = new Item();
                itemObj.label = articleType;
                itemObj.name = articleType;
                itemObj.expanded = false;
                itemObj.selected = false;
                if (articleTypes.contains(articleType)) {
                    itemObj.isHighlighted = true;
                } else {
                    itemObj.isHighlighted = false;
                }
                
                tWrapper.items.add(itemObj);
            }
            jsonArr.add(tWrapper);
        }
        String jsonBody = JSON.serializePretty(jsonArr);
        return jsonBody;
    }

    @AuraEnabled(cacheable=true)
    public static List<Knowledge__c> getHighlightedKnowledgeArticle(){
        List<Knowledge__c> kbRecords = [SELECT Id, Name, CreatedDate, Title__c, Group_Category__c, Article_Category__c, Content__c, Summary__c, Published__c, Video_Url__c, Select_Profile__c, Highlight__c
            FROM Knowledge__c WHERE Highlight__c = true];
        // Set<String> artTypes = new Set<String>();
        // for (Knowledge__c kb : kbRecords) {
        //     artTypes.add(kb.Article_Category__c);
        // }
        return kbRecords;
    }

    @AuraEnabled(cacheable=true)
    public static Knowledge__c getArticleByArticleId(String articleId) {
        Id profileId= userinfo.getProfileId();
        String profileName=[Select Id,Name from Profile where Id=:profileId].Name;
        Knowledge__c kb = [SELECT Id, Name, CreatedDate, Title__c, Group_Category__c, Article_Category__c, Content__c, Summary__c, Published__c, Select_Profile__c FROM Knowledge__c WHERE Id = :articleId];
        String selectedProfiles  = kb.Select_Profile__c;
        String[] profileNames     = selectedProfiles.split(';');
        if(profileNames.contains(profileName)){
            return kb;
        } else {
            return new Knowledge__c();
        }  
    }

    @AuraEnabled
    public static List<Knowledge__c> getArticlesByArticleCategories(String articleCategory, String groupCategory) {
        Id profileId= userinfo.getProfileId();
        String profileName=[Select Id,Name from Profile where Id=:profileId].Name;
        List<Knowledge__c> kbs = new List<Knowledge__c>();

        for(Knowledge__c kav : [SELECT Id, Name, CreatedDate, Title__c, Group_Category__c, Article_Category__c, Content__c, Summary__c, Published__c, Video_Url__c, Select_Profile__c, Highlight__c
                FROM Knowledge__c 
                WHERE Article_Category__c = :articleCategory AND Group_Category__c =:groupCategory AND Published__c = TRUE
                ORDER BY Article_Category__c]){
            String selectedProfiles = kav.Select_Profile__c;
            if(selectedProfiles != null){
                String[] profileNames = selectedProfiles.split(';');
                if(profileNames.contains(profileName)){
                    kbs.add(kav);
                }
            }
            
        }
        return kbs;
    }

    /**
     * @author : Keykloud
     * @description : method used to get articles by searchText
     */
    @AuraEnabled
    public static Map<String, List<Knowledge__c>> getKnowledgeArticlesBySearch(String searchText) {
        searchText = '%'+searchText+'%';
        Id profileId= userinfo.getProfileId();
        String profileName=[Select Id,Name from Profile where Id=:profileId].Name;
        system.debug('logged-in ProfileName '+profileName);

        Map<String, List<Knowledge__c>> articlesByCategory = new Map<String, List<Knowledge__c>>();
        if (searchText != '' && searchText != null) {
            for(Knowledge__c kav : [SELECT Id, Name, CreatedDate, Title__c, Group_Category__c, Article_Category__c, Content__c, Summary__c, Published__c, Video_Url__c, Select_Profile__c
                                    FROM Knowledge__c 
                                    WHERE (Article_Category__c LIKE :searchText OR Title__c LIKE :searchText) AND Published__c = TRUE 
                                    ORDER BY Article_Category__c]) {
                String selectedProfiles  = kav.Select_Profile__c;
                if(selectedProfiles != null){
                    String[] profileNames = selectedProfiles.split(';');
                    if(profileNames.contains(profileName)){
                        if (articlesByCategory.containsKey(kav.Article_Category__c)) {
                            articlesByCategory.get(kav.Article_Category__c).add(kav);
                        }else {
                            articlesByCategory.put(kav.Article_Category__c, new List<Knowledge__c>{kav});
                        }
                    }
                }
                /*String[] profileNames     = selectedProfiles.split(';');
                if(profileNames.contains(profileName)){
                    if (articlesByCategory.containsKey(kav.Article_Category__c)) {
                        articlesByCategory.get(kav.Article_Category__c).add(kav);
                    }else {
                        articlesByCategory.put(kav.Article_Category__c, new List<Knowledge__c>{kav});
                    }
                }*/
            }
        }
        //List<Knowledge__c> knowledgeArticlesList = new List<Knowledge__c>();
        return articlesByCategory;
    }
    
    public class TreeWrapper{
        public String label;
        public String name;
        public Boolean expanded;
        public Boolean selected;
        public List<Item> items = new List<Item>();
    }
    
    public class Item {
        public String label;
        public String name;
        public Boolean expanded;
        public Boolean selected;
        public Boolean isHighlighted;
    }

}