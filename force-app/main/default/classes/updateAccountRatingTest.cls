@isTest
public class updateAccountRatingTest {

    @isTest
    public static void ratingTest()
    {
        Account a = new Account(Name='Dummy', AccountNumber='12345678');
        insert a;
        Opportunity op = new Opportunity(Name='Test', StageName='Closed Won', CloseDate = system.today(),Discount_Percent__c = 0, AccountId = a.Id);
        insert op;
        
        Test.startTest();
        System.assertEquals(a.Rating, 'Hot', 'msg');
        System.assert(a.Rating=='Hot');
        Test.stopTest();
    }
}