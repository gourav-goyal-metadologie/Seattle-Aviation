@isTest
public class slack_tst_Sales_Order {
	@isTest 
	static void testTrigger() {
		Account obj1 = new Account(
			Name = 's'
		);
		insert obj1;

		inscor__Sales_Order__c obj0 = new inscor__Sales_Order__c(
			inscor__Customer__c = obj1.Id
		);
		insert obj0;
	}
}