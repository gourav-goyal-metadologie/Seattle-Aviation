public class EmailBody
{
    @AuraEnabled public String HtmlBody;
    @AuraEnabled public String TextBody;
    @AuraEnabled public String Subject;

    public EmailBody(Messaging.SingleEmailMessage msg)
    {
        this.HtmlBody = msg.getHtmlBody();
        this.TextBody = msg.getPlainTextBody();
        this.Subject = msg.getSubject();
    }
}