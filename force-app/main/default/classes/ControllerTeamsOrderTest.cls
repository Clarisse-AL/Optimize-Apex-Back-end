@isTest
public with sharing class ControllerTeamsOrderTest {

    @TestSetup
    static void makeData(){
        List<Account> accs = new List<Account>();
        for(Integer i = 0; i<3; i++) {
            Account acc = new Account(Name = 'Test Account '+ i);
            accs.add(acc);
        }
        insert accs;

        TestDataFactory.createUser();
    }

    @isTest
    static void calculSumOrdersOrdered() {

            // get an account
            Account acct = [ SELECT Chiffre_d_affaire__c FROM Account WHERE Name='Test Account 1' LIMIT 1 ];

            // create an order with TotalAmount equals to 100
            List<Order> orders = TestDataFactory.createOrdersOnAccount(1, acct.Id);
            orders = [SELECT Id, TotalAmount, NetAmount__c, ShipmentCost__c FROM Order WHERE Status = 'Draft'];
            update acct;

            // Test methods
            Test.startTest();
            for(Order order : orders) {
                order.Status = 'Ordered'; }
            update orders;
            ControllerTeamsOrder orderPage = new ControllerTeamsOrder();
            Test.stopTest();

            // Total amount should equals to 100
            System.assertEquals(100, orderPage.SumOrdersOrdered);
            
           



    }
 
}
