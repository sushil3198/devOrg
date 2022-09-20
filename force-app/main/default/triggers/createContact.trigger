trigger createContact on Account (after insert, after update){

if(Trigger.isInsert){

    List<Contact> ct = new List <Contact>();

    for(Account acc : trigger.new){

        Contact c = new Contact(LastName = 'Default',
                    AccountId=acc.id,
                    Fax=acc.Fax,
                    MailingStreet=acc.BillingStreet,
                    MailingCity=acc.BillingCity,
                    /* similarly add all fields which you want */
                    MailingState=acc.BillingState,
                    MailingPostalCode=acc.BillingPostalCode,
                    MailingCountry=acc.BillingCountry,
                    Phone=acc.Phone);

        ct.add(c);
    }
    insert ct; 
}
}