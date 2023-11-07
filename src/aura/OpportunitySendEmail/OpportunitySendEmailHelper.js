({
    getEmailHtmlBody : function(cmp,event,helper) {
        
        var action = cmp.get("c.getEmailBody");
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log(response.getReturnValue());
                cmp.set('v.myVal', response.getReturnValue().HtmlValue);
            }
            else if (state === "INCOMPLETE") {
            }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " + 
                                        errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }
        });
        
        // optionally set storable, abortable, background flag here
        
        // A client-side action could cause multiple events, 
        // which could trigger other events and 
        // other server-side action calls.
        // $A.enqueueAction adds the server-side action to the queue.
        $A.enqueueAction(action);
    },
    SendEmail : function(cmp,event,helper) {
        console.log(cmp.get("v.emailIds"));
        if((cmp.get("v.emailIds") != '' && cmp.get("v.emailIds") != undefined)  || (cmp.get("v.subject") != '' && cmp.get("v.subject") != undefined)){
            var action = cmp.get("c.sendOpportunityEmail");
            action.setParams({ recId : cmp.get("v.recordId"),
                              body : cmp.get("v.myVal"),
                              emailIds : cmp.get("v.emailIds"),
                              Subject : cmp.get("v.subject")});
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    console.log(response.getReturnValue());
                    $A.get("e.force:closeQuickAction").fire();
                    //cmp.set('v.myVal', response.getReturnValue().HtmlValue);
                }
                else if (state === "INCOMPLETE") {
                }
                    else if (state === "ERROR") {
                        var errors = response.getError();
                        if (errors) {
                            if (errors[0] && errors[0].message) {
                                console.log("Error message: " + 
                                            errors[0].message);
                            }
                        } else {
                            console.log("Unknown error");
                        }
                    }
            });
            
            $A.enqueueAction(action);
        }
        else{
            this.showError(cmp, event, helper,'Error','Populate all required Values');
        }
    },
    showError : function(component, event, helper,title,message) {
        console.log('Test');
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": title,
            "message": message,
            "type" : 'error'
        });
        toastEvent.fire();
        console.log('Test');
    }
    
})