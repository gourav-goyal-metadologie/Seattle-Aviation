<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__Approval_Status_Rejected</fullName>
        <description>Approval Status Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver_1__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver_2__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver_3__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver_4__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver_5__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver_6__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver_7__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver_8__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver_9__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Audit_Reject</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Audit_Email_Notification</fullName>
        <description>Audit Email Notification</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Audit_Creation</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Audit_Record_Approved</fullName>
        <description>Audit Record Approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Lead_Auditor__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Audit_Record_Approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Audit_Record_Created</fullName>
        <description>Audit Record Created</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Lead_Auditor__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Audit_Creation</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Audit_Record_Recalles</fullName>
        <description>Audit Record Recalled</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver_1__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver_2__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver_3__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver_4__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver_5__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver_6__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver_7__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver_8__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver_9__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__Lead_Auditor__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Audit_Recall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Notify_New_Lead_Auditor_Upon_Approved</fullName>
        <description>Notify New Lead Auditor Upon Approved</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__New_Lead_Auditor__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Audit_Lead_Auditor_Assigned_Email</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Notify_when_change_Lead_Auditor_is_Recalled</fullName>
        <description>Notify when change Lead Auditor is Recalled</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Audit_Change_Lead_Auditor_Recall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Notify_when_change_Lead_Auditor_is_Rejected</fullName>
        <description>Notify when change Lead Auditor is Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Audit_Change_Lead_Auditor_Rejected</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Notify_when_change_Lead_Auditor_is_approved</fullName>
        <description>Notify when change  Lead Auditor is approved</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Lead_Auditor__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Audit_Change_Lead_Auditor_Approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Observation_Approval_Recall</fullName>
        <description>Observation Approval Recall</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Audit_Recall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Observation_Approval_Rejection</fullName>
        <description>Observation Approval Rejection</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Lead_Auditor__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Audit_Reject</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Observation_Record_Approved</fullName>
        <description>Observation Record Approved</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Audit_Record_Approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__On_Audit_creation_with_particular_Lead_Auditor</fullName>
        <description>On Audit creation with particular Lead Auditor</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Lead_Auditor__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Audit_Lead_Auditor_Email</template>
    </alerts>
    <fieldUpdates>
        <fullName>QPMS__ApprovalProcessComp</fullName>
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
        <field>QPMS__Approval_Required__c</field>
        <literalValue>1</literalValue>
        <name>ApprovalRequiredUpdate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Approval_process</fullName>
        <field>QPMS__ApprovalProcess__c</field>
        <literalValue>Change Lead Auditor</literalValue>
        <name>Approval process</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Audit_Approval_Process</fullName>
        <description>Audit Approval Process</description>
        <field>QPMS__ApprovalProcess__c</field>
        <literalValue>Audit</literalValue>
        <name>Audit Approval Process</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Audit_unLock_Record</fullName>
        <description>unLock_Record by un checking isLocke</description>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>Audit unLock Record</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Audit_unLock_Record_in_Recall</fullName>
        <description>unLock_Record by un checking isLocke</description>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>Audit unLock_Record in Recall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Audit_unLock_Records</fullName>
        <description>unLock_Record by un checking isLocke</description>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>Audit unLock_Record</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ChangeFieldApprovalStatusToApproved</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Approved</literalValue>
        <name>ChangeFieldApprovalStatusToApproved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ChangeFieldApprovalStatusToPending</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>ChangeFieldApprovalStatusToPending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ChangeFieldApprovalStatus_Recalled</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Recall</literalValue>
        <name>ChangeFieldApprovalStatus Recalled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ChangeFieldApprovalStatus_Rejected</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Rejected</literalValue>
        <name>ChangeFieldApprovalStatus Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ChangeFieldStatus</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Approved</literalValue>
        <name>ChangeFieldStatus</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Change_Audit_Status</fullName>
        <description>Change audit status to inreview</description>
        <field>QPMS__Status__c</field>
        <literalValue>In-Review</literalValue>
        <name>Change Audit Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Change_Audit_Status_On_Recall</fullName>
        <description>Change Audit Status On Recall</description>
        <field>QPMS__Status__c</field>
        <literalValue>InProgress</literalValue>
        <name>Change Audit Status On Recall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Change_Audit_Status_Rejected</fullName>
        <description>Change Status Rejected</description>
        <field>QPMS__Status__c</field>
        <literalValue>InProgress</literalValue>
        <name>Change Audit Status Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Change_Observation_Recall_Status</fullName>
        <description>Change Observation Status for Recall</description>
        <field>QPMS__Observation_Approval__c</field>
        <literalValue>Recall</literalValue>
        <name>Change Observation Recall Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Change_Observation_Reject_Status</fullName>
        <description>Change Observation Reject Approval Status</description>
        <field>QPMS__Observation_Approval__c</field>
        <literalValue>Rejected</literalValue>
        <name>Change Observation Reject Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Change_Reject_Approval_status</fullName>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Change Reject Approval status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Change_Status_For_Recall</fullName>
        <description>Change Status</description>
        <field>QPMS__Status__c</field>
        <literalValue>Draft</literalValue>
        <name>Change Status For Recall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Change_Status_On_Recall</fullName>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Recall</literalValue>
        <name>Change Status On Recall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Change_Status_Rejected</fullName>
        <description>Audit record rejected</description>
        <field>QPMS__Status__c</field>
        <literalValue>Draft</literalValue>
        <name>Change Status Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Initial_Observation_Approval_Status</fullName>
        <description>Initial observation approval status</description>
        <field>QPMS__Observation_Approval__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Initial Observation Approval Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Initial_Submission_Change_Status</fullName>
        <field>QPMS__Status__c</field>
        <literalValue>In-Review</literalValue>
        <name>Initial Submission Change Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Lock_Audit_Record</fullName>
        <field>QPMS__isLocked__c</field>
        <literalValue>1</literalValue>
        <name>Lock Audit Record</name>
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
        <fullName>QPMS__Lock_Record_Observation_Process</fullName>
        <field>QPMS__isLocked__c</field>
        <literalValue>1</literalValue>
        <name>Lock Record Observation Process</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Observation_ApprovalProcessComplete</fullName>
        <description>Observation ApprovalProcessComplete</description>
        <field>QPMS__Approval_Process_Complete__c</field>
        <literalValue>0</literalValue>
        <name>Observation ApprovalProcessComplete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Observation_Approval_Process</fullName>
        <field>QPMS__ApprovalProcess__c</field>
        <literalValue>Audit Observation Approval</literalValue>
        <name>Observation Approval Process</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Observation_Approval_Process_complete</fullName>
        <field>QPMS__Approval_Process_Complete__c</field>
        <literalValue>0</literalValue>
        <name>Observation Approval Process complete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Observation_onrecallSequenceNumber</fullName>
        <description>On recall field to update</description>
        <field>QPMS__CurrentApprovalSequenceNumber__c</field>
        <formula>99999</formula>
        <name>Observation onrecallSequenceNumber</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Observation_onrejectionSequenceNumber</fullName>
        <description>Observation onrejectionSequenceNumber</description>
        <field>QPMS__CurrentApprovalSequenceNumber__c</field>
        <formula>999999</formula>
        <name>Observation onrejectionSequenceNumber</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Observation_unLock_Record</fullName>
        <description>unLock_Record by un checking isLocke</description>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>Observation unLock Record</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Observation_unLock_Record_in_Recall</fullName>
        <description>Observation  unLock Record in Recall</description>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>Observation  unLock Record in Recall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Observation_unLock_Records</fullName>
        <description>Observation unLock Record</description>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>Observation unLock Record</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Recall_Change_Status</fullName>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Recall</literalValue>
        <name>Recall Change Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Reject_Change_Status</fullName>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Reject Change Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Unlock_Audit_Record</fullName>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>Unlock Audit Record</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Unlock_Audit_Record_After_Recall</fullName>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>Unlock Audit Record After Recall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Unlock_Audit_Record_After_Reject</fullName>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>Unlock Audit Record After Reject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_Initiated_Date</fullName>
        <description>Update Initiated Date</description>
        <field>QPMS__Initiated_Date__c</field>
        <formula>Now()</formula>
        <name>Update Initiated Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__esr</fullName>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>esr</name>
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
        <fullName>QPMS__initial_change_status</fullName>
        <description>Change Status</description>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>initial change status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__onrecallSequenceNumber</fullName>
        <description>On recall field to update</description>
        <field>QPMS__CurrentApprovalSequenceNumber__c</field>
        <formula>99999</formula>
        <name>onrecallSequenceNumber</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__onrejectionSequenceNumber</fullName>
        <field>QPMS__CurrentApprovalSequenceNumber__c</field>
        <formula>999999</formula>
        <name>onrejectionSequenceNumber</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__unLock_Record</fullName>
        <description>unLock_Record by un checking isLocke</description>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>unLock_Record</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>QPMS__Audit Creation Email</fullName>
        <actions>
            <name>QPMS__On_Audit_creation_with_particular_Lead_Auditor</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>QPMS__Audit__c.QPMS__Status__c</field>
            <operation>equals</operation>
            <value>Draft</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Audit__c.QPMS__Lead_Auditor_Name__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>send an email to lead Auditor upon Audit Creation</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Audit Email Created</fullName>
        <actions>
            <name>QPMS__Audit_Email_Notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__Audit__c.QPMS__Status__c</field>
            <operation>equals</operation>
            <value>Draft</value>
        </criteriaItems>
        <description>Audit Email Notification to Owner</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Audit Initiated Date</fullName>
        <actions>
            <name>QPMS__Update_Initiated_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Audit Initiated Date</description>
        <formula>AND( TEXT(QPMS__Status__c) ==&apos;Draft&apos;,ISBLANK( QPMS__Initiated_Date__c))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Overdue Approval</fullName>
        <active>false</active>
        <criteriaItems>
            <field>QPMS__Audit__c.QPMS__End_Date__c</field>
            <operation>notEqual</operation>
            <value>TODAY</value>
        </criteriaItems>
        <description>Overdue Approval</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
