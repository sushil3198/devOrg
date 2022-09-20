public class contact_account {

    public static void create(Account[] a)
    {
     	List<Contact> cList = new List<Contact>();
        for(Account acc : a)
        {
        Contact c = new Contact(LastName= acc.Name, AccountId = acc.Id);
        cList.add(c);
        }
        insert cList;
    }
    
    public static void fun(Account[] a)
    {
      List<Opportunity> opList = new List<Opportunity>();
      for(Account acc : a)
      {
          if(acc.Rating == 'Warm')
          {
              Opportunity op = new Opportunity(Name=acc.Name, Id = acc.Id);
              opList.add(op);
          }
      }
    }
}