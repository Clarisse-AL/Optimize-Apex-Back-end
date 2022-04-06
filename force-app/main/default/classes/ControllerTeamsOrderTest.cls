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
    }
    


    @isTest
    static void calculSumOrdersOrdered() {

// get an account
Account acct = [ SELECT Chiffre_d_affaire__c FROM Account WHERE Name='Test Account 1' LIMIT 1 ];

// create an order with TotalAmount equals to 100
List<Order> orders = TestDataFactory.createOrdersOnAccount(1, acct.Id);

// Test query
Test.startTest();
AggregateResult ar =   [SELECT SUM(TotalAmount)total FROM Order WHERE Status = 'ordered' AND Account.Id =: acct.Id GROUP BY Account.OwnerId ];
Test.stopTest();

// Total amount should equals to 100
System.assertEquals(100,ar.get('total'));

    }


   
}
