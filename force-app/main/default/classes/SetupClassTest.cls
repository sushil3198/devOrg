@isTest
public class SetupClassTest {

    @testSetup
    static void testRecords(){
        Account acc = new Account(Name='SushilTEst');
        insert acc;
        Contact c = new COntact(lastName='testSetup', AccountId = acc.Id);
        Profile p =[Select Id from Profile where Name LIKE '%super user%' LIMIT 1];
        User u = new User(lastName='Pat', 
                          Email='sampadPatricl@enelx.com',
                          Alias='Harry',
                          TimeZoneSidKey = 'America/Los_Angeles',
                          EmailEncodingKey = 'UTF-8',
                          LanguageLocaleKey = 'en_US',
                          LocaleSidKey = 'en_US',
                          userName='setuoTestUser@enelx.com',
                          ProfileId = p.Id,
                          ContactId = c.Id
                         );
        insert u;
        
        
    }
    
    @isTest
    public static void testUserName(){
        User u = [Select Id from User LIMIT 1];
        System.runAs(u){
            SetupClass.setupMethod();
        }
    }
    
    @isTest
    public static void testUserName2(){
        User u = [Select Id from User LIMIT 1];
        System.runAs(u){
            SetupClass.setupMethod2();
        }
    }
}