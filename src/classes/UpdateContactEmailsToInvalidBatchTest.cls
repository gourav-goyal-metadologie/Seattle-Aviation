@IsTest
private class UpdateContactEmailsToInvalidBatchTest {
    @TestSetup
    static void setup() {
        List<Contact> contacts = new List<Contact>();

        Account account = new Account(Name = 'Account');
        insert account;

        for(Integer i = 0; i <= 10; i++){
            contacts.add(new Contact(
                    FirstName = 'first',
                    LastName = 'last',
                    AccountId = account.Id,
                    Email = 'test' + i + '@test.com'
            ));
        }
        insert contacts;
    }

    @IsTest
    static void testQueryConstructor() {
        Test.startTest();
        UpdateContactEmailsToInvalidBatch bca = new UpdateContactEmailsToInvalidBatch('SELECT Id, Email FROM Contact');
        Id batchId = Database.executeBatch(bca);
        Test.stopTest();
    }
}