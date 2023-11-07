<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__Send_mail_when_expiration_date_is_reached</fullName>
        <description>Send mail when expiration date is reached</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__SP_Certification_Notification</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Send_mail_when_expiration_date_reached_30days_before</fullName>
        <description>Send mail when expiration date reached 30days before</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__SP_Certification_Notification_before_30_days</template>
    </alerts>
    <rules>
        <fullName>QPMS__Send mail when Expiration Date is reached</fullName>
        <actions>
            <name>QPMS__Send_mail_when_expiration_date_is_reached</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>QPMS__Expiration_Date__c = TODAY()</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
