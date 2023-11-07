<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__Email_To_Custodian_to_notify_Owner_Change</fullName>
        <description>Email To Custodian to notify Owner Change</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Asset_Profile_Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Maintenance_Record_Owner_Change</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Maintenance_Approval_Assignment</fullName>
        <description>Maintenance Approval Assignment</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Maintenance_Approval</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Maintenance_Approved</fullName>
        <description>Maintenance Approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Maintenance_Approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Maintenance_Change_Duedate_Approved</fullName>
        <description>Maintenance Change Duedate Approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Maintenance_Change_Duedate_Approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Maintenance_Change_Duedate_Assignment</fullName>
        <description>Maintenance Change Duedate Assignment</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Maintenance_Change_Duedate_Assignment</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Maintenance_Change_Duedate_Recalled</fullName>
        <description>Maintenance Change Duedate Recalled</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Maintenance_Change_Duedate_Recall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Maintenance_Change_Duedate_Rejected</fullName>
        <description>Maintenance Change Duedate Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Maintenance_Change_Duedate_Reject</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Maintenance_Change_Owner_Approved</fullName>
        <description>Maintenance Change Owner Approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Maintenance_Change_Owner_Approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Maintenance_Change_Owner_Asssignment</fullName>
        <description>Maintenance Change Owner Asssignment</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Maintenance_Change_Owner_Assignment</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Maintenance_Change_Owner_Recalled</fullName>
        <description>Maintenance Change Owner Recalled</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Maintenance_Change_Owner_Recall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Maintenance_Change_Owner_Rejected</fullName>
        <description>Maintenance Change Owner Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Maintenance_Change_Owner_Reject</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Maintenance_Recalled</fullName>
        <description>Maintenance Recalled</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Maintenance_Recall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Maintenance_Record_Owner_Changed</fullName>
        <description>Maintenance Record Owner Changed</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Maintenance_Record_Owner_Changed</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Maintenance_Rejected</fullName>
        <description>Maintenance Rejected</description>
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
        <template>QPMS__Qualityze_Emails/QPMS__Maintenance_Reject</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Maintenance_Sending_mail_to_custodian_when_Owner_is_Changed</fullName>
        <description>Maintenance:Sending mail to custodian when Owner is Changed</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Asset_Profile_Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Maintenance_Record_Owner_Change</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Send_email_when_Maintenance_Record_is_Created</fullName>
        <description>Send email when Maintenance Record is Created</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Maintenance_Creation</template>
    </alerts>
    <fieldUpdates>
        <fullName>QPMS__Change_Status_Approved</fullName>
        <description>Change Status Approved</description>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Approved</literalValue>
        <name>Change Status Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Change_Status_Pending_Approval</fullName>
        <description>Change Status Pending Approval</description>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Change Status Pending Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Change_Status_Recalled</fullName>
        <description>Change Status Recalled</description>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Recall</literalValue>
        <name>Change Status Recalled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Change_Status_Rejected</fullName>
        <description>Change Status Rejected</description>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Rejected</literalValue>
        <name>Change Status Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__UpdateApprovalProcessField</fullName>
        <description>UpdateApprovalProcessField</description>
        <field>QPMS__ApprovalProcess__c</field>
        <literalValue>Change Due Date</literalValue>
        <name>UpdateApprovalProcessField</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__UpdateChangeFieldApprovalStatus</fullName>
        <description>UpdateChangeFieldApprovalStatus</description>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>UpdateChangeFieldApprovalStatus</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__UpdateChangeFieldApprovalStatusApproved</fullName>
        <description>UpdateChangeFieldApprovalStatusApproved</description>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Approved</literalValue>
        <name>UpdateChangeFieldApprovalStatusApproved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__UpdateChangeFieldApprovalStatusRecalled</fullName>
        <description>UpdateChangeFieldApprovalStatusRecalled</description>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Recall</literalValue>
        <name>UpdateChangeFieldApprovalStatusRecalled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__UpdateChangeFieldApprovalStatusRejected</fullName>
        <description>UpdateChangeFieldApprovalStatusRejected</description>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Rejected</literalValue>
        <name>UpdateChangeFieldApprovalStatusRejected</name>
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
        <description>Update Status As In Review</description>
        <field>QPMS__Status__c</field>
        <literalValue>In Review</literalValue>
        <name>Update Status As In Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>QPMS__Maintenance Creation Email</fullName>
        <actions>
            <name>QPMS__Send_email_when_Maintenance_Record_is_Created</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__Maintenance__c.QPMS__Status__c</field>
            <operation>equals</operation>
            <value>Draft</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Maintenance%3ASend mail to Custodian when Owner is Changed</fullName>
        <actions>
            <name>QPMS__Maintenance_Record_Owner_Changed</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>QPMS__Maintenance_Sending_mail_to_custodian_when_Owner_is_Changed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( OwnerId )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
