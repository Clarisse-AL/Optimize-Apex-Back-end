@isTest
public with sharing class BatchUpdateAccountCATest {

    @TestSetup
    static void makeData(){
        List<Account> account = new List<Account>();
        for(Integer i = 0; i<3; i++) {
            Account accTest = new Account(Name = 'AccountTest '+ i);
            account.add(accTest);
        }
        insert account;
    }

    @isTest
    static void BatchUpdateCATest() {

       // Create 1 order with draft status on an account where order totalAmount is equal to 100, and shipmentCost equal to 10
        Account acctTest = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Name = 'AccountTest 1'];
        List<Order> orders = TestDataFactory.createOrdersOnAccount(1, acctTest.Id);
        for(Order order : orders) {
            order.Status = 'Ordered';
        }
        update orders;

        // Test method
        Test.startTest();
            
            BatchUpdateAccountCA batchUpdateAccountCA = new BatchUpdateAccountCA();
            Id batchId = Database.executeBatch(batchUpdateAccountCA);
        Test.stopTest();
        
        // Acc CA should be equal to 90
        Account acctTestAfterUpdate = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Name = 'AccountTest 1'];
        System.assertEquals(90, acctTestAfterUpdate.Chiffre_d_affaire__c, 'Value incorrect : Chiffre d\'affaire should be equal to TotalAmount' );

    }
}