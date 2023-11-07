public class OpportunitySendEmailCtrl {

    @AuraEnabled
    public static string sendOpportunityEmail(String recId,String body, String emailIds, String Subject){
        List<EmailTemplate> emailTemplateRec = [Select Id,Subject,Body,HtmlValue from EmailTemplate where DeveloperName = 'Opportunity_Send_Email'];
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        List<Opportunity> oppRec = [Select Id,accountId from Opportunity where Id =:recId ];
        
        if(emailTemplateRec.size() > 0){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        	mail.setSubject(Subject != null ? Subject : emailTemplateRec[0].Subject);
			mail.setHtmlBody(body);
            string[] splittedemail = emailIds.split(',');
            mail.setToAddresses(splittedemail);  
            emails.add(mail);
            
            Messaging.sendEmail(emails);      
        }
        
        return 'Sucess';
    }
    @AuraEnabled
    public static EmailTemplate getEmailBody(){
        List<EmailTemplate> emailTemplateRec = [Select Id,Subject,Body,HtmlValue from EmailTemplate where DeveloperName = 'Opportunity_Send_Email'];
        if(emailTemplateRec.size() > 0){
            return emailTemplateRec[0];
        }
        
        return new EmailTemplate();
    }
}