/**************************************************************************************************
Description: Service class for creating logs.
====================================================================================================
====================================================================================================
TestClass: 
Code Coverage: 
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		05/15/2021        	Gourav Goyal 				Initial Creation   				         						      	Initial Creation    
***************************************************************************************************/
public class LogService {

	public static Log__c getErrorLog(String className, Integer statusCode, Exception error, String jsonBody) {
		Log__c errorLog = new Log__c();

		errorLog.APEX_Class__c = className;
		errorLog.Status_Code__c = statusCode;
		if (error != null) {
			errorLog.Error_Type__c = error.getTypeName();
			errorLog.Message__c = error.getMessage();
			errorLog.Stack_Trace__c = error.getStackTraceString();
		}
		if (jsonBody != null) { errorLog.JSON_Body__c = jsonBody.stripHtmlTags(); }

		return errorLog;
	}

	public static void createErrorLog(String className, Integer statusCode, Exception error, String jsonBody) {
		Log__c errorLog = getErrorLog(className, statusCode, error, jsonBody);
		createErrorLog(errorLog);
	}

	public static void createErrorLog(Log__c errorLog) {
		List<Log__c> listErrorLogs = new List<Log__c>();
		listErrorLogs.add(errorLog);
		createErrorLog(listErrorLogs);
	}

	public static void createErrorLog(List<Log__c> listErrorLogs) {
		if (System.isFuture() || System.isBatch()) {
			Database.DMLOptions dml = new Database.DMLOptions();
			dml.allowFieldTruncation = true;
			dml.optAllOrNone = true;
			Database.insert(listErrorLogs, dml);
		}
		else {
			createErrorLogAsync(JSON.serialize(listErrorLogs));
		}
	}

	@future
	public static void createErrorLogAsync(String jsonErrorLogs) {
		List<Log__c> listErrorLog = (List<Log__c>)JSON.deserialize(jsonErrorLogs, List<Log__c>.class);
		Database.DMLOptions dml = new Database.DMLOptions();
		dml.allowFieldTruncation = true;
		dml.optAllOrNone = true;
		Database.insert(listErrorLog, dml);
	}

	public static List<LogDatabaseError> logUpsertFailures(String className, List<sObject> upsertRecords, List<Database.UpsertResult> upsertResults)
	{	
		List<LogDatabaseError> errorList = new List<LogDatabaseError>();
		List<Log__c> logList = new List<Log__c>();

		for(Integer i = 0; i < upsertResults.size(); i++)
		{
			Database.UpsertResult ur = upsertResults[i];
			sObject sObj = upsertRecords[i];

			if (! ur.isSuccess())
            {
				LogDatabaseError ldbe = new LogDatabaseError(ur, sObj);
				logList.add(getErrorLog(className, 0, null, JSON.serialize(ldbe)));
				errorList.add(ldbe);
			}
		}
		
		createErrorLog(logList);

		return errorList; 
	}

	public static List<LogDatabaseError> logInsertUpdateFailures(String className, List<sObject> objRecords, List<Database.SaveResult> saveResults)
	{
		List<LogDatabaseError> errorList = new List<LogDatabaseError>();
		List<Log__c> logList = new List<Log__c>();

		for(Integer i = 0; i < saveResults.size(); i++)
		{
			Database.SaveResult sr = saveResults[i];
			sObject sObj = objRecords[i];

			if (! sr.isSuccess())
            {
                LogDatabaseError ldbe = new LogDatabaseError(sr, sObj);
				logList.add(getErrorLog(className, 0, null, JSON.serialize(ldbe)));
				errorList.add(ldbe);
            }
		}
		
		createErrorLog(logList);

		return errorList;
	}

	public static List<Log__c> logNoWriteInsertUpdateFailures(String className, List<sObject> objRecords, List<Database.SaveResult> saveResults)
	{
		List<Log__c> logList = new List<Log__c>();
		
		for(Integer i = 0; i < saveResults.size(); i++)
		{
			Database.SaveResult sr = saveResults[i];
			sObject sObj = objRecords[i];

			if (! sr.isSuccess())
            {
                LogDatabaseError ldbe = new LogDatabaseError(sr, sObj);
				Log__c logToAdd = LogService.getErrorLog(className, 0, null, JSON.serialize(ldbe));
				logList.add(logToAdd);
            }
		}
		
		return logList;
	}

	public static List<LogDatabaseError> logDeleteFailures(String className, List<sObject> delRecords, List<Database.DeleteResult> deleteResults)
	{
		List<LogDatabaseError> errorList = new List<LogDatabaseError>();
		List<Log__c> logList = new List<Log__c>();

		for(Integer i = 0; i < deleteResults.size(); i++)
		{
			Database.DeleteResult dr = deleteResults[i];
			sObject sObj = delRecords[i];

			if (! dr.isSuccess())
            {
                LogDatabaseError ldbe = new LogDatabaseError(dr, sObj);
				logList.add(getErrorLog(className, 0, null, JSON.serialize(ldbe)));
				errorList.add(ldbe);
            }
		}

		createErrorLog(logList);

		return errorList; 
	}

	public static void logSendEmailFailures(String className, List<Messaging.SendEmailResult> sendEmailResults){
		List<Log__c> logList = new List<Log__c>();
		for(Integer i = 0; i < sendEmailResults.size(); i++)
		{
			Messaging.SendEmailResult se = sendEmailResults[i];
			system.debug('EMail '+ se);
			//sObject sObj = delRecords[i];
			if (!se.isSuccess()) {
				logList.add(getErrorLog(className, 0, null, JSON.serialize(se.getErrors())));
            }
		}

		createErrorLog(logList);
	}

	public class LogDatabaseError 
	{
		public Database.UpsertResult upsertResult;
		public Database.SaveResult saveResult;
		public Database.DeleteResult deleteResult;
		public sObject record;

		public LogDatabaseError(Database.DeleteResult dr, sObject rec)
		{
			this.deleteResult = dr;
			this.record = rec;
		}
		public LogDatabaseError(Database.UpsertResult ur, sObject rec)
		{
			this.upsertResult = ur;
			this.record = rec;
		}
		public LogDatabaseError(Database.SaveResult sr, sObject rec)
		{
			this.saveResult = sr;
			this.record = rec;
		}
	}
}