@isTest
public with sharing class HandlerOrdersTest {
   
        @testSetup static void dataCreation() {
            // Create accounts
            List<Account> accs = new List<Account>();
            for(Integer i = 0; i<3; i++) {
                Account acc = new Account(Name = 'Test Account '+ i, Chiffre_d_affaire__c = 10000);
                accs.add(acc);
            }
            insert accs;
        }
            
        @isTest static void createMoreThanHundredOrders() {
    
            // Get an account
            Account acct = [ SELECT Chiffre_d_affaire__c FROM Account WHERE Name='Test Account 1' LIMIT 1 ];
            // Create 250 orders with status ordered on account
            List<Order> orders = TestDataFactory.createOrdersOnAccount(110, acct.Id);
            // Create a list of accounts and add acc
            List<Account> accts = new List<Account> {acct};
            // Test accounts method
            Test.startTest();
            HandlerOrders.CalculNetAmount(orders);
            Test.stopTest();
            // Check actual account CA
            Account acctCA  = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id = :acct.Id];
            // Acc CA should be equal to 10000 + 110 * 100
            System.assertEquals(11000, acctCa.chiffre_d_affaire__c );
    
        }
    }

