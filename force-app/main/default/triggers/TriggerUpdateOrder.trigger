trigger TriggerUpdateOrder on Order (before update, after update) {
        
    if (Trigger.isBefore) {
        
        HandlerOrders.CalculNetAmount(Trigger.new);
        
    }
    if (Trigger.isAfter) {
        
        HandlerAccounts.UpdateCa(Trigger.new);
        
        
    }
}