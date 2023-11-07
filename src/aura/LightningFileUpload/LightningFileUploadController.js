({
    doInit : function(component, event, helper){  
        
        var sPageURL = decodeURIComponent(window.location.search.substring(1));
        var sURLVariables = sPageURL.split('&');
        var sParameterName;
        var i;
        
        for (i = 0; i < sURLVariables.length; i++) {
            sParameterName = sURLVariables[i].split('=');
            if (sParameterName[0] === 'param') {
                sParameterName[1] === undefined ? 'Not found' : sParameterName[1];
            }
        }
        console.log('Param name '+sParameterName[0]);
        console.log('Param value '+sParameterName[1]);
        
        component.set('v.guid', sParameterName[1]);
        
        helper.getUploadedFiles(component, event);
    },      
    
    previewFile : function(component, event, helper) {
        var selectedRecordIndex = event.currentTarget.id;
        var files = component.get('v.files');
        var fileUrl;
        var fileTitle;
        for(var i=0; i<files.length; i++){
            if(i == selectedRecordIndex){
                fileUrl = files[i].Description;
                fileTitle = files[i].Title;
            }
        }
        console.log(fileUrl);
        component.set('v.showPopup', true);
        component.set('v.fileTitle', fileTitle);
        component.set('v.fileUrl', fileUrl);
    },
    downloadFile : function(component, event, helper) {
        
        var selectedRecordIndex = event.currentTarget.id;
        var files = component.get('v.files');
        var fileUrl;
        var fileTitle;
        for(var i=0; i<files.length; i++){
            if(i == selectedRecordIndex){
                fileUrl = files[i].Description;
                fileTitle = files[i].Title;
            }
        }
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": fileUrl,
            "target":"_blank"
        });
        urlEvent.fire();
    },
    
    hideFilePreview : function(component, event, helper){
        component.set('v.showPopup', false);
    }
})