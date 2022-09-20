public class AccountBatchApex implements Database.Batchable<sObject>, Database.Stateful {
    
    String market;
    Integer counter = 0;
    public AccountBatchApex(String mr){
        this.market = mr;
    }
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        String query = 'Select Id, Name from Account';
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<Account> scope){
        List<Account> accList = new List<Account>();
        for(Account a :  scope){
            a.Industry = 'Telecommunication';
            counter++;
            accList.add(a);
        }
        
        try{
            update accList;
        } catch(Exception e){
            System.debug(e.getMessage());
        }
    }
    
    public void finish(Database.BatchableContext bc){
        Id jobId = bc.getJobId();
        System.debug('JobId==========> ' + jobId);
        System.debug('Counter===========> ' + counter);
    }
}