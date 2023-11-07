({
	doInit : function(component, event, helper) {
// 	    component.set('v.columns', [
//             // {label: 'Part Number', fieldName: 'inscor__Customer_Part_Number__r.Name', type: 'text'},
//             { label: 'Part Number', fieldName: 'partId', type: 'url', typeAttributes: {label: { fieldName: 'partName' }, target: '_blank'}},
//             {label: 'Business Category', fieldName: 'inscor__Business_Category__c', type: 'text'},
//             {label: 'Quantity', fieldName: 'inscor__Quantity__c', type: 'Number'}
//         ]);
// 		var action = component.get("c.getCustomerQuotesLineItem");
// 		console.log(component.get("v.recordId"));
// 		action.setParams({
//             "recordId" : component.get("v.recordId")
//         });
//         action.setCallback(this,function(response) {
//             var state = response.getState();
//             if(state === "SUCCESS"){
//                 console.log(response.getReturnValue());
//                 var resultData = response.getReturnValue();
//                 component.set("v.dataSize", resultData.length);
//                 for(var i=0;i<resultData.length;i++){
//                     resultData[i].partId = '/'+resultData[i].inscor__Product__c;
//                     resultData[i].partName = resultData[i].inscor__Product__r.Name;
//                 }
//                 component.set("v.data", resultData);
//                 if(resultData.length < component.get("v.pageSize")){
//                     component.set("v.isLastPage", true);
//                 } else{
//                     component.set("v.isLastPage", false);
//                 }
//             }else{
//                 console.log("Something Went Wrong!");
//             }
//         });
//         $A.enqueueAction(action);
        helper.getCustomerLines(component, event, helper);
        helper.getColumns(component, event, helper);
	},
	
	getColumns : function(component, event, helper) {
	    component.set('v.columns', [
            { label: 'Part Number', fieldName: 'partId', type: 'url', typeAttributes: {label: { fieldName: 'partName' }, target: '_blank'}},
            {label: 'Business Category', fieldName: 'inscor__Business_Category__c', type: 'text'},
            {label: 'Quantity', fieldName: 'inscor__Quantity__c', type: 'Number'}
        ]);
	},
	
	getCustomerLines : function(component, event, helper) {
	    component.set("v.spinner",true);
        var action = component.get("c.getCustomerQuotesLineItem");
        var pageSize = component.get("v.pageSize").toString();
        var pageNumber = component.get("v.pageNumber").toString();
        
        action.setParams({
            "pageSize" : pageSize,
            "pageNumber" : pageNumber,
            "recordId" : component.get("v.recordId"),
            "searchKey" : component.get("v.searchKey")
        });
        action.setCallback(this,function(response) {
            var state = response.getState();
            console.log(state);
            if (state === "SUCCESS") {
                var resultData = response.getReturnValue();
 
                for(var i=0;i<resultData.length;i++){
                    resultData[i].partId = '/'+resultData[i].inscor__Product__c;
                    resultData[i].partName = resultData[i].inscor__Product__r.Name;
                }
                
                if(resultData.length < component.get("v.pageSize")){
                    component.set("v.isLastPage", true);
                } else{
                    component.set("v.isLastPage", false);
                }
                component.set("v.dataSize", resultData.length);
                component.set("v.data", resultData);
                console.log(resultData);
                component.set("v.spinner",false);
            }else{
                console.log(state);
            }
        });
        $A.enqueueAction(action);
	    
	}
})