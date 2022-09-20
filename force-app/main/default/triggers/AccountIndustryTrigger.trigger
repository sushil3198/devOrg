/*
 * Whenever an Account is created with Industry as ‘Telecommunications’; create a Contact record 
 * with lastName as Account Name and contact otherPhone as Account’s Phone.
 * 
 * 
 * Object : Account
 * event : after
 * dml : insert
 * 
 * logic: iterate over trigger.new
 * 		  Industry == 'Tele' 
 * 		  if true then create Contact Record

*/
trigger AccountIndustryTrigger on Account (after insert) {
    List<Contact> cList = new List<Contact>();
    for(Account a : trigger.new){
        if(a.Industry == 'Telecommunications'){
            Contact c = new Contact(lastName = a.Name, otherPhone = a.Phone, AccountId = a.Id);
            cList.add(c);
        }
    }
    
    if(cList.size() > 0){
        insert cList;
    }
}