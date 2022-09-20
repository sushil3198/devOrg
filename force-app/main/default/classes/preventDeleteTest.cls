@isTest
public class preventDeleteTest {

    @isTest
    public static void accountDeletion()
    {
        Account acc = new Account(Name='Dummy Acc', AccountNumber = '12345678');
        insert acc;
        List<Contact> cList = new List<Contact>();
        for(Integer i = 1; i<=4; i++)
        {
            Contact c = new Contact(LastName = acc + ' ' + i, AccountId = acc.Id);
            cList.add(c);
        } insert cList;
        
        Test.startTest();
        Database.DeleteResult result = Database.delete(acc, false);
        Test.stopTest();
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size()>0);
       System.assertEquals('Account cannot be deleted as it has atleast 4 related Contacts', result.getErrors()[0].getMessage());
    }
}