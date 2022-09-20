@isTest
public class newCaseTest {

    @isTest
    public static void newCaseEmailTest()
    {
        Case c = new Case(Origin = 'Email');
        insert c;
        
        List<case> cList = [Select Origin from Case where Id = :c.Id];
        
        System.assertEquals(1, cList.size(), 'msg');
    }
}