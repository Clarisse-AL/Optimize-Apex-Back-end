global class BatchUpdateAccountCA implements Database.Batchable<sObject>{

   global Database.QueryLocator start(Database.BatchableContext info){ 
       return Database.getQueryLocator([SELECT Id, Chiffre_d_affaire__c, 
       (SELECT NetAmount__c FROM Orders WHERE Status = 'Ordered') 
       FROM Account]);

   }
    
   global void execute(Database.BatchableContext info, List<Account> account){      
        
    HelperTriggerUpdateCA.UpdateCa(account);
   }    
    
   global void finish(Database.BatchableContext info){     
       
   } 
}