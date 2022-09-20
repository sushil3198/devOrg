public class WrapperDemo {
    
    @AuraEnabled
    public static /*List<OppsWrapper>*/ OppsWrapper returnList(String inputName){
        List<OppsWrapper> accList = new List<OppsWrapper>();
        //accList = [Select Id, Name from Account WHERE Name LIKE :inputName];
        OppsWrapper ops = new OppsWrapper(inputName);
        List<Contact> cList = ops.cList;
        System.debug('Contacts: ' + cList);
        accList.add(ops);
        return ops;
    }
    
    public class OppsWrapper{
        @AuraEnabled
        public List<Opportunity> oppsList { get; set; }
        @AuraEnabled
        public List<Contact> cList { get; set; }
        
        public OppsWrapper(String input){
            this.oppsList = [Select Id, Name from Opportunity WHERE Account.Name LIKE :input];
            this.cList = [Select Id, lastName from Contact WHERE Account.Name LIKE :input];
        }
    }
}