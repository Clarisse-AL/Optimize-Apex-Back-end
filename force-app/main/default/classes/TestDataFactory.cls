@isTest
public with sharing class TriggerUpdateAccountCA {

    /* @isTest
    private static void testAccountsCreation() {
      List<Account> accounts = DataFactory.GenerateRandomAccounts(1);
      Test.startTest();
        List<Account> checkAccts = [SELECT Id FROM Account];
      Test.stopTest();
      System.assert(checkAccts.size() == 1, 'Was expecting to find 10 Accounts');
    } */

    @isTest
    static void testTriggerUpdateAccountCA () {

      for(integer i=0; i< 102; i++){
        
        Order orders = new Order();
        Account acct = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id =: orders.AccountId ];
          acct.Chiffre_d_affaire__c = orders.TotalAmount;

          Test.startTest();
          update acc;
          Test.startTest();

          System.assert(orders.size() == 102, 'Was expecting to find 10 Accounts');
    }

  }
}
