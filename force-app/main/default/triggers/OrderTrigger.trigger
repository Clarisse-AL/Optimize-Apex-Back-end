trigger OrderTrigger on Order (before update, after update) {


    if (Trigger.isBefore) {

              
        
        HelperOrderTrigger.CalculNetAmount(Trigger.new);

        
        
    }


    if(Trigger.isAfter){
        List<Id> accountsId = new List<Id>();

        for (Order order : Trigger.new) {
            accountsId.add(order.AccountId);
        }
        HelperOrderTrigger.UpdateCa(accountsId);
    }
}