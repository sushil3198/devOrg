trigger CountValueTrigger on Account (before insert, before update) {
    
    for(Account a : trigger.new)
    {
        if(a.Count__c > 50)
            a.Count__c = 200;
    }
}