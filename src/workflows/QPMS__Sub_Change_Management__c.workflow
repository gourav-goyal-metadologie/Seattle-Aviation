<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__Send_email_when_Action_Plan_is_Assigned</fullName>
        <description>Send email when Action Plan is Assigned</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CR_Action_Plan_assigned</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Send_email_when_Action_plan_is_completed</fullName>
        <description>Send email when Action plan is completed</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CR_Action_Plan_complete</template>
    </alerts>
    <rules>
        <fullName>QPMS__Send email when Action Plan is Completed</fullName>
        <actions>
            <name>QPMS__Send_email_when_Action_plan_is_completed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__Sub_Change_Management__c.QPMS__Status__c</field>
            <operation>equals</operation>
            <value>Document Change Order</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Sub_Change_Management__c.QPMS__General_Task_RecordType__c</field>
            <operation>equals</operation>
            <value>DocumentChange</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Sub_Change_Management__c.QPMS__General_Task_status__c</field>
            <operation>equals</operation>
            <value>Closed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Send email when Action plan is assigned</fullName>
        <actions>
            <name>QPMS__Send_email_when_Action_Plan_is_Assigned</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__Sub_Change_Management__c.QPMS__Change_Management_Status__c</field>
            <operation>equals</operation>
            <value>Document Change Order</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Sub_Change_Management__c.QPMS__General_Task_RecordType__c</field>
            <operation>equals</operation>
            <value>DocumentChange</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Sub_Change_Management__c.QPMS__General_Task_status__c</field>
            <operation>equals</operation>
            <value>Pending Action Completion</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
