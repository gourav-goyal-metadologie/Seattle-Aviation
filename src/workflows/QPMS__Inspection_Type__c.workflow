<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__InspectionType_Creation</fullName>
        <description>InspectionType Creation</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Inspection_InspectionType_Creation</template>
    </alerts>
    <rules>
        <fullName>QPMS__Send Email When InspectionType is Created</fullName>
        <actions>
            <name>QPMS__InspectionType_Creation</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__Inspection_Type__c.QPMS__Status__c</field>
            <operation>equals</operation>
            <value>Draft</value>
        </criteriaItems>
        <description>email will sent when InspectionType is created</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
