public class HandlerOrders {
    
    public static void CalculNetAmount(List <Order> order) {
        // for each order calcul NetAmount
        for (Order orders : order){
            if ( orders.ShipmentCost__c != null){
                orders.NetAmount__c = orders.TotalAmount - orders.ShipmentCost__c;
            } else { 
                orders.NetAmount__c = orders.TotalAmount;
            }
        }
    }

    public decimal SumOrdersStatusOrdered{
        //sum of orders with status ordered
        get{
			AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order WHERE Status = 'Ordered'];
			return (decimal)groupedResults.get('total');
        }
        set;
    }
}