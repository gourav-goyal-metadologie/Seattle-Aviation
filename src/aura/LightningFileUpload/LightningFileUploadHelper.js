({
	getUploadedFiles : function(component, event){
        component.set('v.showSpinner', true);
        var action = component.get("c.getFiles");  
        action.setParams({  
            "guid": component.get("v.guid")
        });      
        action.setCallback(this,function(response){  
            var state = response.getState();  
            if(state=='SUCCESS'){  
                component.set('v.showSpinner', false);
                var result = response.getReturnValue();  
                console.log(result);
                component.set("v.files",result);  
            }  
        });  
        $A.enqueueAction(action);  
    }
})