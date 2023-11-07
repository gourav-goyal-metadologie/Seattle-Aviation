<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__JobFunction_Status_changed</fullName>
        <description>JobFunction Status changed</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__JobFunction_Active</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Jobfunction_created</fullName>
        <description>Jobfunction created</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__JobFunction_Draft</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Jobfunction_created1</fullName>
        <description>Jobfunction created</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__JobFunction_Draft</template>
    </alerts>
    <rules>
        <fullName>QPMS__JobFunction Status changed</fullName>
        <actions>
            <name>QPMS__JobFunction_Status_changed</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>QPMS__Job_Function__c.QPMS__Status__c</field>
            <operation>equals</operation>
            <value>Active,Inactive</value>
        </criteriaItems>
        <description>JobFunction Status changed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Jobfunction Created</fullName>
        <actions>
            <name>QPMS__Jobfunction_created1</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__Job_Function__c.QPMS__Status__c</field>
            <operation>equals</operation>
            <value>Draft</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
