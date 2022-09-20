trigger updateTriger on Account (after update){
    set<id> idList=new set<id>();
    list<contact> conlist=new list<contact>();
    for(account acc:trigger.new){
        if(acc.website!=null){
            idList.add(acc.id);
        }
        if(idList.size()>0){
            for(contact con:[select id,firstname,lastname,profile__c,account.website from contact where accountid in:idlist]){
                con.profile__c=con.account.website+'/'+con.firstname.left(1)+con.lastname;
                conlist.add(con);            }
        }
    }
    update conlist;
}