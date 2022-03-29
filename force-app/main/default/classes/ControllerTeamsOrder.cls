public with sharing class ControllerTeamsOrder {

    // Calculate total amount of orders placed
    public decimal SumOrdersOrdered{
        get{
			AggregateResult groupedResults =   [SELECT SUM(TotalAmount)total
                                                FROM Order 
                                                WHERE Status = 'Ordered'
                                                GROUP BY Account.OwnerId ];
			return (decimal)groupedResults.get('total');

        }
        set;
    }

    // Calculate total amount of draft orders
    public decimal SumOrdersDraft{
        get{
			AggregateResult groupedResults =   [SELECT SUM(TotalAmount)total
                                                FROM Order 
                                                WHERE Status = 'Draft'
                                                GROUP BY Account.OwnerId ];
			return (decimal)groupedResults.get('total');

        }
        set;
    }
}
