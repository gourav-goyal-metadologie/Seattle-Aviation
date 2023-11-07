({
    setupDataTable: function (component) {
        component.set('v.columns', [
            {label: 'Part Number', fieldName: 'Name', hideDefaultActions: true,  type: 'text'},
            {label: 'Keyword', fieldName: 'inscor__Keyword__c', type: 'text', hideDefaultActions: true, initialWidth: 120},
            {label: 'Description', fieldName: 'inscor__Description__c', type: 'text', hideDefaultActions: true},
        ]);
            },
            
            getData: function (component) {
            return this.callAction(component)
            .then(
            $A.getCallback(salesRecords => {
            component.set('v.allData', salesRecords);
            component.set('v.filteredData', salesRecords);
            this.preparePagination(component, salesRecords);
            })
            )
            .catch(
            $A.getCallback(errors => {
            if (errors && errors.length > 0) {
            $A.get("e.force:showToast")
            .setParams({
            message: errors[0].message != null ? errors[0].message : errors[0],
                      type: "error"
                      })
        .fire();
    }
})
);
},
    
    callAction: function (component) {
        component.set("v.isLoading", true);
        return new Promise(
        $A.getCallback((resolve, reject) => {
            const action = component.get("c.getunUsedInventory");
            action.setParams({
        });
        action.setCallback(this, response => {
        component.set("v.isLoading", false);
        debugger;
        const state = response.getState();
        if (state === "SUCCESS") {
            var records =response.getReturnValue();
            return resolve(response.getReturnValue());
        } else if (state === "ERROR") {
            return reject(response.getError());
        }
        return null;
    });
$A.enqueueAction(action);
})
);
},
    
    preparePagination: function (component, salesRecords) {
        let countTotalPage = Math.ceil(salesRecords.length/component.get("v.pageSize"));
        let totalPage = countTotalPage > 0 ? countTotalPage : 1;
        component.set("v.totalPages", totalPage);
        component.set("v.currentPageNumber", 1);
        this.setPageDataAsPerPagination(component);
    },
        
        setPageDataAsPerPagination: function(component) {
            let data = [];
            let pageNumber = component.get("v.currentPageNumber");
            let pageSize = component.get("v.pageSize");
            let filteredData = component.get('v.filteredData');
            let x = (pageNumber - 1) * pageSize;
            for (; x < (pageNumber) * pageSize; x++){
                if (filteredData[x]) {
                    data.push(filteredData[x]);
                }
            }
            component.set("v.tableData", data);
            
        },
            
            searchRecordsBySearchPhrase : function (component) {
                let searchPhrase = component.get("v.searchPhrase");
                if (!$A.util.isEmpty(searchPhrase)) {
                    let allData = component.get("v.allData");
                    let filteredData = allData.filter(record => record.title.includes(searchPhrase));
                    component.set("v.filteredData", filteredData);
                    this.preparePagination(component, filteredData);
                }
            },
                
                helperHandleRowSelection : function (component, event, helper) {
                    var selectedRows = event.getParam('selectedRows');
                    var selectedProducts = [];
                    for(var i=0; i<selectedRows.length; i++) {
                        selectedProducts.push({
                            'Id' : selectedRows[i].Id,
                            'Name' : selectedRows[i].Name,
                            'inscor__Keyword__c' : selectedRows[i].inscor__Keyword__c
                        });
                    }
                    component.set('v.selectedRows', selectedProducts);
                },
                    
                    helperHandleSelectedDelete : function (component, event, helper) {
                        var selectedRows = component.get('v.selectedRows');
                        console.log('helperHandleSelectedDelete >>'+JSON.stringify(selectedRows));
                        var action = component.get("c.deleteSelectedInventory");
                        action.setParams({
                            "selectedRows" : JSON.stringify(selectedRows)
                        });
                        action.setCallback(this,function(response) {
                            var state = response.getState();
                            console.log(state);
                            if (state === "SUCCESS") {
                                $A.get('e.force:refreshView').fire();
                            }else{
                                console.log(state);
                            }
                        });
                        $A.enqueueAction(action);
                        //Call apex and perform delete statement here and send selectedRows in the parameters
                    }
})