({
	doInit : function(component, event, helper) {
		helper.doInit(component, event, helper);
	},
	
	getCustomerLines : function(component, event, helper){
	    helper.getCustomerLines(component, event, helper);
	},
	
	handleNext : function(component, event, helper) { 
	    component.set("v.spinner",true);
        var pageNumber = component.get("v.pageNumber");
        component.set("v.pageNumber", pageNumber+1);
        helper.getCustomerLines(component, event, helper);
    },
     
    handlePrev : function(component, event, helper) {       
        component.set("v.spinner",true);
        var pageNumber = component.get("v.pageNumber");
        component.set("v.pageNumber", pageNumber-1);
        helper.getCustomerLines(component, event, helper);
    },
})