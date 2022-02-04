global class BatchUpdateAccountCA implements Database.Batchable<sObject>{

   global Database.QueryLocator start(Database.BatchableContext info){ 
       //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
       return Database.getQueryLocator([SELECT Id FROM Account]);

   }
    
   global void execute(Database.BatchableContext info, List<Account> scope){      
              
		for(Account acct : scope){
			HandlerAccounts.UpdateCa(order);
       }
       
       update scope;
   }    
    
   global void finish(Database.BatchableContext info){     
       
   } 
}