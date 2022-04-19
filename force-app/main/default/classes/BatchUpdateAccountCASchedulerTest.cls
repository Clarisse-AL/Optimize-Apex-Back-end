@isTest
public with sharing class BatchUpdateAccountCASchedulerTest {
    public static testMethod void testschedule() {
		Test.StartTest();
		BatchUpdateAccountCAScheduler testScheduler = new BatchUpdateAccountCAScheduler();
		String sch = '0 0 23 * * ?';
		system.schedule('Test status Check', sch, testScheduler );
		Test.stopTest();
	}
}
