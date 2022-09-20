trigger ContactUpdateTrigger on Contact (before insert){
    Set<id> accIdSet = new Set<Id>();
    for(Contact c : trigger.new){
        if(c.AccountId != null)
            accIdSet.add(c.AccountId);
    }

    Map<Id,Account> accMap = new Map<Id,Account>([Select Phone from Account WHERE Id IN :accIdSet]);
    List<Contact> cList = new List<Contact>();
    for(Contact c : trigger.new){
        if(c.AccountId != null){
            c.otherPhone = accMap.get(c.AccountId).Phone;
            //cList.add(c);
        }
    }
}