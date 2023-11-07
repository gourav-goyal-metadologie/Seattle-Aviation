({
	setCustomerStatus : function(cmp,event,helper) {
        
        var action = cmp.get("c.convertLeadtoCustomer");
        action.setParams({ recordId : cmp.get("v.recordId")});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let returnResponse = response.getReturnValue();
                console.log(response.getReturnValue());
                if(returnResponse !=  ''){
                    if (returnResponse.includes('email')) {
                        this.showError(cmp,event,helper,'Error',returnResponse);
                    }else{
                        this.showSuccess(cmp,event,helper,'Success',returnResponse);
                    }
                    $A.get("e.force:closeQuickAction").fire();
                }
                setTimeout(() => {
                    $A.get('e.force:refreshView').fire();
                }, 100);
                //cmp.set('v.myVal', response.getReturnValue().HtmlValue);
            }
            else if (state === "INCOMPLETE") {
            }
            else if (state === "ERROR") {
                let errorMessage = 'Unknown Error';
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        //this.showError(cmp,event,helper,'Error', errors[0].message);
                        errorMessage = errors[0].message;
                        console.log("Error message: " + 
                                    errors[0].message);
                    } else if (errors[0] && errors[0].pageErrors[0] && errors[0].pageErrors[0].message) {
                        errorMessage = errors[0].pageErrors[0].message;
                        console.log('Error message: ' + errors[0].pageErrors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
                this.showError(cmp,event,helper,'Error', errorMessage);
                $A.get("e.force:closeQuickAction").fire();
                setTimeout(() => {
                    $A.get('e.force:refreshView').fire();
                }, 100);
            }
        });
        
        // optionally set storable, abortable, background flag here
        
        // A client-side action could cause multiple events, 
        // which could trigger other events and 
        // other server-side action calls.
        // $A.enqueueAction adds the server-side action to the queue.
        $A.enqueueAction(action);
    },
    showSuccess : function(component, event, helper,title,message) {
        console.log('Test');
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": title,
            "message": message,
            "type" : 'Success'
        });
        toastEvent.fire();
    },

    showError : function(component, event, helper,title,message) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": title,
            "message": message,
            "type" : 'error'
        });
        toastEvent.fire();
    },

    
    
    
})