trigger Account_Trigger1 on Account (before insert) {

    if(trigger.isInsert)
    {
        if(trigger.isAfter)
        {
            List<Contact> contact_List = new List<Contact>();
            for(Account a : trigger.new)
            {
                Contact c = new Contact(LastName = a.Name, AccountId = a.Id);
                contact_List.add(c);
            }
            if(!contact_List.isEmpty())
                insert contact_List;
        }
    }
}