<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__Email_alert_when_Action_Plan_is_in_Pending</fullName>
        <description>Email alert when Action Plan is in Pending</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Assigned_User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Email_for_Action_Plan_Status_update_as_Pending</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_alert_when_disposition_is_in_pending_status</fullName>
        <description>Email alert when disposition is in pending status</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Assigned_User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Pending_Disposition</template>
    </alerts>
    <fieldUpdates>
        <fullName>QPMS__Cause_Code_Name_Update</fullName>
        <field>QPMS__Cause_Code_Search__c</field>
        <formula>QPMS__Cause_Code__r.Name</formula>
        <name>Cause Code Name Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Completed_Status</fullName>
        <description>Completed Status</description>
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
        <field>QPMS__Action_Plan_Status__c</field>
        <literalValue>Pending</literalValue>
        <name>Pending Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__update_action_plan_status_skipped</fullName>
        <description>update action plan status skipped</description>
        <field>QPMS__Action_Plan_Status__c</field>
        <literalValue>Skipped</literalValue>
        <name>update action plan status skipped</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>QPMS__Action Plan Status Update as Completed</fullName>
        <actions>
            <name>QPMS__Completed_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 4 )AND 2 AND 3</booleanFilter>
        <criteriaItems>
            <field>QPMS__General_Sub_Task__c.QPMS__Complete__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__General_Sub_Task__c.QPMS__Pend_Save_ActionPlan__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__General_Sub_Task__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Action Plan</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__General_Sub_Task__c.QPMS__Completed__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <description>Action Plan Status Update as Completed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Action Plan Status Update as Skipped</fullName>
        <actions>
            <name>QPMS__update_action_plan_status_skipped</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__General_Sub_Task__c.QPMS__Completed__c</field>
            <operation>equals</operation>
            <value>Skipped</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__General_Sub_Task__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Action Plan</value>
        </criteriaItems>
        <description>Action Plan Status Update as Skipped</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Action Plan Status update as Pending</fullName>
        <actions>
            <name>QPMS__Pending_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 3) AND 2 AND 4</booleanFilter>
        <criteriaItems>
            <field>QPMS__General_Sub_Task__c.QPMS__Complete__c</field>
            <operation>equals</operation>
            <value>No</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__General_Sub_Task__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Action Plan</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__General_Sub_Task__c.QPMS__Completed__c</field>
            <operation>equals</operation>
            <value>No</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__General_Sub_Task__c.QPMS__Parent_Task__c</field>
            <operation>notEqual</operation>
            <value>Functional_Task</value>
        </criteriaItems>
        <description>Action Plan Status update as Pending</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Cause Code Update</fullName>
        <actions>
            <name>QPMS__Cause_Code_Name_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>NOT( ISNULL(QPMS__Cause_Code__c ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Functional Task Action Plan Status update as Pending</fullName>
        <actions>
            <name>QPMS__Pending_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__General_Sub_Task__c.QPMS__Complete__c</field>
            <operation>notEqual</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__General_Sub_Task__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Action Plan</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__General_Sub_Task__c.QPMS__Parent_Task__c</field>
            <operation>equals</operation>
            <value>Functional_Task</value>
        </criteriaItems>
        <description>Functional Task Action Plan Status update as Pending</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Pending Action Plan%2E</fullName>
        <actions>
            <name>QPMS__Email_alert_when_Action_Plan_is_in_Pending</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Email for Pending Action Plan.</description>
        <formula>AND(OR( AND( QPMS__General_Task__r.QPMS__Approval_Process_Complete__c ,OR(AND(ISPICKVAL(QPMS__Completed__c,&apos;No&apos;), QPMS__General_Task__r.RecordType.DeveloperName == &apos;Response_Task&apos;),AND(ISPICKVAL(QPMS__Complete__c,&apos;No&apos;),QPMS__General_Task__r.RecordType.DeveloperName == &apos;Implementation&apos;),AND( NOT(ISPICKVAL(QPMS__Complete__c,&apos;Yes&apos;)),QPMS__General_Task__r.RecordType.DeveloperName ==&apos;Functional_Task&apos; )),ISPICKVAL(QPMS__Submit_WithOut_Approval__c ,&apos;NO&apos;)),AND(ISPICKVAL( QPMS__General_Task__r.QPMS__Approval_Required__c,&apos;No&apos;),OR(AND(ISPICKVAL(QPMS__Completed__c,&apos;No&apos;), QPMS__General_Task__r.RecordType.DeveloperName == &apos;Response_Task&apos;),AND(ISPICKVAL(QPMS__Complete__c,&apos;No&apos;) , QPMS__General_Task__r.RecordType.DeveloperName ==&apos;Implementation&apos;),AND( NOT(ISPICKVAL(QPMS__Complete__c,&apos;Yes&apos;)),QPMS__General_Task__r.RecordType.DeveloperName ==&apos;Functional_Task&apos; )),ISPICKVAL(QPMS__Submit_WithOut_Approval__c ,&apos;Yes&apos;),ISPICKVAL( QPMS__General_Task__r.QPMS__isSubmitted__c ,&apos;True&apos;)) ) , RecordType.DeveloperName == &apos;Action_Plan&apos; )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Pending Disposition</fullName>
        <actions>
            <name>QPMS__Email_alert_when_disposition_is_in_pending_status</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(OR(AND(QPMS__General_Task__r.QPMS__Approval_Process_Complete__c ,  ISPICKVAL(QPMS__Disposition_Type_Status__c , &apos;Pending&apos;) , ISPICKVAL(QPMS__Approval_Completed__c,&apos;Yes&apos;) ), AND(  ISPICKVAL(QPMS__General_Task__r.QPMS__Approval_Required__c,&apos;No&apos;) ,ISPICKVAL(QPMS__Disposition_Type_Status__c , &apos;Pending&apos;), ISPICKVAL(QPMS__General_Task__r.QPMS__isSubmitted__c,&apos;True&apos;) ,ISPICKVAL(QPMS__Approval_Completed__c,&apos;No&apos;)) ),  RecordType.DeveloperName == &apos;Disposition_Section&apos; )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
