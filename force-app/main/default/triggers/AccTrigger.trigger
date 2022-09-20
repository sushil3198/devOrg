trigger AccTrigger on Account (before delete) {
    
    Set<Id> accIdSet = new Set<Id>();
    for(Account a : trigger.old)
    {
        accIdSet.add(a.Id);
    }
    
    Map<Id,Account> accMapOpps = new Map<Id,Account>([Select Id, Name, (Select Id from Opportunities) FROM Account WHERE Id IN :accIdSet]);
}