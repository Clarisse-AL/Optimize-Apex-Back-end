global class BatchUpdateAccountCA implements Database.Batchable<sObject>{

   //Select fields on which excute batch
   global Database.QueryLocator start(Database.BatchableContext info){ 
      return Database.getQueryLocator( [SELECT Chiffre_d_affaire__c, 
                                       (SELECT NetAmount__c FROM Orders WHERE Status = 'Ordered') 
                                       FROM Account]);
   }
    
   global void execute(Database.BatchableContext info, List<Account> accounts){      

      //For each account with an order 'ordered', set order.netAmount to account.Chiffre_d_affaire__c
      for(Account accountUpdate : accounts){
         Decimal accountCA = 0;
         for(Order orders : accountUpdate.orders) {
            if (orders.TotalAmount!=null) {
               accountCA = accountCA + orders.TotalAmount;
            }
         }
         accountUpdate.Chiffre_d_affaire__c = accountCA;
         
      }
      update accounts;
   }    
    
   global void finish(Database.BatchableContext info){     
      
    
   } 
}