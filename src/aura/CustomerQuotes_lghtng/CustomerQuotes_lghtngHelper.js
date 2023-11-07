({
	setupDataTable: function (component) {
        component.set('v.columns', [
            {label: 'Part Number', fieldName: 'linkURL', hideDefaultActions: true,  type: 'url', typeAttributes: { label:{ fieldName: 'linkName'}, target: '_blank', tooltip: { fieldName: 'linkName' }}},
            {label: 'QTY', fieldName: 'Qty', type: 'Number', hideDefaultActions: true, initialWidth: 40},
            {label: 'Last 365 Days', fieldName: 'last365', type: 'Number', hideDefaultActions: true},
            {label: 'All time', fieldName: 'allTime', type: 'Number', hideDefaultActions: true},
        ]);
    },
    
    getCustomerQuotes : function(component, event, helper) {
        var action = component.get("c.getCustomerQuotes");
        action.setParams({
            "accountId": component.get("v.recordId")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
            var records =response.getReturnValue();
            records.forEach(function(record){
            record.linkURL = '/'+record.partId;
            record.linkName = record.partName;
            });
                component.set("v.tableData", records);
            }
        });
        $A.enqueueAction(action);
        
    }        
})