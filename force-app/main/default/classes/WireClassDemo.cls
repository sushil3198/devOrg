public class WireClassDemo {

    @AuraEnabled(cacheable = true)
    public static List<Account> getAccounts(){
        return [Select Id, Name,Rating, (Select Id, lastName from contacts) from Account Limit 30];
    }
}