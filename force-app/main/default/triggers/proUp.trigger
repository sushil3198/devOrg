trigger proUp on Account (after Update) {

    List<Contact> contactToUpdate = new List<Contact>();
    
    for(Account a : [Select Id,Website,(Select Id,FirstName,LastName FROM Contacts) From Account Where Id = :Trigger.new])
    {
        if(a.Website !=null)
        {
            for(Contact c : a.Contacts)
            {
                c.Profile__c = a.Website + '/' + c.FirstName.substring(0,1) + c.LastName;
                contactToUpdate.add(c);
            }
        }
    }
    update contactToUpdate;
}