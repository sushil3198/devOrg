public class createArecord {

    public static void createRecord()
    {
        Account a = new Account();
        Database.insert(a,false);
    }
}