<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__Audit_Type_Approval_Recall</fullName>
        <description>Audit Type Approval Recall</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Audit_Type_Recall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Audit_Type_Approval_Rejection</fullName>
        <description>Audit Type Approval Rejection</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Audit_Type_Reject</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Audit_Type_Record_Approved</fullName>
        <description>Audit Type Record Approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Audit_Type_Record_Approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Audit_Type_Record_Creation</fullName>
        <description>Audit Type Record Creation</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Audit_Type_Creation</template>
    </alerts>
    <fieldUpdates>
        <fullName>QPMS__Approval_Process_Audit_Type</fullName>
        <description>To Change Approval Process field value to Audit Type</description>
        <field>QPMS__ApprovalProcess__c</field>
        <literalValue>AuditType</literalValue>
        <name>Approval Process Audit Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Approval_Status_Pending_Approval</fullName>
        <description>This field update changes Approval Status to Pending Approval</description>
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
        <description>To Change Approval Status upon Approval Recall</description>
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
        <description>To Change Approval Status to Reject</description>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Approval Status Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Approval_status_field_update</fullName>
        <field>QPMS__Status__c</field>
        <literalValue>Draft</literalValue>
        <name>Approval status field update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Approval_status_field_update_recall</fullName>
        <field>QPMS__Status__c</field>
        <literalValue>Draft</literalValue>
        <name>Approval status field update recall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Approval_status_update</fullName>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Approval status update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Audit_Status_Change</fullName>
        <field>QPMS__Status__c</field>
        <literalValue>Active</literalValue>
        <name>Audit Status Change</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Change_approval_process</fullName>
        <field>QPMS__ApprovalProcess__c</field>
        <literalValue>AuditTypeApproval</literalValue>
        <name>Change approval process</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__CurrentApprovalSequenceOnRecall</fullName>
        <description>To Change CurrentApprovalSequence flag to 99999 upon approval recall</description>
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
        <description>To Change isLocked flag to true when record is submitted for approval</description>
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
        <description>To Change isLocked flag to false upon approval</description>
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
        <description>To Change isLocked field to false upon Approval Recall</description>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>Custom Unlock Recall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__EnableRecord</fullName>
        <description>To make record enabled when rejection happened</description>
        <field>QPMS__isDisabled__c</field>
        <literalValue>0</literalValue>
        <name>EnableRecord</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__EnableRecordForRecall</fullName>
        <description>To make record enabled when recall happened</description>
        <field>QPMS__isDisabled__c</field>
        <literalValue>1</literalValue>
        <name>EnableRecordForRecall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__IsDisabledFinalApproval</fullName>
        <field>QPMS__isDisabled__c</field>
        <literalValue>1</literalValue>
        <name>IsDisabledFinalApproval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Status_change</fullName>
        <field>QPMS__Status__c</field>
        <literalValue>InReview</literalValue>
        <name>Status change</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__approval_complete</fullName>
        <field>QPMS__Approval_Status__c</field>
        <name>approval complete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__change_status</fullName>
        <description>To change any  status from  in review</description>
        <field>QPMS__Status__c</field>
        <literalValue>InReview</literalValue>
        <name>change status</name>
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
        <fullName>QPMS__field_update</fullName>
        <field>QPMS__Status__c</field>
        <literalValue>InReview</literalValue>
        <name>field update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__field_update_for_complete</fullName>
        <field>QPMS__Approval_Process_Completed__c</field>
        <literalValue>0</literalValue>
        <name>field update for complete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__isdisabled</fullName>
        <field>QPMS__isDisabled__c</field>
        <literalValue>1</literalValue>
        <name>isdisabled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__isdisabledFinalRecall</fullName>
        <field>QPMS__isDisabled__c</field>
        <literalValue>0</literalValue>
        <name>isdisabledFinalRecall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__isdisabledFinalRejection</fullName>
        <field>QPMS__isDisabled__c</field>
        <literalValue>0</literalValue>
        <name>isdisabledFinalRejection</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>QPMS__Audit Type Email Created</fullName>
        <actions>
            <name>QPMS__Audit_Type_Record_Creation</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__Audit_Type__c.QPMS__Status__c</field>
            <operation>equals</operation>
            <value>Draft</value>
        </criteriaItems>
        <description>Audit Type Email notification to Owner</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
