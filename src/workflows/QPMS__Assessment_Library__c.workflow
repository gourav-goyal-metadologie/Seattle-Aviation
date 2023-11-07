<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__On_Assesment_Failure_Send_Email_To_Manager</fullName>
        <description>On Assesment Failure Send Email To Manager</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__On_Assessment_Fail_Email_To_Manager</template>
    </alerts>
    <rules>
        <fullName>QPMS__On Assessment Fail</fullName>
        <actions>
            <name>QPMS__On_Assesment_Failure_Send_Email_To_Manager</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>QPMS__Assessment_Library__c.QPMS__Status__c</field>
            <operation>equals</operation>
            <value>Fail</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
