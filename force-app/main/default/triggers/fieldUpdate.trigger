trigger fieldUpdate on Account (after Update) {

    Set<Id> idList = new Set<id>();
    List<Contact> cList = new List<Contact>();
    for(Account acc : Trigger.new)
    {
        if(acc.website !=null)
            idList.add(acc.id);
    }
    if(idList.size()>0)
    {
        for(Contact c : [Select id,firstname,lastname,profile__c,account.website from contact where accountid in :idList])
        {
            c.Profile__c = account.website + '/' + c.FirstName.left(1) + c.LastName;
            cList.add(c);
        }
    } update cList;
}