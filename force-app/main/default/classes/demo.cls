public class demo {
	public void dummyMethod()
    {
        System.debug('Hello World');
    }
    
    public static void display()
    {
        Account[] account = [SELECT Id, Name, Description from Account LIMIT 5];
        for(Account a : account)
        {
	        System.debug(a);   
        }
    }
    
    public static void insertRecords()
    {
        Account acc = new Account(Name='Sushil', Description='Hello World',Phone='(415)555-1212', NumberOfEmployees=100, AccountNumber='BC656092');
        insert acc;
    }
}