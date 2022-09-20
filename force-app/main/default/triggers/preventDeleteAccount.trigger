trigger preventDeleteAccount on Account (before delete) {

    List<Account> aList  = new List<Account>();
    Set<id> idList =  new Set<id>();
    for(Account acc : Trigger.old){
        idList.add(acc.Id);
    }
    
    Map<Id, Account> accts = new Map<Id, Account>([Select Id, (Select Id from contacts) from Account where id IN : idList]);
    
    for(Account acc : Trigger.old)
    {
        if(accts.get(acc.Id).contacts.size() >=4)
        {
            acc.addError('Account cannot be deleted as it has atleast 4 related Contacts');
        } 
    }
}