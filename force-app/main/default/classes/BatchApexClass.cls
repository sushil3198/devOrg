public class BatchApexClass implements Database.Batchable<sObject>, Database.Stateful{

    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('Select Id, Name from Account LIMIT 200');
    }
    
    public void execute(Database.BatchableContext bc, List<Account> scope){
        List<Account> accList = new List<Account>();
        for(Account a : scope){
            a.Name = a.Name + 'updated';
            accList.add(a);
        }
        
        try{
            update accList;
        } catch(Exception e){
            System.debug('Error============>' + e.getMessage());
        }
    }
    
    public void finish(Database.BatchableContext bc){
        Id jobId = bc.getJobId();
    }
}