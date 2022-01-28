trigger TriggerUpdateOrderonAccount on Order (before update, after update) {
	
    /* set<Id> setAccountIds = new set<Id>();
    
    for(integer i=0; i< trigger.new.size(); i++){
        Order newOrder= trigger.new[i];
       
        Account acc = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id =:newOrder.AccountId ];
        acc.Chiffre_d_affaire__c = acc.Chiffre_d_affaire__c + newOrder.TotalAmount;
        update acc;
    } */

    List <Account> acct = new List <Account> ([SELECT Id FROM Account]);
    List <Order> order = new List <Order> ([SELECT Id, AccountId FROM Order WHERE AccountId =: acct.Id]);    

    if (Trigger.isBefore) {

        order = Trigger.old;
        System.debug('********Trigger values***********');
        System.debug('***SFDC : Trigger.old est : ' + Trigger.old);
    }
    else if (Trigger.isAfter) {
        
        order = Trigger.new;
        System.debug('********Trigger values***********');    
        System.debug('***SFDC : Trigger.new est : ' + Trigger.new);
       
    }

    update acct;
    update order;

}