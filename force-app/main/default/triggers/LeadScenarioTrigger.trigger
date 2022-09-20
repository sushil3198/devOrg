trigger LeadScenarioTrigger on Lead (before insert, before update)
{
    List<String> mailList = new List<String>();
    for(Lead l : trigger.new)
    {
        mailList.add(l.email);
    }

    List<Contact> cList = [Select Id, email from Contact WHERE email IN :mailList];

    for(Lead l :trigger.new)
    {
        if(trigger.isInsert)
        {
            if(cList.size() > 0)
                l.addError('Email already exists');
        }

        if(trigger.isUpdate)
        {
            if(l.email != trigger.oldMap.get(l.id).email && cList.size() > 0)
            {
                l.addError('Email already exists');
            }
        }
    }
}