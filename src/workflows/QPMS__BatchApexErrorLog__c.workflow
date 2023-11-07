<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__Send_Email_After_Batch_Processing_Complete_Course_Session</fullName>
        <description>Send Email After Batch Processing Complete Course Session</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Trainings_Creation_From_Course_Session_Batch</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Send_Email_After_Batch_Processing_Complete_Job_Function</fullName>
        <description>Send Email After Batch Processing Complete Job Function</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Trainings_Creation_From_Jobfunction_Batch</template>
    </alerts>
    <rules>
        <fullName>QPMS__Trainings_Creation_SendEmail_CourseSession</fullName>
        <actions>
            <name>QPMS__Send_Email_After_Batch_Processing_Complete_Course_Session</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 3) AND 2</booleanFilter>
        <criteriaItems>
            <field>QPMS__BatchApexErrorLog__c.QPMS__JobApexClass__c</field>
            <operation>equals</operation>
            <value>BatchHandlerImportSession</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__BatchApexErrorLog__c.QPMS__Status__c</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__BatchApexErrorLog__c.QPMS__JobApexClass__c</field>
            <operation>equals</operation>
            <value>BatchHandlerEnrollment)</value>
        </criteriaItems>
        <description>Notify user after trainings creation from course session batch.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Trainings_Creation_SendEmail_Jobfunction</fullName>
        <actions>
            <name>QPMS__Send_Email_After_Batch_Processing_Complete_Job_Function</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__BatchApexErrorLog__c.QPMS__JobApexClass__c</field>
            <operation>equals</operation>
            <value>BatchUpdateDocCoursePersons</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__BatchApexErrorLog__c.QPMS__Status__c</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <description>Notify user after trainings creation from jobfunction batch.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
