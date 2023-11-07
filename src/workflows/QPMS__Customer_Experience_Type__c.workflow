<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__CEM_Type_Approval_Recall</fullName>
        <description>CEM Type Approval Recall</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CEM_Type_Recall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__CEM_Type_Approval_Rejection</fullName>
        <description>CEM Type Approval Rejection</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CEM_Type_Reject</template>
    </alerts>
    <alerts>
        <fullName>QPMS__CEM_Type_Record_Approved</fullName>
        <description>CEM Type Record Approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CEM_Type_Record_Approved</template>
    </alerts>
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
        <fullName>QPMS__Change_approval_process</fullName>
        <field>QPMS__ApprovalProcess__c</field>
        <literalValue>CEMTypeStatusChange</literalValue>
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
        <formula>99999</formula>
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
        <fullName>QPMS__change_status</fullName>
        <description>To change any status from in review</description>
        <field>QPMS__Status__c</field>
        <literalValue>In-Review</literalValue>
        <name>change status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__custom_recordlock</fullName>
        <description>To enable and disable the audit type page fields</description>
        <field>QPMS__isDisabled__c</field>
        <literalValue>1</literalValue>
        <name>custom recordlock</name>
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
</Workflow>
