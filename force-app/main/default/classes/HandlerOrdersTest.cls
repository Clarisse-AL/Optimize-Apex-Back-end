@isTest private class HandlerOrdersTest {
    
   @TestSetup

   static  void testData() {
   User user3 = TestDataFactory.createUser('User3') ;
   System.runAs(user3)  {
  TestDataFactory.createOrdersForOneAccount(5) ; 
  }
   User user2 = TestDataFactory.createUser('User2') ;
   System.runAs(user2)  {
   TestDataFactory.createOrdersForOneAccount(3) ; 
   }
   User user1 = TestDataFactory.createUser('User1') ;
   System.runAs(user1)  {
   TestDataFactory.createOrdersForOneAccount(2) ; 
   }
}

   @isTest
private static void TestAggregateResultList(){

   Test.startTest();
   HandlerOrders controller = new HandlerOrders();
   List<AggregateResult> totalOrdersByOwner = controller.aggregateResultList;
   Test.stopTest();

//Assert that the list isn't empty
System.assert(totalOrdersByOwner.size()>0); 
}
}