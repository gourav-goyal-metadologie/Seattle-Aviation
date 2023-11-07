/**************************************************************************************************
Description:  class for LightningFileUploadController that will handle all types of events Test Methods.
====================================================================================================
====================================================================================================
Class: LightningFileUploadControllerTest
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		08/03/2021		    Gourav Goyal				Initial Creation     
***************************************************************************************************/
@isTest( seeAllData = true )
private class LightningFileUploadControllerTest {

    public static final Integer COUNT_LIMIT = 10;
	
    @isTest
    private static void sendEmailOnReleaseStatusInvoicedTest() {
        try{
            
            List<inscor__Release__c> inscorList = [SELECT Id, Guid__c from inscor__Release__c LIMIT 1];
            List<inscor__Inventory_Line__c> inventoryList = [SELECT Id, Name from inscor__Inventory_Line__c LIMIT 1];
            
            ContentVersion contentVersion = new ContentVersion(
                Title = 'Penguins',
                PathOnClient = 'Penguins.PDF',
                VersionData = Blob.valueOf('Test Content'),
                IsMajorVersion = true
            );
            insert contentVersion;
            /**Content Insertion */
            List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
            //create ContentDocumentLink  record
            List<ContentDocumentLink> cdlList = new List<ContentDocumentLink>();
            for(inscor__Release__c relRec : inscorList) { 
                ContentDocumentLink cdl = New ContentDocumentLink();
                cdl.LinkedEntityId = inventoryList[0].id;
                cdl.ContentDocumentId = documents[0].Id;
                cdl.shareType = 'V';
                cdlList.add(cdl);
            }
            insert cdlList;
            
            Test.startTest();
            String guid = 'a0Y5Y000-00p0-0tnZ-a0Y5-0000p0tnZUAQ';
            LightningFileUploadController.getFiles(guid);
            Test.stopTest();
        }
        catch(exception e){
            
        }
    }

}