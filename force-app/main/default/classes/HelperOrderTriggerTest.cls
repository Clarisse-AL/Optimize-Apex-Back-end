@isTest
public with sharing class HelperOrderTriggerTest {
    @TestSetup
    static void makeData(){
        List<Account> account = new List<Account>();
        for(Integer i = 0; i<3; i++) {
            Account accTest = new Account(Name = 'AccountTest '+ i);
            account.add(accTest);
        }
        insert account;
    }
    
/********************************** test for HelperOrderTrigger.UpdateCA **********************************************/    
    

    @isTest
    static void UpdateCATest() {
        
        // Create 1 order with draft status on an account where order totalAmount is equal to 100, and shipmentCost equal to 10
        Account acctTest = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Name = 'AccountTest 1'];
        List<Order> orders = TestDataFactory.createOrdersOnAccount(1, acctTest.Id);

        // Test method
        Test.startTest();
            for(Order order : orders) {
                order.Status = 'Ordered'; }
            update orders;
        Test.stopTest();
        
        // Acc CA should be equal to 100
        Account acctTestAfterUpdate = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Name = 'AccountTest 1'];
        System.assertEquals(100, acctTestAfterUpdate.Chiffre_d_affaire__c, 'Value incorrect : Chiffre d\'affaire should be equal to TotalAmount' );
        
    }

    @isTest
    static void CheckUpdateCAIfMoreThanHundreOrders() {
        
        // Create 101 order with draft status on an account where order totalAmount is equal to 100, and shipmentCost equal to 10
        Account acctTest = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Name = 'AccountTest 1'];
        List<Order> orders = TestDataFactory.createOrdersOnAccount(101, acctTest.Id);

        // Test method
        Test.startTest();
            for(Order order : orders) {
                order.Status = 'Ordered'; }
            update orders;
        Test.stopTest();
        
        // Acc CA should be equal to 10100
        Account acctTestAfterUpdate = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Name = 'AccountTest 1'];
        System.assertEquals(10100, acctTestAfterUpdate.Chiffre_d_affaire__c, 'Value incorrect : Chiffre d\'affaire should be equal to TotalAmount' );
        
    }

    @isTest
    static void CheckUpdateCAIfDraftOrders() {
        
        // Create 1 order with draft status on account where order totalAmount is equal to 100, and shipmentCost equal to 10
        Account acctTest = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Name = 'AccountTest 1'];
        List<Order> orders = TestDataFactory.createOrdersOnAccount(1, acctTest.Id);

        // Test accounts method
        Test.startTest();
            for(Order order : orders) {
                order.Status = 'draft';
            }
            update orders;
        Test.stopTest();
        
        // Acc CA should be equal to 0
        Account acctTestAfterUpdate = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Name = 'AccountTest 1'];
        System.assertEquals(0, acctTestAfterUpdate.Chiffre_d_affaire__c, 'Value incorrect : should be equal to 0' );
        
    }



    /********************************** test for HelperOrderTrigger.CalculNetAmount **********************************************/
    
    @isTest
    static void CalculNetAmountTest(){
        
        // Create 1 order with draft status on account where order totalAmount is equal to 100, and shipmentCost equal to 10
        Account acctTest = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Name = 'AccountTest 1'];
        List<Order> orders = TestDataFactory.createOrdersOnAccount(1, acctTest.Id);
        orders = [SELECT Id, TotalAmount, NetAmount__c, ShipmentCost__c FROM Order WHERE Status = 'Draft'];

        // Test accounts method
        Test.startTest();
            for (Order order : orders) {
                if (order.ShipmentCost__c!=null) {
                    order.NetAmount__c = order.TotalAmount - order.ShipmentCost__c;
                }
                else {
                    order.NetAmount__c = order.TotalAmount;
                }
                
            }
            update orders;
        Test.stopTest();
        
        //NetAmount should be equal to 90
        Order ordersAfterUpdate = [SELECT Id, TotalAmount, NetAmount__c, ShipmentCost__c FROM Order WHERE Status = 'Draft'];
        System.assertEquals(90, ordersAfterUpdate.NetAmount__c, 'Value incorrect : should be equal to 90');
            
            
    }
    
    @isTest
    static void CheckNetAmountIfMoreThanOneOrders(){

        // Create 1 order with draft status on account where order totalAmount is equal to 100, and shipmentCost equal to 10
        Account acctTest = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Name = 'AccountTest 1'];
        List<Order> orders = TestDataFactory.createOrdersOnAccount(10, acctTest.Id);
        orders = [SELECT Id, TotalAmount, NetAmount__c, ShipmentCost__c FROM Order WHERE Status = 'Draft'];

        // Test accounts method
        Test.startTest();
            for (Order order : orders) {
                if (order.ShipmentCost__c!=null) {
                    order.NetAmount__c = order.TotalAmount - order.ShipmentCost__c;
                }
                else {
                    order.NetAmount__c = order.TotalAmount;
                }
                
            }
            update orders;
        Test.stopTest();
        
        //NetAmount should be equal to 90
        List<Order> ordersAfterUpdate = [SELECT Id, TotalAmount, NetAmount__c, ShipmentCost__c FROM Order WHERE Status = 'Draft'];
        System.assertEquals(90, ordersAfterUpdate[0].NetAmount__c, 'Value incorrect : should be equal to 90');
            
            
    }
    
    @isTest
    static void CheckNetAmountIfShipmentCostEqualZero(){
      
        // Create 1 order with draft status on account where order totalAmount is equal to 100, and shipmentCost equal to 10
        Account acctTest = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Name = 'AccountTest 1'];
        List<Order> orders = TestDataFactory.createOrdersOnAccount(1, acctTest.Id);
        orders = [SELECT Id, TotalAmount, NetAmount__c, ShipmentCost__c FROM Order WHERE Status = 'Draft'];

        // Test accounts method
        Test.startTest();
            
            for (Order order : orders) {
                    order.ShipmentCost__c = 0;
                    order.NetAmount__c = order.TotalAmount - order.ShipmentCost__c;
                }
                
            update orders;
        Test.stopTest();
        
        //NetAmount should be equal to 100
        Order ordersAfterUpdate = [SELECT Id, TotalAmount, NetAmount__c, ShipmentCost__c FROM Order WHERE Status = 'Draft'];
        System.assertEquals(100, ordersAfterUpdate.NetAmount__c, 'Value incorrect : should be equal to 100');

    }
    
}