public class AccountManager {

    @AuraEnabled
    public static List<Account> fetchAccounts(){
        return [Select Id, Name from Account Limit 20];
    }
}