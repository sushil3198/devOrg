trigger updateContactAdress on Contact (before insert) {

    Trigger_Control_Setting__mdt abc = Trigger_Control_Setting__mdt.getInstance('isBool');
    //System.debug(abc.Prevent_Trigger_Execution__c);
    if(abc.Prevent_Trigger_Execution__c == false){  
        Map<id,Account> relatedAccounts = new Map<Id, Account>();
        for(Contact c : Trigger.new)
        {
            relatedAccounts.put(c.AccountId,null);
        }
        
        relatedAccounts = new Map<Id,Account>([Select id, BillingStreet, BillingState, BillingPostalCode, BillingCountry from Account limit 1]);
        
        for(Contact c : Trigger.new)
        {
            if(c.AccountId !=null)
            {
            Account a = relatedAccounts.get(c.AccountId);
            c.MailingStreet = a.BillingStreet;
            c.MailingState = a.BillingState;
            c.MailingPostalCode = a.BillingPostalCode;
            c.MailingCountry = a.BillingCountry;
            }
        }
    }
}