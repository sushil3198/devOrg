trigger Opportunity_insertion on Opportunity (after insert) {

    if(trigger.isInsert)
    {
        if(trigger.isAfter)
        {
            for(Opportunity op : trigger.new)
            {
                Contact c = new Contact();
                c.AccountId = op.AccountId;
                c.FirstName = op.Name;
                c.LastName = 'Owner';
                insert c;
            }
        }
    }
    
}