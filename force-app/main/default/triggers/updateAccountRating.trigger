trigger updateAccountRating on Opportunity (after insert, after update) {

    List<id> idList = new List<id>();
    List<Account> aList = new List<Account>();
    for(Opportunity op : Trigger.new)
    {
        idList.add(op.accountId);
    }
    
    for(account a :[Select Id, Rating from Account where Id IN :idList])
    {
        for(Opportunity opp : Trigger.new)
        {
            if(opp.StageName == 'Closed Won')
            {
                a.Rating = 'Hot';
                aList.add(a);
            }
        }
    } update aList;
}