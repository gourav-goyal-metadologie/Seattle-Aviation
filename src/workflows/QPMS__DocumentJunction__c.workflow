<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__Read_and_Sign_off_for_doc</fullName>
        <description>Read and Sign off for doc</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Read_and_Sign_off_for_doc</template>
    </alerts>
    <rules>
        <fullName>QPMS__Read and Sign off for doc</fullName>
        <actions>
            <name>QPMS__Read_and_Sign_off_for_doc</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2 OR 3) AND 4 AND 5</booleanFilter>
        <criteriaItems>
            <field>QPMS__DocumentJunction__c.QPMS__Parent_Status__c</field>
            <operation>equals</operation>
            <value>Current</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__DocumentJunction__c.QPMS__Parent_Status__c</field>
            <operation>equals</operation>
            <value>Prereleased</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__DocumentJunction__c.QPMS__Parent_Status__c</field>
            <operation>equals</operation>
            <value>Prerelease</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__DocumentJunction__c.QPMS__Doc_Training_Status__c</field>
            <operation>notEqual</operation>
            <value>Completed</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__DocumentJunction__c.QPMS__Type__c</field>
            <operation>equals</operation>
            <value>DocumentTraining</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
