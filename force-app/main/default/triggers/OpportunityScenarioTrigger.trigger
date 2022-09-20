trigger OpportunityScenarioTrigger on Opportunity (after insert, after update)
{
    List<task> taskList = new List<task>();
    for(Opportunity o : trigger.new)
    {
        if(o.StageName == 'Closed Won')
        {
            if(trigger.isInsert)
            {
                Task t = new Task(whatId = o.Id);
                taskList.add(t);
            }
            if(trigger.isUpdate)
            {
                if(o.stageName != trigger.oldMap.get(o.Id).stageName)
                {
                    Task t = new Task(whatId = o.Id);
                    taskList.add(t);
                }
            }
        }
    }

    if(taskList.size() > 0 )
        insert taskList;
}