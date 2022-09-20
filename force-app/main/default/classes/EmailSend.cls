public class EmailSend {
    
    public static void dummyMethod(){
        List<Account> accList = [Select Id,Name, createdDate from Account WHERE createdDate < LAST_N_MONTHS:6 LIMIT 100];
        string header = 'Record Id' + '\t' + 'Name' + '\t' + 'Created Date' + '\n';
        string finalstr = header ;
        for(Account a: acclist){
            string recordString = a.Id+'\t'+a.Name+'\t'+a.CreatedDate+'\t'+ '\n';
            finalstr = finalstr +recordString;
        }
        Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
        blob csvBlob = Blob.valueOf(finalstr);
        string csvname= 'Account.xls';
        csvAttc.setFileName(csvname);
        csvAttc.setBody(csvBlob);
        Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
        String[] toAddresses = new list<string> {'sushil.sharma02@infosys.com'};
        String subject ='Account XLS';
        email.setSubject(subject);
        email.setToAddresses( toAddresses );
        email.setPlainTextBody('Account CSV ');
        email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc});
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    }
    
    
    
    
    public static void demoSend(){
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[] { 'sushil.sharma02@infosys.com' };
            message.optOutPolicy = 'FILTER';
        message.subject = 'Subject Test Message';
        message.plainTextBody = 'This is the message body.';
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
            Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
    }
    
    public static void exportToCSV() {
        ApexPages.PageReference report = new ApexPages.PageReference('/00O5g00000CdNToEAN?excel=1');
        Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
        attachment.setFileName('Leads.xls');
        attachment.setBody(Blob.valueof(report.getContent().toString()));
        attachment.setContentType('application/vnd.ms-excel');
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment } );
        message.setSubject('Lead Report');
        message.setPlainTextBody('The report is attached.');
        message.setToAddresses( new String[] { 'sushil.sharma02@infosys.com' } );
       // message.setCcAddresses(new String[] { 'naveen.catch@gmail.com'});
        try{
            Messaging.sendEmail( new Messaging.SingleEmailMessage[] { message } );
        } catch(Exception e){
            System.debug('Error caught ===========> ' + e.getMessage());
        }
        //Messaging.sendEmail( new Messaging.SingleEmailMessage[] { message } );
        System.debug(message);
        System.debug(attachment);
    }
    
}