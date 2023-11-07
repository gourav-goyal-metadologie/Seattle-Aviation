<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__Course_Profile_Record_Creation</fullName>
        <description>Course Profile Record Creation</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CourseProfileCreation</template>
    </alerts>
    <rules>
        <fullName>QPMS__Course Profile Email Creation</fullName>
        <actions>
            <name>QPMS__Course_Profile_Record_Creation</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__Course__c.QPMS__Status__c</field>
            <operation>equals</operation>
            <value>Draft</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
