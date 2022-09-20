trigger Opportunity_trigger on Opportunity (before insert, before update) {
    
    if(trigger.isInsert){
    for(Opportunity op : trigger.new)
    {
        if(op.Amount < 5000)
            op.addError('Amount cannot be less than 5000');
    }}
    
    else if(trigger.isUpdate){
    for(Opportunity o : trigger.new)
        {
            if(o.Amount < 3000)
                o.addError('Amount cannot be less than 3000');
        }
    }
}