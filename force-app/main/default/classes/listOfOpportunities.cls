public class listOfOpportunities {

    public List<Opportunity> myOpps = new List<Opportunity>();
    
    public static void listOfWonOpportunities()
    {
        List<Opportunity> wonOpps = new List<Opportunity>();
        wonOpps = [Select Id,Name from Opportunity where StageName='ClosedWon'];
    }
    
    public static void listOfOppsInASpecifiedRange(Date closedDateStart, Date closedDateEnd)
    {
        List<Opportunity> fetchedOpps = new List<Opportunity>();
        fetchedOpps = [Select Id, Name from Opportunity where closeDate >= :closedDateStart AND closeDate <= :closedDateEnd];
    }
    
    public static void listOfOppsBySaleRep(string ownerName)
    {
        List<Opportunity> opps = new List<Opportunity>();
        opps = [Select Id,Name from Opportunity where ownerId = :ownerName];
    }
}