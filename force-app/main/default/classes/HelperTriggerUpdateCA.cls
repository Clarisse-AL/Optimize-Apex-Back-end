public with sharing class HelperTriggerUpdateCA {
   

    // Update Chiffre d'affaire on each account with an order with status ordered
    public static void UpdateCa(List<Account> accounts) {

        
        // set the Id for each order
        Set<ID> setAccountIDs = new Set<ID>();
        List <Order> order = new List<Order>();
        for(Order orders : order){
            if (orders.AccountId != null) {
                setAccountIds.add(orders.AccountId);
            }
        }
        
        // nested query pour to get orders 'ordered' for each account
        accounts = [SELECT Id, Chiffre_d_affaire__c, 
                                  (SELECT Id, AccountId,TotalAmount, NetAmount__c FROM Orders WHERE Status = 'Ordered') 
                                  FROM Account WHERE Id IN : setAccountIds];
        
        //For each account with an order 'ordered', set order.netAmount to account.Chiffre_d_affaire__c
        for(Account listAcctsToUpdate : accounts){
            Decimal accountCA = 0;
            
            for(Order orders : listAcctsToUpdate.orders) {
                accountCA += orders.NetAmount__c;
            }
            listAcctsToUpdate.Chiffre_d_affaire__c = accountCA;
        }
        update accounts;
    }
}
