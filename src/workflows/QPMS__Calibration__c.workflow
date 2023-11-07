<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__Calibration_Approval_Assignment</fullName>
        <description>Calibration Approval Assignment</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Calibration_Approval</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Calibration_Approved</fullName>
        <description>Calibration Approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Calibration_Approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Calibration_Change_Duedate_Approved</fullName>
        <description>Calibration Change Duedate Approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Calibration_Change_Duedate_Approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Calibration_Change_Duedate_Assignment</fullName>
        <description>Calibration Change Duedate Assignment</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Calibration_Change_Due_Date_Assignment</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Calibration_Change_Duedate_Recalled</fullName>
        <description>Calibration Change Duedate Recalled</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Calibration_Change_Duedate_Recall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Calibration_Change_Owner_Approved</fullName>
        <description>Calibration Change Owner Approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Calibration_Change_Owner_Approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Calibration_Change_Owner_Assignment</fullName>
        <description>Calibration Change Owner Assignment</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Calibration_Change_Owner_Assignment</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Calibration_Change_Owner_Recalled</fullName>
        <description>Calibration Change Owner Recalled</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Calibration_Change_Owner_Recall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Calibration_Change_Owner_Rejected</fullName>
        <description>Calibration Change Owner Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Calibration_Change_Owner_Reject</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Calibration_Duedate_Rejected</fullName>
        <description>Calibration Duedate Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Calibration_Change_Duedate_Reject</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Calibration_Recalled</fullName>
        <description>Calibration Recalled</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Calibration_Recall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Calibration_Record_Owner_Changed</fullName>
        <description>Calibration Record Owner Changed</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Calibration_Record_Owner_Changed</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Calibration_Rejected</fullName>
        <description>Calibration Rejected</description>
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
        <template>QPMS__Qualityze_Emails/QPMS__Calibration_Reject</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_To_Custodian_to_notify_Owner_Change</fullName>
        <description>Email To Custodian to notify Owner Change</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Asset_Profile_Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Calibration_Record_Owner_Change</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Send_email_when_Calibration_Record_is_Created</fullName>
        <description>Send email when Calibration Record is Created</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Calibration_Creation</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Sending_mail_to_custodian_when_Owner_is_Changed</fullName>
        <description>Sending mail to custodian when Owner is Changed</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Asset_Profile_Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Calibration_Record_Owner_Change</template>
    </alerts>
    <fieldUpdates>
        <fullName>QPMS__Approval_Process_Change_Owner</fullName>
        <description>Approval Process Change Owner</description>
        <field>QPMS__ApprovalProcess__c</field>
        <literalValue>Change Owner</literalValue>
        <name>Approval Process Change Owner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Pending_Approval</fullName>
        <description>Change Field Approval Status Pending Approval</description>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Pending Approval</name>
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
        <fullName>QPMS__UpdateCurrentSequenceUponRecall</fullName>
        <description>UpdateCurrentSequenceUponRecall</description>
        <field>QPMS__CurrentApprovalSequenceNumber__c</field>
        <formula>99999</formula>
        <name>UpdateCurrentSequenceUponRecall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__UpdateCurrentSequenceUponReject</fullName>
        <description>UpdateCurrentSequenceUponReject</description>
        <field>QPMS__CurrentApprovalSequenceNumber__c</field>
        <formula>999999</formula>
        <name>UpdateCurrentSequenceUponReject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_ApprovalProcessField</fullName>
        <description>Update the Approval Process field</description>
        <field>QPMS__ApprovalProcess__c</field>
        <literalValue>Change Due Date</literalValue>
        <name>Update ApprovalProcessField</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_Approval_Status_As_Approved</fullName>
        <description>Update Approval Status As Approved</description>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Update Approval Status As Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_Approval_Status_As_Pending</fullName>
        <description>Update Approval Status As Pending</description>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Update Approval Status As Pending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_Approval_Status_As_Recall</fullName>
        <description>Update Approval Status As Recall</description>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Recall</literalValue>
        <name>Update Approval Status As Recall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_Approval_Status_As_Rejected</fullName>
        <description>Update Approval Status As Rejected</description>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Update Approval Status As Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_ChangeFieldApprovalStatus</fullName>
        <description>Change Field Approval Status Pending Approval</description>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Update ChangeFieldApprovalStatus</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_ChangeFieldApprovalStatusApproved</fullName>
        <description>Update Change Field Approval Status to Approved</description>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Approved</literalValue>
        <name>Update ChangeFieldApprovalStatusApproved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_ChangeFieldApprovalStatusRecall</fullName>
        <description>Update Change Field Approval Status to Recall</description>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Recall</literalValue>
        <name>Update ChangeFieldApprovalStatusRecall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_ChangeFieldApprovalStatusRejected</fullName>
        <description>Update Change Field Approval Status to Rejected</description>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Rejected</literalValue>
        <name>Update ChangeFieldApprovalStatusRejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_Status_As_Draft</fullName>
        <description>Update Status As Draft</description>
        <field>QPMS__Status__c</field>
        <literalValue>Draft</literalValue>
        <name>Update Status As Draft</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_Status_As_Draft_Upon_Recall</fullName>
        <description>Update Status As Draft Upon Recall</description>
        <field>QPMS__Status__c</field>
        <literalValue>Draft</literalValue>
        <name>Update Status As Draft Upon Recall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_Status_As_In_Review</fullName>
        <field>QPMS__Status__c</field>
        <literalValue>In Review</literalValue>
        <name>Update Status As In Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>QPMS__Calibration Creation Email</fullName>
        <actions>
            <name>QPMS__Send_email_when_Calibration_Record_is_Created</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__Calibration__c.QPMS__Status__c</field>
            <operation>equals</operation>
            <value>Draft</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Calibration%3ASend mail to Custodian when Owner is Changed</fullName>
        <actions>
            <name>QPMS__Calibration_Record_Owner_Changed</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>QPMS__Sending_mail_to_custodian_when_Owner_is_Changed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( OwnerId )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
