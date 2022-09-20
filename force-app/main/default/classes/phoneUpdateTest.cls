@isTest
public class phoneUpdateTest {

    @isTest
    public static void updateTest()
    {
        Account a = new Account(Name='Dummy', AccountNumber = '12345678', Phone = '7894561230');
        insert a;
        List<Contact> cList = new List<Contact>();
        Contact c = new Contact(LastName= a.Name, MobilePhone = a.Phone);
        cList.add(c);
        insert cList;
        
        List<Contact> listContact = [Select LastName, MobilePhone from Contact where AccountId = :a.Id];
        System.assertEquals(1, listContact.size(), 'msg');
    }
}