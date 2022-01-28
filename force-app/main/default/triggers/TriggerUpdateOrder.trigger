trigger TriggerUpdateOrder on Order (before update, after update) {
    
    if (Trigger.isBefore) {
        
        //avant update le trigger conserve les ancienne informations
        List <Order> order = new List <Order>(Trigger.old);
        
    }
    else if (Trigger.isAfter) {
        
        // nouvelle de ensemble d'Id
        set<Id> setAccountIds = new set<Id>();
        
        //nouveau trigger
        Order order = Trigger.new[0];
        Account acct = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id =:order.AccountId ];
        
        //Pour chaque commande MAJ du Chiffre d'affaire
        for(integer i=0; i< trigger.new.size(); i++){
                       
            acct.Chiffre_d_affaire__c = acct.Chiffre_d_affaire__c + order.TotalAmount;
            update acct;
        }
   
    }
    
}