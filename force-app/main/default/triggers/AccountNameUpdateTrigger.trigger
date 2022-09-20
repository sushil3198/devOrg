/*
Whenever an Account is created then prepend Name with Dr.

object : Account
event : before
dml : insert

logic: iterate over trigger.new
       append Name with Dr.
*/
trigger AccountNameUpdateTrigger on Account (before insert) {
for(Account a : trigger.new){
        a.Name = 'Dr. ' + a.Name;
    }
}