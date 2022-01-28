public without sharing class SumTotalAmountOrders {
    public decimal SumOrders{
        get{
			AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order WHERE Status = 'Ordered'];
			return (decimal)groupedResults.get('total');

        }
        set;
    }
}