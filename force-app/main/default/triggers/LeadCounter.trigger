trigger LeadCounter on Lead (before update) {
    if(trigger.isBefore)
    {
        List<Lead> lList = new List<Lead>();
        for(Lead l : trigger.new)
        {
            l.Counter__c = 1;
        }
    }
}