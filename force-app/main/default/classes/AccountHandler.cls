public class AccountHandler {

    public static Account insertNewAccount(string accountname)
    {
     	Account act = new Account(Name= accountName,AccountNumber='BC123456');
        
        try{
            insert act;
            return act;
        } catch(DMLException e)
        {
            System.debug('Error Message ' + e.getMessage());
            return null;
        }
    }
}