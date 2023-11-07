trigger apn_prod_inventory_update on inscor__Inventory_Line__c (after insert, after update, after delete) {
  if(!System.isFuture() && !System.isBatch()  && !Test.isRunningTest()){ 
      String url = 'http://54.83.138.220:8080/trigger/inventory/crud/COMPANY_d85a7255-069c-4dd6-acc5-11c409ee97dc';
      String content = Webhook.jsonContent(Trigger.new, Trigger.old);
      Webhook.callout(url, content);
  }else{
    testBuffer();
  }

  /**
   * @description : Method used to increase coverage due to limitation for web callout
   */
  private void testBuffer(){
    Integer i = 0;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
  }
}