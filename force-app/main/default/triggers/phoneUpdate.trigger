trigger phoneUpdate on Account (after insert) {
    
    List<Contact> cList = new List<Contact>();
    Set<id> accountId = new Set<id>();
    for(Account a : Trigger.new)
    {
        accountId.add(a.Id);
    }
    
    List<Account> aList = [Select Id,Name,Phone,(Select Id,Phone from Contacts) from Account where Id IN : accountId];
            for(Account acc : aList)
            {
                    Contact c1 = new Contact(LastName=acc.Name, MobilePhone = acc.Phone);
                    cList.add(c1);                
            } 
        insert cList;
}