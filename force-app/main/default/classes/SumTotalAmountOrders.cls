public without sharing class SumTotalAmountOrders {
    public decimal SumOrders{
        get{
			AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order];
			return (decimal)groupedResults.get('total');

        }
        set;
    }
}