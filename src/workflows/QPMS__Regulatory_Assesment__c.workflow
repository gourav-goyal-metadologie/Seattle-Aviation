<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__Email_Alert_for_regulatory_assessment_new_owner_assignment</fullName>
        <description>Email Alert for regulatory assessment new owner assignment</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Regulatory_Assessment_Task_Owner_Change</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_to_Approver_on_Recalling_Regulatory_Assessment_Due_Date</fullName>
        <description>Email to Approver on Recalling Regulatory Assessment Due Date</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__ComplaintRegulatoryAssessmentChangeDueDaterApprovalRecall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_to_Approver_on_Recalling_Regulatory_Assessment_Owner</fullName>
        <description>Email to Approver on Recalling Regulatory Assessment Owner</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__ComplaintRegulatoryAssessmentChangeOwnerApprovalRecall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_to_Complaint_Owner_and_RA_Owner_on_Approving_Task</fullName>
        <description>Email to Complaint Owner and RA Owner on Approving Task</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__ParentOwner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Regulatory_Assessment_Record_Approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_to_Complaint_Owner_and_RA_Owner_on_Rejecting_Task</fullName>
        <description>Email to Complaint Owner and RA Owner on Rejecting Task</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__ParentOwner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Regulatory_Assessment_Reject</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_to_Parent_Owner_and_Regulatory_Assessment_Owner_On_Approval_of_Change_Due</fullName>
        <description>Email to Parent Owner and Regulatory Assessment Owner On Approval of Change Due Date</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__ParentOwner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__RegulatoryAssessmentChangeOwnerApproved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_to_Parent_Owner_and_Regulatory_Assessment_Owner_On_Approval_of_Change_Owne</fullName>
        <description>Email to Parent Owner and Regulatory Assessment Owner On Approval of Change Owner</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__New_Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__ParentOwner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__RegulatoryAssessmentChangeOwnerApproved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_to_Parent_Owner_and_Regulatory_Assessment_Owner_On_Rejection_of_Change_Due</fullName>
        <description>Email to Parent Owner and Regulatory Assessment Owner On Rejection of Change Due Date</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__ParentOwner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__RegulatoryAssessmentChangeDueDateRejected</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_to_Parent_Owner_and_Regulatory_Assessment_Owner_On_Rejection_of_Change_Own</fullName>
        <description>Email to Parent Owner and Regulatory Assessment Owner On Rejection of Change Owner</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__ParentOwner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__RegulatoryAssessmentChangeOwnerRejected</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_to_Regulatory_Assessment_Owner</fullName>
        <description>Email to Regulatory Assessment Owner</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Regulatory_Assessment_Creation</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Regulatory_Assessment_Appr_Recall</fullName>
        <description>Regulatory Assessment Approval Recall</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Regulatory_Assessment_Recall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Regulatory_Assessment_Appr_Rejection</fullName>
        <description>Regulatory Assessment Approval Rejection</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Regulatory_Assessment_Reject</template>
    </alerts>
    <alerts>
        <fullName>QPMS__sends_an_email_when_Regulatory_Assessment_owner_changed_with_approval</fullName>
        <description>sends an email when Regulatory Assessment owner changed with approval</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__New_Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Regulatory_Assessment_Task_Owner_Change</template>
    </alerts>
    <fieldUpdates>
        <fullName>QPMS__ApprovalActOnChangeFieldOwner</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Reject</literalValue>
        <name>ApprovalActOnChangeFieldOwner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ApprovalActionOnChangeFieldOwner</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Approve</literalValue>
        <name>ApprovalActionOnChangeFieldOwner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Approval_Process_Due_Date</fullName>
        <description>Approval Process Due Date</description>
        <field>QPMS__ApprovalProcess__c</field>
        <literalValue>Change DueDate</literalValue>
        <name>Approval Process Due Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Approval_Process_Owner</fullName>
        <field>QPMS__ApprovalProcess__c</field>
        <literalValue>Change Owner</literalValue>
        <name>Approval Process Owner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Change_Owner</fullName>
        <field>QPMS__ApprovalProcess__c</field>
        <literalValue>Change Owner</literalValue>
        <name>Change Owner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Complaint_Regulatory_Assessment_Recall</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Recall</literalValue>
        <name>Complaint Regulatory Assessment Recall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Lock_Record</fullName>
        <field>QPMS__isLocked__c</field>
        <literalValue>1</literalValue>
        <name>Lock Record</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Reg_Assessment_Status_Pending_Review</fullName>
        <description>Reg Assessment Status Pending Review</description>
        <field>QPMS__Status__c</field>
        <literalValue>Pending Review</literalValue>
        <name>Reg Assessment Status Pending Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__RegulatoryApprovalStatusForChangedField</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Pending</literalValue>
        <name>RegulatoryApprovalStatusForChangedField</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Regulatory_Assessment_Approval_Process</fullName>
        <description>Changing Regulatory Assessment	Approval Process field</description>
        <field>QPMS__ApprovalProcess__c</field>
        <literalValue>Regulatory Assessment</literalValue>
        <name>Regulatory Assessment	Approval Process</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Regulatory_Status_Open</fullName>
        <description>Regulatory Status Open</description>
        <field>QPMS__Status__c</field>
        <literalValue>Open</literalValue>
        <name>Regulatory Status Open</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__RgAs_Recl_CurrentApprovalSequenceNumber</fullName>
        <field>QPMS__CurrentApprovalSequenceNumber__c</field>
        <formula>99999</formula>
        <name>RgAs Recl CurrentApprovalSequenceNumber</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__RgAs_Rej_CurrentApprovalSequenceNumber</fullName>
        <field>QPMS__CurrentApprovalSequenceNumber__c</field>
        <formula>999999</formula>
        <name>RgAs Rej CurrentApprovalSequenceNumber</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__clear_Approver</fullName>
        <field>QPMS__Approver__c</field>
        <name>clear_Approver</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__clear_Approver1</fullName>
        <field>QPMS__Approver_1__c</field>
        <name>clear_Approver1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__clear_Approver2</fullName>
        <field>QPMS__Approver_2__c</field>
        <name>clear_Approver2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__clear_Approver3</fullName>
        <field>QPMS__Approver_3__c</field>
        <name>clear_Approver3</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__clear_Approver4</fullName>
        <field>QPMS__Approver_4__c</field>
        <name>clear_Approver4</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__unLock_Complaint_Record</fullName>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>unLock_Complaint_Record</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__unLock_Record_Regulatory_Assessment</fullName>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>unLock_Record_Regulatory_Assessment</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>QPMS__send email when Regulatory Assessment Owner is Changed</fullName>
        <actions>
            <name>QPMS__Email_Alert_for_regulatory_assessment_new_owner_assignment</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>we need to send email when regulatory assessment owner is chnaged</description>
        <formula>ISCHANGED( OwnerId )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__send email when Regulatory Assessment is created</fullName>
        <actions>
            <name>QPMS__Email_to_Regulatory_Assessment_Owner</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__Regulatory_Assesment__c.QPMS__Status__c</field>
            <operation>equals</operation>
            <value>Open</value>
        </criteriaItems>
        <description>send email when Regulatory Assessment is created</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
