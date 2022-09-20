public with sharing class GetRecordClass {

    @AuraEnabled
    public static List<Account> getPaginateAllRecords()
    {
        List<Account> aList = [Select Id, Name from Account];
        return aList;
    }
}