({
    setupDataTable: function (component) {
        component.set('v.columns', [
            {label: 'Part Number', fieldName: 'linkURL', hideDefaultActions: true,  type: 'url', typeAttributes: { label:{ fieldName: 'linkName'}, target: '_blank', tooltip: { fieldName: 'linkName' }},},
            {label: 'QTY', fieldName: 'Qty', type: 'Number', hideDefaultActions: true, initialWidth: 34},
            {label: 'Last 365 Days', fieldName: 'last365', type: 'Number', hideDefaultActions: true},
            {label: 'All time', fieldName: 'allTime', type: 'Number', hideDefaultActions: true},
        ]);
    },
    
    getData: function (component) {
        return this.callAction(component)
        .then(
            $A.getCallback(customerQuotesRecords => {
                component.set('v.allData', customerQuotesRecords);
                component.set('v.filteredData', customerQuotesRecords);
                this.preparePagination(component, customerQuotesRecords);
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
                const action = component.get("c.getCustomerQuotesLineItem");
                action.setParams({
                "accountId": component.get("v.recordId")
            });
            action.setCallback(this, response => {
            component.set("v.isLoading", false);
        const state = response.getState();
        if (state === "SUCCESS") {
            var records =response.getReturnValue();
            records.forEach(function(record){
                record.linkURL = '/'+record.partId;
                record.linkName = record.partName;
            });
            
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
    
    preparePagination: function (component, records) {
        let countTotalPage = Math.ceil(records.length/component.get("v.pageSize"));
        let totalPage = countTotalPage > 0 ? countTotalPage : 1;
        component.set("v.totalPages", totalPage);
        component.set("v.currentPageNumber", 1);
        this.setPageDataAsPerPagination(component);
        debugger;
        if (records.length > 10) {
            var dataDiv = component.find("tableDataDiv");
            $A.util.addClass(dataDiv, 'greaterThan10Items');
        }else{
            var dataDiv = component.find("tableDataDiv");
            $A.util.addClass(dataDiv, 'lessThan10Items');
        }
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
})