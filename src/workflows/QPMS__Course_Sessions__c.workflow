<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__Refresher_Period_Notice_Notification_to_Owner</fullName>
        <description>Refresher Period Notice Notification to Owner</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Refresher_Period_Instructor_led_Owner</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Session_Owner_Email_alert</fullName>
        <description>Session Owner Email alert</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Send_an_email_to_owner_when_course_session_is_created</template>
    </alerts>
    <rules>
        <fullName>QPMS__Refresher Period Notice Notification to Owner</fullName>
        <actions>
            <name>QPMS__Refresher_Period_Notice_Notification_to_Owner</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND( OR(ISPICKVAL(QPMS__Status__c , &apos;Completed&apos;),ISPICKVAL(QPMS__Status__c, &apos;Cancelled&apos;) ), NOT(ISNULL(QPMS__Course__r.QPMS__Refresher_Period_Days__c)),  QPMS__Refresher_period_notification__c == TODAY() )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Send an email to owner when course session is created</fullName>
        <actions>
            <name>QPMS__Session_Owner_Email_alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>OR(ISPICKVAL(  QPMS__Status__c , &apos;Draft&apos;) , AND(ISPICKVAL(   QPMS__CourseType__c , &apos;Document&apos;),ISPICKVAL(  QPMS__Status__c , &apos;In Session&apos;)) ,AND(ISPICKVAL(   QPMS__CourseType__c , &apos;Instructor Led&apos;),ISPICKVAL(  QPMS__Status__c , &apos;Open Enrollment&apos;)))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
