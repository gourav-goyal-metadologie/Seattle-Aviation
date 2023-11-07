<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__CSMS_Change_Task_Owner_Recalled</fullName>
        <description>CSMS Change Task Owner Recalled</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CSMS_Change_Task_Owner_Recall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__CSMS_Task_Approval_Assign</fullName>
        <description>CSMS Task Approval Assign</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CSMS_Change_Task_Owner_Approval</template>
    </alerts>
    <alerts>
        <fullName>QPMS__CSMS_Task_Approval_Assignment</fullName>
        <description>CSMS Task Approval Assignment</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CSMS_Task_Approval_Request</template>
    </alerts>
    <alerts>
        <fullName>QPMS__CSMS_Task_Approval_Recalled</fullName>
        <description>CSMS Task Approval Recalled</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CSMS_Task_Approval_Recalled</template>
    </alerts>
    <alerts>
        <fullName>QPMS__CSMS_Task_Approval_Rejected</fullName>
        <description>CSMS Task Approval Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CSMS_Task_Approval_Rejected</template>
    </alerts>
    <alerts>
        <fullName>QPMS__CSMS_Task_Approved</fullName>
        <description>CSMS Task Approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CSMS_Task_Approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__CSMS_Task_Change_Duedate_Approval_Assignment</fullName>
        <description>CSMS Task Change Duedate Approval Assignment</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CSMS_Change_Duedate_Approval_Assignment</template>
    </alerts>
    <alerts>
        <fullName>QPMS__CSMS_Task_Change_Duedate_Approved</fullName>
        <description>CSMS Task Change Duedate Approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CSMS_Task_Change_Duedate_Approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__CSMS_Task_Change_Duedate_Recalled</fullName>
        <description>CSMS Task Change Duedate Recalled</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CSMS_Task_Change_Duedate_Recall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__CSMS_Task_Change_Owner_Rejected</fullName>
        <description>CSMS Task Change Owner Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CSMS_Task_Change_Owner_Reject</template>
    </alerts>
    <alerts>
        <fullName>QPMS__CSMS_Task_Chnge_Duedate_Rejected</fullName>
        <description>CSMS Task Chnge Duedate Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CSMS_Task_Change_Duedate_Reject</template>
    </alerts>
    <alerts>
        <fullName>QPMS__CSMS_Task_Owner_Change_Approved</fullName>
        <description>CSMS Task Owner Change Approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CSMS_Change_Task_Owner_Approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__CSMS_Task_Owner_change</fullName>
        <description>CSMS Task Owner change</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CSMS_Task_Owner_Change</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_Alert_to_CSMS_Task_Owner_Upon_CSMS_Creation</fullName>
        <description>Email Alert to CSMS Task Owner Upon CSMS Creation</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Calibration_Task_Creation</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_Alert_to_CSMS_Task_Owner_Upon_Maintenance_Task_Creation</fullName>
        <description>Email Alert to CSMS Task Owner Upon Maintenance Task Creation</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Calibration_Task_Creation</template>
    </alerts>
    <fieldUpdates>
        <fullName>QPMS__CurrentApprovalSequenceNumberRecall</fullName>
        <description>Update currentApprovalSequenceNumber</description>
        <field>QPMS__CurrentApprovalSequenceNumber__c</field>
        <formula>999999</formula>
        <name>CurrentApprovalSequenceNumberRecall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__CurrentApprovalSequenceNumberReject</fullName>
        <description>Update CurrentApprovalSequenceNumber</description>
        <field>QPMS__CurrentApprovalSequenceNumber__c</field>
        <formula>99999</formula>
        <name>CurrentApprovalSequenceNumberReject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__UpdateApprovalProcessComplete</fullName>
        <description>UpdateApprovalProcessComplete</description>
        <field>QPMS__Approval_Process_Complete__c</field>
        <literalValue>0</literalValue>
        <name>UpdateApprovalProcessComplete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__UpdateChangeFieldAsApproved</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Approved</literalValue>
        <name>UpdateChangeFieldAsApproved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__UpdateChangeFieldAsPendingApproval</fullName>
        <description>UpdateChangeFieldStatusAsPendingApproval</description>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>UpdateChangeFieldAsPendingApproval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__UpdateChangeFieldAsRecall</fullName>
        <description>UpdateChangeFieldAsRecall</description>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Recall</literalValue>
        <name>UpdateChangeFieldAsRecall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__UpdateChangeFieldAsRejected</fullName>
        <description>UpdateChangeFieldAsRejected</description>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Rejected</literalValue>
        <name>UpdateChangeFieldAsRejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__UpdateChangeFieldStatusAsApproved</fullName>
        <description>UpdateChangeFieldStatusAsApproved</description>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Approved</literalValue>
        <name>UpdateChangeFieldStatusAsApproved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__UpdateChangeFieldStatusAsPendingApproval</fullName>
        <description>UpdateChangeFieldStatusAsPendingApproval</description>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>UpdateChangeFieldStatusAsPendingApproval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__UpdateChangeFieldStatusAsRecalled</fullName>
        <description>UpdateChangeFieldStatusAsRecalled</description>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Recall</literalValue>
        <name>UpdateChangeFieldStatusAsRecalled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__UpdateChangeFieldStatusAsRejected</fullName>
        <description>UpdateChangeFieldStatusAsRejected</description>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Rejected</literalValue>
        <name>UpdateChangeFieldStatusAsRejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__UpdateCurrentApprovalSeqOnApproved</fullName>
        <field>QPMS__CurrentApprovalSequenceNumber__c</field>
        <name>UpdateCurrentApprovalSeqOnApproved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__UpdateCurrentApprovalSeqOnSubmission</fullName>
        <field>QPMS__CurrentApprovalSequenceNumber__c</field>
        <name>UpdateCurrentApprovalSeqOnSubmission</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_Approval_Status_Approved</fullName>
        <description>Update Approval Status Approved</description>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Update Approval Status Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_Approval_Status_As_Pending</fullName>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Update Approval Status As Pending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_Approval_Status_Recall</fullName>
        <description>Update Approval Status Rejected</description>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Recall</literalValue>
        <name>Update Approval Status Recall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_Approval_Status_Rejected</fullName>
        <description>Update Approval Status Rejected</description>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Update Approval Status Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_Status_As_Closed</fullName>
        <description>Update Status As Closed</description>
        <field>QPMS__Status__c</field>
        <literalValue>Closed</literalValue>
        <name>Update Status As Closed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_Status_As_Open</fullName>
        <description>Update Status As Open</description>
        <field>QPMS__Status__c</field>
        <literalValue>Open</literalValue>
        <name>Update Status As Open</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_Status_Pending_Approval</fullName>
        <description>Update Status Pending Approval</description>
        <field>QPMS__Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Update Status Pending Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>QPMS__Email notification for task owner changed</fullName>
        <actions>
            <name>QPMS__CSMS_Task_Owner_change</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Email notification for task owner changed</description>
        <formula>AND(NOT(ISNULL( Id )),OwnerId != PRIORVALUE(OwnerId))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Send email to CSMS Maintenance Task owner upon CSMS Task Creation</fullName>
        <actions>
            <name>QPMS__Email_Alert_to_CSMS_Task_Owner_Upon_Maintenance_Task_Creation</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__CSMS_General_Task__c.QPMS__Maintenance_ID__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__CSMS_General_Task__c.QPMS__Status__c</field>
            <operation>equals</operation>
            <value>Open</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Send email to CSMS Task owner upon CSMS Task Creation</fullName>
        <actions>
            <name>QPMS__Email_Alert_to_CSMS_Task_Owner_Upon_CSMS_Creation</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__CSMS_General_Task__c.QPMS__Calibration_ID__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__CSMS_General_Task__c.QPMS__Status__c</field>
            <operation>equals</operation>
            <value>Open</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
