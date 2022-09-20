@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class ManegerAccount {
    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        // grab the AccountId from the mid of the URL
        String accountId = request.requestURI.substringBetween('Accounts/', '/contacts');
        Account result =  [SELECT Id,Name, (select Id,Name from Contacts)
                        FROM Account
                        WHERE Id = :accountId];
        return result;      
    }
}