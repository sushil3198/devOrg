trigger newCase on Case (after insert) {

    List<Case> cList = new List<Case>();
    Set<id> setList = new Set<id>();
    for(case c : trigger.new)
    {
        setList.add(c.Id);
    }
    
    List<Case> caseList = [Select Id, Origin from Case where Id In : setList];
    if(Trigger.isInsert)
    {
        for(Case c : caseList)
        {
            
            if(c.Origin == 'Email')
            {
                c.Status = 'New';
                c.Priority = 'Normal';
            }
            cList.add(c);
        } 
    }update cList;
}