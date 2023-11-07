<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__Email_Alert_for_New_Inspection_Standard_Owner</fullName>
        <description>Email Alert for New Inspection Standard Owner</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Inspection_Standard_ChangeOwner</template>
    </alerts>
    <alerts>
        <fullName>QPMS__InspectionStandard_Creation</fullName>
        <description>InspectionStandard Creation</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Inspection_InspectionStandard_Creation</template>
    </alerts>
    <alerts>
        <fullName>QPMS__InspectionStandard_change_owner_Assignment</fullName>
        <description>InspectionStandard change owner Assignment</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__InspectionStandard_ChangeOwnerApproval</template>
    </alerts>
    <alerts>
        <fullName>QPMS__InspectionStandard_change_owner_rejected</fullName>
        <description>InspectionStandard change owner rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__InspectionStandard_ChangeOwnerRejected</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Inspection_Standard_Approval_Assignment</fullName>
        <description>Inspection Standard Approval Assignment</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Inspection_Standard_Approval_Request</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Inspection_Standard_Approved</fullName>
        <description>Inspection Standard Approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Inspection_Standard_Record_Approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Inspection_Standard_Recalled</fullName>
        <description>Inspection Standard Recalled</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Inspection_Standard_Recall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Inspection_Standard_Rejected</fullName>
        <description>Inspection Standard Rejected</description>
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
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Inspection_Standard_Reject</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Inspection_Standard_owner_approved</fullName>
        <description>Inspection Standard owner approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Inspection_Standard_ChangeOwnerApproved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Inspection_Standard_owner_change_Recall</fullName>
        <description>Inspection Standard owner change Recall</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__InspectionStandard_ChangeOwnerRecalled</template>
    </alerts>
    <fieldUpdates>
        <fullName>QPMS__ApprovalProcessUpdate</fullName>
        <field>QPMS__ApprovalProcess__c</field>
        <name>ApprovalProcessUpdate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ApprovalStatusForChangeFieldOwner</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>ApprovalStatusForChangeFieldOwner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Approval_Process_Upate</fullName>
        <field>QPMS__ApprovalProcess__c</field>
        <name>Approval Process Upate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Approval_Process_Update</fullName>
        <field>QPMS__ApprovalProcess__c</field>
        <literalValue>Change Owner</literalValue>
        <name>Approval Process Update</name>
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
        <fullName>QPMS__Approval_status_field_update_on_Recall</fullName>
        <field>QPMS__Status__c</field>
        <literalValue>Draft</literalValue>
        <name>Approval status field update on Recall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ChangeFieldApprovalStatusForOwner</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Approved</literalValue>
        <name>ChangeFieldApprovalStatusForOwner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ChangeFieldApprovalStatusToRecalledForOw</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Recall</literalValue>
        <name>ChangeFieldApprovalStatusToRecalledForOw</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ChangeFieldApprovalStatusToRejectedForOw</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Rejected</literalValue>
        <name>ChangeFieldApprovalStatusToRejectedForOw</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__CurrentApprovalSequenceOnRejection</fullName>
        <field>QPMS__CurrentApprovalSequenceNumber__c</field>
        <formula>999999</formula>
        <name>CurrentApprovalSequenceOnRejection</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__CurrentApproval_SequenceOnRecall</fullName>
        <field>QPMS__CurrentApprovalSequenceNumber__c</field>
        <formula>99999</formula>
        <name>CurrentApproval SequenceOnRecall</name>
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
        <fullName>QPMS__Inspection_Standard_Status</fullName>
        <field>QPMS__Status__c</field>
        <literalValue>Draft</literalValue>
        <name>Inspection Standard Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Status_Update</fullName>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Status Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__change_status</fullName>
        <field>QPMS__Status__c</field>
        <literalValue>InReview</literalValue>
        <name>change status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__changenewowner</fullName>
        <field>QPMS__New_Owner__c</field>
        <name>changenewowner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__customUnlock</fullName>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>customUnlock</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__is_submit_change</fullName>
        <field>QPMS__isSubmit__c</field>
        <literalValue>0</literalValue>
        <name>is submit change</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__is_submit_change_for_rejection</fullName>
        <field>QPMS__isSubmit__c</field>
        <literalValue>0</literalValue>
        <name>is submit change for rejection</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__islock_final_approval</fullName>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>islock final approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__unlock_record</fullName>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>unlock record</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__updatenewOwner</fullName>
        <field>QPMS__New_Owner__c</field>
        <name>updatenewOwner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>QPMS__Inspection Standard New Owner</fullName>
        <actions>
            <name>QPMS__Email_Alert_for_New_Inspection_Standard_Owner</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Inspection Standard New Owner</description>
        <formula>ISCHANGED(OwnerId)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Send Email When InspectionStandard is Created</fullName>
        <actions>
            <name>QPMS__InspectionStandard_Creation</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__Inspection_Standard__c.QPMS__Status__c</field>
            <operation>equals</operation>
            <value>Draft</value>
        </criteriaItems>
        <description>email will sent when InspectionStandard is created</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>