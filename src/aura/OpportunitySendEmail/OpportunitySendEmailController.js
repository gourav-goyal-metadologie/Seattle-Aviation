({
    init: function(component, event, helper) {
       // component.set('v.myVal', '<p><script>alert(this)</script></p><p>hi!</p>');
       helper.getEmailHtmlBody(component, event, helper);
    },
    saveClick: function(component, event, helper) {
       // component.set('v.myVal', '<p><script>alert(this)</script></p><p>hi!</p>');
       helper.SendEmail(component, event, helper);
    }
})