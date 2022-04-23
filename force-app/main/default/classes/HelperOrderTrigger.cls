public with sharing class HelperOrderTrigger {
    
    //Calcul net amount on each order
    public static void CalculNetAmount(List<Order> orders) {
        
        // For each order calcul net amount
        for (Order order : orders) {
            if (order.ShipmentCost__c!=null) {
                 order.NetAmount__c = order.TotalAmount - order.ShipmentCost__c;
            }
            else {
                order.NetAmount__c = order.TotalAmount;
            }
	        
        }
    }
   
    // Update Chiffre d'affaire on each account with an order with status ordered
    public static void UpdateCa(List<Id> accountsId) {

        // nested query pour to get orders 'ordered' for each account
        List<Account> accounts = [   SELECT Id, Chiffre_d_affaire__c, 
                                    (SELECT Id, AccountId,TotalAmount, NetAmount__c FROM Orders WHERE Status = 'Ordered') 
                                    FROM Account WHERE Id IN : accountsId];
        
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







}
