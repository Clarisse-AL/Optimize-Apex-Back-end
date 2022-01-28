public with sharing class UpdateOrder {
    
    //avant update conserve l'ancien enregistrement
    public static void BeforeUpdate() {
                
        Order order = Trigger.old;
        
    }
    
    //après update met à jour le nouvel enregistrement
    public static void AfterUpdate() {
        
        // nouvel de ensemble d'Id
        set<Id> setAccountIds = new set<Id>();
        
        //nouveau trigger
        Order order = Trigger.new;
        Account acct = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id =:order.AccountId ];
        
        //Pour chaque commande MAJ du Chiffre d'affaire
        for(integer i=0; i< trigger.new.size(); i++){
            
            acct.Chiffre_d_affaire__c = acct.Chiffre_d_affaire__c + order.TotalAmount;
                        
        }
        update acct;
        
    }
}