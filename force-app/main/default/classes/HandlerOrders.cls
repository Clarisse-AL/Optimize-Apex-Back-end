/**
* This class returns a summary of the data from the Order Object
* It is ordered by the owner i.e. the sales rep.   
*/

public with sharing class HandlerOrders {

    public List<AggregateResult> aggregateResultList {get; set;}
   
    public myTeamOrdersController() {
   
        aggregateResultList = new List <aggregateResult>();
        aggregateResultList = [SELECT COUNT(id) ordCount, 
                                      SUM(TotalAmount) ordAmount, 
                                      owner.Name ordName 
                                      FROM Order 
                                      WHERE Status = 'Ordered' 
                                      GROUP BY owner.Name];
    }
   }