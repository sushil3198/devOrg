trigger PreventAccDeleteTrigger on Account (before delete)
{
    Set<id> accIdSet = new Set<Id>();

    for(Account a : trigger.old)
    {
        accIdSet.add(a.Id);
    }

    Map<Id,Account> accMap = new Map<Id,Account>([Select Id, Name, (Select Id from contacts) from Account WHERE Id IN :accIdSet]);

    for(Account a : trigger.old)
    {
        if(accMap.get(a.Id).contacts.size() >= 2)
        {
            a.addError('Account has 2 contacts, cannot Delete this account');
        }
    }
}