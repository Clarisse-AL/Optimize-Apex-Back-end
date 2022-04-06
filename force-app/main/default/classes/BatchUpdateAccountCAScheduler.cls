global with sharing class BatchUpdateAccountCAScheduler implements Schedulable{
    global void execute(SchedulableContext sc) {
        BatchUpdateAccountCA batch = new BatchUpdateAccountCA();
        Database.executeBatch(batch);
    }
}