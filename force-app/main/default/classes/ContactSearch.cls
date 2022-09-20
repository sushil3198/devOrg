public class ContactSearch {

    public static List<Contact> searchForContacts(String lName, String pCode)
    {
        List<Contact> foundList = new List<Contact>();
        foundList = [Select Id, LastName 
                     from Contact 
                     WHERE 
                     LastName = :lName AND MailingPostalCode = :pCode];
        return foundList;
    }
}