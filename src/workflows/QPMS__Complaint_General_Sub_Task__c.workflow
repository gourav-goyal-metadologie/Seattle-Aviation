<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__Email_alert_when_Complaint_Action_Plan_is_in_Pending</fullName>
        <description>Email alert when Complaint Action Plan is in Pending</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Assigned_User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Complaint_Action_Plan_Status_update_as_Pending</template>
    </alerts>
    <fieldUpdates>
        <fullName>QPMS__Completed_Status</fullName>
        <description>Complaint Completed Status</description>
        <field>QPMS__Action_Plan_Status__c</field>
        <literalValue>Complete</literalValue>
        <name>Completed Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Pending_Status</fullName>
        <description>Complaint Action PLan Pending Status</description>
        <field>QPMS__Action_Plan_Status__c</field>
        <literalValue>Pending</literalValue>
        <name>Pending Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>QPMS__Complaint Action Plan Status Update as Completed</fullName>
        <actions>
            <name>QPMS__Completed_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3</booleanFilter>
        <criteriaItems>
            <field>QPMS__Complaint_General_Sub_Task__c.QPMS__Completed__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Complaint_General_Sub_Task__c.QPMS__Pend_Save_ActionPlan__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Complaint_General_Sub_Task__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Action Plan</value>
        </criteriaItems>
        <description>Complaint Action Plan Status Update as Completed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Complaint Action Plan Status update as Pending</fullName>
        <actions>
            <name>QPMS__Pending_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__Complaint_General_Sub_Task__c.QPMS__Completed__c</field>
            <operation>equals</operation>
            <value>No</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Complaint_General_Sub_Task__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Action Plan</value>
        </criteriaItems>
        <description>Complaint Action Plan Status update as Pending</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Complaint Pending Action Plan%2E</fullName>
        <actions>
            <name>QPMS__Email_alert_when_Complaint_Action_Plan_is_in_Pending</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Email for Complaint Pending Action Plan.</description>
        <formula>AND(OR( AND( QPMS__Complaint_General_Task__r.QPMS__Approval_Process_Complete__c , AND( ISPICKVAL(QPMS__Completed__c,&apos;No&apos;),QPMS__Complaint_General_Task__r.RecordType.DeveloperName ==&apos;Investigation&apos; ) , ISPICKVAL(QPMS__Submit_WithOut_Approval__c ,&apos;NO&apos;)),AND(ISPICKVAL( QPMS__Complaint_General_Task__r.QPMS__Approval_Required__c,&apos;No&apos;), OR( AND( ISPICKVAL(QPMS__Completed__c,&apos;No&apos;),QPMS__Complaint_General_Task__r.RecordType.DeveloperName ==&apos;Investigation&apos; )),ISPICKVAL(QPMS__Submit_WithOut_Approval__c ,&apos;Yes&apos;),ISPICKVAL( QPMS__Complaint_General_Task__r.QPMS__isSubmitted__c ,&apos;True&apos;)) ) , RecordType.DeveloperName == &apos;Action_Plan&apos; )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
