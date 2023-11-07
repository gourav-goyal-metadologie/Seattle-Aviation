<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__AuditProgram_Record_Approval</fullName>
        <description>AuditProgram Record Approval</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Audit_Program_Record_Approval</template>
    </alerts>
    <alerts>
        <fullName>QPMS__AuditProgram_Record_Recall</fullName>
        <description>AuditProgram Record Recall</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Audit_Program_Recall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__AuditProgram_Record_Reject</fullName>
        <description>AuditProgram Record Reject</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Audit_Program_Reject</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Audit_Program_Record_Approved</fullName>
        <description>Audit Program Record Approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Audit_Program_Record_Approval</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Audit_Program_Record_Creation</fullName>
        <description>Audit Program Record Creation</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Audit_Program_Record_Creation</template>
    </alerts>
    <fieldUpdates>
        <fullName>QPMS__ApprovalProcessComp</fullName>
        <description>ApprovalProcessComp</description>
        <field>QPMS__Approval_Process_Complete__c</field>
        <literalValue>0</literalValue>
        <name>ApprovalProcessComp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ApprovalProcessComplete</fullName>
        <description>ApprovalProcessComplete</description>
        <field>QPMS__Approval_Process_Complete__c</field>
        <literalValue>0</literalValue>
        <name>ApprovalProcessComplete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ApprovalProcessStarted</fullName>
        <description>ApprovalProcessStarted</description>
        <field>QPMS__Approval_Process_Complete__c</field>
        <literalValue>0</literalValue>
        <name>ApprovalProcessStarted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ApprovalRequiredUpdate</fullName>
        <description>ApprovalRequiredUpdate</description>
        <field>QPMS__Approval_Required__c</field>
        <literalValue>1</literalValue>
        <name>ApprovalRequiredUpdate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ApprovalStatus</fullName>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Approval Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Approval_Process_Audit_Program</fullName>
        <field>QPMS__ApprovalProcess__c</field>
        <literalValue>AuditProgram</literalValue>
        <name>Approval Process Audit Program</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Approval_Status_Pending_Approval</fullName>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Approval Status Pending Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Approval_Status_Recalled</fullName>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Recall</literalValue>
        <name>Approval Status Recalled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Approval_Status_Rejected</fullName>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Approval Status Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__AuditProgram_Approval_Process</fullName>
        <description>AuditProgram Approval Process</description>
        <field>QPMS__ApprovalProcess__c</field>
        <literalValue>AuditProgram</literalValue>
        <name>AuditProgram Approval Process</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Change_AuditProgram_Status</fullName>
        <description>Change AuditProgram Status  to inreview</description>
        <field>QPMS__Status__c</field>
        <literalValue>InReview</literalValue>
        <name>Change AuditProgram Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Change_Status</fullName>
        <field>QPMS__Status__c</field>
        <literalValue>InReview</literalValue>
        <name>Change Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Change_Status_In_Review</fullName>
        <description>To change any status from in review</description>
        <field>QPMS__Status__c</field>
        <literalValue>InReview</literalValue>
        <name>Change Status In Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Change_approval_process</fullName>
        <description>This is for to differentiate the approval process</description>
        <field>QPMS__ApprovalProcess__c</field>
        <literalValue>auditProgramApproval</literalValue>
        <name>Change approval process</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__CurrentApprovalSequenceOnRecall</fullName>
        <field>QPMS__CurrentApprovalSequenceNumber__c</field>
        <formula>99999</formula>
        <name>CurrentApprovalSequenceOnRecall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__CurrentApprovalSequenceOnRejection</fullName>
        <description>To change current approval sequence to 999999 on approval rejection</description>
        <field>QPMS__CurrentApprovalSequenceNumber__c</field>
        <formula>999999</formula>
        <name>CurrentApprovalSequenceOnRejection</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Custom_Lock</fullName>
        <field>QPMS__isLocked__c</field>
        <literalValue>1</literalValue>
        <name>Custom Lock</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Custom_Unlock</fullName>
        <description>To change isLocked flag to false when aproval is rejected</description>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>Custom Unlock</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Custom_Unlock_On_Approval</fullName>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>Custom Unlock On Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Custom_Unlock_Recall</fullName>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>Custom Unlock Recall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__EnableRecordForRecall</fullName>
        <field>QPMS__isDisabled__c</field>
        <literalValue>0</literalValue>
        <name>EnableRecordForRecall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Field_update_for_complete</fullName>
        <description>to change field value of approval process complete</description>
        <field>QPMS__Approval_Process_Completed__c</field>
        <literalValue>0</literalValue>
        <name>Field update for complete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Lock_Record</fullName>
        <description>Lock_Record by using  islock field</description>
        <field>QPMS__isLocked__c</field>
        <literalValue>1</literalValue>
        <name>Lock Record</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Recall_status</fullName>
        <field>QPMS__Status__c</field>
        <literalValue>Draft</literalValue>
        <name>Recall status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Status_Update_for_approval</fullName>
        <field>QPMS__Status__c</field>
        <literalValue>Draft</literalValue>
        <name>Status Update for approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Status_Update_recall</fullName>
        <field>QPMS__Status__c</field>
        <literalValue>Draft</literalValue>
        <name>Status Update recall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Status_update</fullName>
        <field>QPMS__Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Status update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__custom_recordlock</fullName>
        <field>QPMS__isDisabled__c</field>
        <literalValue>1</literalValue>
        <name>custom recordlock</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__initial_approval_status</fullName>
        <description>Change status</description>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>initial approval status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__isDisabled</fullName>
        <field>QPMS__isDisabled__c</field>
        <literalValue>0</literalValue>
        <name>isDisabled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>QPMS__Audit Program Created</fullName>
        <actions>
            <name>QPMS__Audit_Program_Record_Creation</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>QPMS__Audit_Program__c.QPMS__Status__c</field>
            <operation>equals</operation>
            <value>Draft</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Audit_Program__c.QPMS__Status__c</field>
            <operation>equals</operation>
            <value>Needs Review</value>
        </criteriaItems>
        <description>Email notification to Audit Program owner</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
