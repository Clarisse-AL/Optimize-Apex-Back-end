global class BatchUpdateCA implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext info){ 
        //Requeter seulement les comptes 
        return Database.getQueryLocator([SELECT Id FROM Account]);
 
    }
     
    global void execute(Database.BatchableContext info, List<Account> acctList){
        Set<Id> setAccountIds = (new Map<Id,SObject>(acctList)).keySet();
        Account.TriggerUpdateAccountCA(setAccountIds);
    }    
     
    global void finish(Database.BatchableContext info){     
        
    } 
 }