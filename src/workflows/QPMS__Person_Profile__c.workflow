<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__PersonProfileStatus</fullName>
        <description>PersonProfileStatus</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <recipients>
            <field>QPMS__Reports_To__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Person_Profile</template>
    </alerts>
    <rules>
        <fullName>QPMS__Person Profile</fullName>
        <actions>
            <name>QPMS__PersonProfileStatus</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__Person_Profile__c.QPMS__Status__c</field>
            <operation>equals</operation>
            <value>Active,Inactive,Draft</value>
        </criteriaItems>
        <description>Person Profile</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
