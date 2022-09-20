trigger Account_Trigger on Account (after insert) {

    if(trigger.isInsert)
    {
        if(trigger.isAfter)
        {
            for(Account a: trigger.new)
            {
                Contact c = new Contact(LastName= a.Name);
                insert c;
            }
        }
    }
}