public  without sharing class LightningFileUploadController {
    
    @AuraEnabled  
    public static List<ContentDocumentWrapper> getFiles(String guid) {
        try {                
            List<inscor__Release__c> releaseWithReleaseLines = [ SELECT Id, Name, 
                                                               ( SELECT Id, Name, 
                                                                inscor__Allocation__r.inscor__Inventory_Line__r.Name,
                                                                inscor__Allocation__r.inscor__Inventory_Line__r.Id,
                                                                inscor__Allocation__r.inscor__Inventory_Line__r.inscor__Product__r.Name
                                                                FROM inscor__Release_Lines__r ) 
                                                                FROM inscor__Release__c 
                                                              WHERE GUID__c = :guid ];
            Set<String> inventoryLineIds = new Set<String>();
            map<String, String> mapInventoryIdToPartNumber = new map<String, String>();
            for(  inscor__Release__c release : releaseWithReleaseLines ){
                
                for( inscor__Release_Line__c rLine : release.inscor__Release_Lines__r ){
                    if( rLine.inscor__Allocation__r.inscor__Inventory_Line__r.Id != null ){
                        inventoryLineIds.add( rLine.inscor__Allocation__r.inscor__Inventory_Line__r.Id );
                        mapInventoryIdToPartNumber.put( rLine.inscor__Allocation__r.inscor__Inventory_Line__r.Id,
                                                       rLine.inscor__Allocation__r.inscor__Inventory_Line__r.inscor__Product__r.Name );
                    }
                }                
            }
            
            List<ContentDocumentLink> cdlList = [ SELECT Id, LinkedEntityId, ContentDocumentId,
                                                 ContentDocument.Title, ContentDocument.Description, ContentDocument.FileType, 
                                                 ContentDocument.Id 
                                                 FROM ContentDocumentLink 
                                                 WHERE LinkedEntityId IN :inventoryLineIds
                                                 AND ContentDocument.FileType ='PDF'];
            
            Map<String, List<ContentDocumentLink>> mapLinkEntityIdToListCDLink = new Map<String, List<ContentDocumentLink>>();
            Map<String, ContentDocumentLink> mapContentDocIdToContentDocumentLink = new Map<String, ContentDocumentLink>();
            List<Id> contentDocumentIds = new List<Id>();
            for (ContentDocumentLink cdl : cdlList) {
                contentDocumentIds.add(cdl.ContentDocumentId);
                mapContentDocIdToContentDocumentLink.put( cdl.ContentDocumentId, cdl );
                if( mapLinkEntityIdToListCDLink.containsKey( cdl.LinkedEntityId ) ){
                    List<ContentDocumentLink> links =  mapLinkEntityIdToListCDLink.get( cdl.LinkedEntityId );
                    links.add( cdl );
                    mapLinkEntityIdToListCDLink.put( cdl.LinkedEntityId, links );
                }else{
                    List<ContentDocumentLink> links =  new List<ContentDocumentLink>();
                    links.add( cdl );
                    mapLinkEntityIdToListCDLink.put( cdl.LinkedEntityId, links );
                }
            }
            
            List<ContentVersion> cvList = [SELECT ContentDocumentId 
                                           FROM ContentVersion 
                                           WHERE ContentDocumentId IN :contentDocumentIds];
            
            ContentDistribution[] distributionsToInsert = new List<ContentDistribution>();
            Set<Id> cvDocumentLinkIds = new Set<Id>();
            for(ContentVersion cv : cvList){
                cvDocumentLinkIds.add(cv.ContentDocumentId);
                distributionsToInsert.add(createContentDistribution(cv.Id));    
            }  
            
            if(!distributionsToInsert.isEmpty()){
                //insert distributionsToInsert;
            }
            
            List<ContentDocument> cdList = [SELECT Id, Title, FileType, Description 
                                            FROM ContentDocument 
                                            WHERE Id IN :cvDocumentLinkIds];
            
            
            set<Id> contentDocuemntIds = new set<Id>();
            Set<String> uniqueContentDocument = new Set<String>();
            
            
            List<ContentDocumentWrapper> uniqueContentDocuments = new List<ContentDocumentWrapper>();
            for(ContentDocument cd : cdList){
                if( cd.Title != null && !uniqueContentDocument.contains( cd.Id + '_' + cd.Title ) ){
                    contentDocuemntIds.add( cd.Id );
                    uniqueContentDocument.add( cd.Id + '_' + cd.Title );
                    String Title ='';
                    if( mapContentDocIdToContentDocumentLink.size() > 0 && mapContentDocIdToContentDocumentLink.containsKey( cd.Id ) ){
                        
                        String linkedEntityId =   mapContentDocIdToContentDocumentLink.get( cd.Id ).LinkedEntityId;
                        if( mapLinkEntityIdToListCDLink.size() > 0 && mapLinkEntityIdToListCDLink.containsKey( linkedEntityId ) ){
                            
                            Boolean hasMoreThanOneFiles = mapLinkEntityIdToListCDLink.get( linkedEntityId ).size() > 1 ? true : false;
                            Integer counter = 1;
                            for( ContentDocumentLink cdl : mapLinkEntityIdToListCDLink.get( linkedEntityId ) ){
                                
                                String partNumber;
                                if( mapInventoryIdToPartNumber.size() > 0 && mapInventoryIdToPartNumber.containsKey( linkedEntityId ) ){
                                    partNumber = mapInventoryIdToPartNumber.get( linkedEntityId );
                                }
                                String titleString = hasMoreThanOneFiles ? partNumber  : partNumber;
                                String lineNumber = ' Line ' + counter;
                                uniqueContentDocuments.add( new ContentDocumentWrapper( cdl.ContentDocumentId, 
                                                                                       titleString,
                                                                                       cdl.ContentDocument.FileType, 
                                                                                       cdl.ContentDocument.Description,
                                                                                       lineNumber
                                                                                      ) );
                                mapContentDocIdToContentDocumentLink.remove( cdl.ContentDocumentId );
                                counter++;
                            }
                            mapLinkEntityIdToListCDLink.remove( linkedEntityId );
                        }
                    }
                }
            }
            Map<String, ContentDistribution> mapContentDocIdToContenDistribution = new Map<String, ContentDistribution>();
            for( ContentDistribution cdr: [ SELECT ContentDocumentId, DistributionPublicUrl  
                                           FROM ContentDistribution  
                                           WHERE ContentDocumentId IN :contentDocuemntIds ]){
                mapContentDocIdToContenDistribution.put( cdr.ContentDocumentId, cdr );
            }
            
            for(ContentDocumentWrapper cd : uniqueContentDocuments ){
                if(mapContentDocIdToContenDistribution.size() > 0 && mapContentDocIdToContenDistribution.containsKey( cd.Id ) ){
                    cd.Description = mapContentDocIdToContenDistribution.get( cd.Id ).DistributionPublicUrl;
                }
            }
            return uniqueContentDocuments;
        } catch (Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }  
        
    }
    
    
    public static ContentDistribution createContentDistribution(Id contentVersionId){
        ContentDistribution newDist = new ContentDistribution();
        newDist.ContentVersionId = contentVersionId;
        newDist.Name = 'External Link';
        newDist.PreferencesNotifyOnVisit = false;
        newDist.PreferencesAllowViewInBrowser = true;
        newDist.PreferencesAllowOriginalDownload=true;
        system.debug('createContentDistribution creted');
        return newDist;
    }
    
    public class ContentDocumentWrapper{
        @AuraEnabled public String Id;
        @AuraEnabled public String Title;
         @AuraEnabled public String LineNumber;
        @AuraEnabled public String FileType;
        @AuraEnabled public String Description;
        
        public ContentDocumentWrapper(Id Id, String Title, String FileType, String Description, String LineNumber  ){
            
            this.Id = Id;
            this.Title = Title;
            this.LineNumber = LineNumber;
            this.FileType = FileType;
            this.Description = Description;
        }
        
    }
}