trigger Opp_new_rating_change on Account (after insert) {
    if(trigger.isInsert)
    {
        if(trigger.isAfter)
        {   
            contact_account.create(trigger.new);
        }
    }
}