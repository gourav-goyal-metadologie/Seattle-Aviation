@IsTest
private class KnowledgeTreeControllerTest {
    @TestSetup
    static void setupData(){
        List<String> profiles = new list<String> { 'Analytics Cloud Integration User','Analytics Cloud Security User','B2BMA Integration User',
                                                    'Chatter External User','Chatter Free User','Chatter Moderator User','Contract Manager',
                                                    'Customer Community Plus Login User','Custom Test Profile','Identity User','Marketing User',
                                                    'Minimum Access - Salesforce','Partner Community User','SalesforceIQ Integration User',
                                                    'Sales Insights Integration User','SAS - Finance User','SAS - Operation User',
                                                    'SAS - Purchasing User','SAS-Shipping User','SAS Standard User','Solution Manager',
                                                    'Standard Platform User','Standard User','System Admin Clone','System Administrator'};
        Knowledge__c knowledge= new Knowledge__c(
            Title__c = 'Mobile Technician', 
            Group_Category__c = 'Work Orders', 
            Article_Category__c = 'Work Order Setup', 
            Content__c = 'Content goes here', 
            Summary__c = 'This article will cover the basics of using Mobile Technician within AvSight Work Orders.', 
            Published__c = true,
            Select_Profile__c = String.join(profiles,';')
        );
        insert knowledge;
    }
    
    @IsTest
    static void getTreeViewTest(){
        
        Test.startTest();
        KnowledgeTreeController.getTreeView();
        Test.stopTest();
        
    }

    @IsTest
    static void getArticleByArticleIdTest(){
        
        Knowledge__c knowledge = [SELECT Id FROM Knowledge__c];
        Test.startTest();
        Knowledge__c result = KnowledgeTreeController.getArticleByArticleId(knowledge.Id);
        Test.stopTest();
        System.assertEquals(result.Id, knowledge.Id);
        
    }

    @IsTest
    static void getArticlesByArticleCategoriesTest(){
        
        Knowledge__c knowledge = [SELECT Id, Group_Category__c, Article_Category__c FROM Knowledge__c];
        Test.startTest();
        List<Knowledge__c> result = KnowledgeTreeController.getArticlesByArticleCategories(knowledge.Article_Category__c, knowledge.Group_Category__c);
        Test.stopTest();
        System.assertEquals(result[0].Group_Category__c, knowledge.Group_Category__c);
        
    }

    @IsTest
    static void methodName(){
        
        Knowledge__c knowledge = [SELECT Id, Content__c FROM Knowledge__c];
        Test.startTest();
        Map<String, List<Knowledge__c>> result = KnowledgeTreeController.getKnowledgeArticlesBySearch('Mobile Technician');
        Test.stopTest();
        System.assertEquals(result.get('Work Order Setup')[0].Content__c, knowledge.Content__c);
    }
}