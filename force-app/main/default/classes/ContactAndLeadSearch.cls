public class ContactAndLeadSearch {

    public static List<List< SObject>> searchContactsAndLeads(String searchName)
    {
        List<List<SObject>> searchList = [FIND :searchName IN NAME FIELDS RETURNING Contact(FirstName,LastName), Lead(FirstName,LastName)];
        system.debug(searchList);
        return searchList;
    }
}