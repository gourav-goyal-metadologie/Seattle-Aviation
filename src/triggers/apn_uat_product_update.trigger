trigger apn_uat_product_update on Product2 (after insert, after update, after delete) {
    try{
	    if(!System.isFuture() && !System.isBatch() && !Test.isRunningTest()) {
			String url = 'http://3.91.231.215:8080/trigger/product/crud/COMPANY_6dcbf1f7-fec6-47af-b50b-ac452f2c7953';
			String content = Webhook.jsonContent(Trigger.new, Trigger.old);
			Webhook.callout(url, content);
 		}      
    }
    catch (Exception e){
        System.debug('Exception in apn_uat_product_update: ' + e);
    }
        
}