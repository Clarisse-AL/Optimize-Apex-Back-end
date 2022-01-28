global class BatchUpdateAccountCA implements Database.Batchable<sObject>{

    global Database.QueryLocator start(Database.BatchableContext info){

        // Retourne la liste des enregistrements dont la méthode éxécute a besoin
        return Database.getQueryLocator([SELECT Id FROM Account]);

    }

    global void execute(Database.BatchableContext info, List<Account> acctList){

        //MAJ du champs 'Chiffre d'affaire' des commandes sur chaque compte
        list<Order> ordersList =  [SELECT Id, TotalAmount, AccountId FROM Order WHERE Status = 'Ordered'];

        if (ordersList.AccountId == acctList.Id){
            for(Account accts : acctList){
                accts.Chiffre_d_affaire__c = (Integer) ordersList.TotalAmount;
            }
        }
        else {
            for(Account accts : acctList){
                accts.Chiffre_d_affaire__c ='0';
            }
        }

        update acctList;
    }    

    global void finish(Database.BatchableContext info){ 
        //Affiche un message une fois la méthode execute terminé    
        System.debug('Finish');

    } 
}