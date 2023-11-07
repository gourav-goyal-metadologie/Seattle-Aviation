<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__Complaint_Creation</fullName>
        <description>Complaint Creation</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Complaint_Creation</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Complaint_New_Owner_assignment</fullName>
        <description>Complaint New Owner assignment</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__New_Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Complaint_New_Owner</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Complaint_Record_approved</fullName>
        <description>Complaint Record approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Complaint_Approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Complaint_Record_recalled</fullName>
        <description>Complaint Record recalled</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Complaint_Recall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Complaint_Record_rejected</fullName>
        <description>Complaint Record rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Complaint_Rejected</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Complaint_Resolution_Approval_Approved</fullName>
        <description>Complaint Resolution Approval Approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Complaint_Resolution_Approval_Approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Complaint_Resolution_Approval_Recall</fullName>
        <description>Complaint Resolution Approval Recall</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Complaint_Resolution_Approval_Recall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Complaint_Resolution_Approval_Reject</fullName>
        <description>Complaint Resolution Approval Reject</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Complaint_Resolution_Approval_Reject</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Complaint_change_owner_approved</fullName>
        <description>Complaint change owner approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Complaint_Change_Owner_approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Complaint_change_owner_recall</fullName>
        <description>Complaint change owner recall</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__ComplaintChangeOwnerRecall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Complaint_change_owner_rejected</fullName>
        <description>Complaint change owner rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__ComplaintChangeOwnerRejection</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_Alert_for_New_Owner</fullName>
        <description>Email Alert for New Owner</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Complaint_New_Owner</template>
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
        <fullName>QPMS__Approval_Process_Complaint_Approval</fullName>
        <description>Differentiate from change owner and review Approvals</description>
        <field>QPMS__ApprovalProcess__c</field>
        <literalValue>Complaint Approval</literalValue>
        <name>Approval Process Complaint Approval</name>
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
        <fullName>QPMS__Approval_Process_Resolution_Approval</fullName>
        <description>Approval Process Resolution Approval</description>
        <field>QPMS__ApprovalProcess__c</field>
        <literalValue>Resolution Approval</literalValue>
        <name>Approval Process Resolution Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Approval_Status_Pending_Approval</fullName>
        <description>Approval Status :Pending Approval</description>
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
        <description>Approval Status Recalled</description>
        <field>QPMS__Resolution_Approval_Status__c</field>
        <literalValue>Recalled</literalValue>
        <name>Approval Status Recalled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Approval_Status_Rejected</fullName>
        <description>Approval Status Rejected</description>
        <field>QPMS__Resolution_Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Approval Status Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__CMP_Res_Approval_Status_Pending_Approval</fullName>
        <field>QPMS__Resolution_Approval_Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Approval Status Pending Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ChangeSecqueceOnRecalledFieldUpdate</fullName>
        <field>QPMS__CurrentApprovalSequenceNumber__c</field>
        <formula>99999999</formula>
        <name>ChangeSecqueceOnRecalledFieldUpdate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Change_Complaint_Status</fullName>
        <description>Change Complaint Status to in-review</description>
        <field>QPMS__Status__c</field>
        <literalValue>In-Review</literalValue>
        <name>Change Complaint Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Change_Complaint_Status_For_Recall</fullName>
        <description>Change Complaint Status after Recall</description>
        <field>QPMS__Status__c</field>
        <literalValue>Draft</literalValue>
        <name>Change Complaint Status For Recall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Change_Complaint_Status_On_Recall</fullName>
        <description>Change Complaint Status On Recall</description>
        <field>QPMS__Status__c</field>
        <literalValue>Inprogress</literalValue>
        <name>Change Complaint Status On Recall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Change_Complaint_Status_On_Reject</fullName>
        <description>Change Complaint Status On Reject</description>
        <field>QPMS__Status__c</field>
        <literalValue>Inprogress</literalValue>
        <name>Change Complaint Status On Reject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Change_Complaint_Status_Rejected</fullName>
        <description>Change Complaint Status after Rejected</description>
        <field>QPMS__Status__c</field>
        <literalValue>Draft</literalValue>
        <name>Change Complaint Status Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Change_Complaint_Status_in_Resolution</fullName>
        <description>Change Complaint Status in Resolution</description>
        <field>QPMS__Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Change Complaint Status in Resolution</name>
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
        <fullName>QPMS__ChangetheSecqueceOnRecallFieldUpdate</fullName>
        <field>QPMS__CurrentApprovalSequenceNumber__c</field>
        <formula>99999999</formula>
        <name>ChangetheSecqueceOnRecallFieldUpdate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ComplaintApprovalStatusForChangedField</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Pending</literalValue>
        <name>ComplaintApprovalStatusForChangedField</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Complaint_Recall</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Recall</literalValue>
        <name>Complaint  Recall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Complaint_unLock_Record</fullName>
        <description>unLock_Record by un checking isLock</description>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>Complaint unLock Record</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Complaint_unLock_Records</fullName>
        <description>unLock_Record by un checking isLock</description>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>Complaint unLock Record</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Complaint_unLocks_Record</fullName>
        <description>unLock_Record by un checking isLocke</description>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>Complaint unLock Record</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Lock_Record</fullName>
        <description>Lock_Record by using islock field</description>
        <field>QPMS__isLocked__c</field>
        <literalValue>1</literalValue>
        <name>Lock Record</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__On_Recall_Sequence_Number</fullName>
        <field>QPMS__CurrentApprovalSequenceNumber__c</field>
        <formula>99999</formula>
        <name>On Recall Sequence Number</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
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
        <fullName>QPMS__remove_new_owner</fullName>
        <field>QPMS__New_Owner__c</field>
        <name>remove new owner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>QPMS__Complaint Initiation</fullName>
        <actions>
            <name>QPMS__Complaint_Creation</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__Complaint__c.QPMS__Status__c</field>
            <operation>equals</operation>
            <value>Draft</value>
        </criteriaItems>
        <description>Complaint Initiation Mail</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Complaint New Owner</fullName>
        <actions>
            <name>QPMS__Email_Alert_for_New_Owner</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Complaint: New Owner should get the Email.</description>
        <formula>ISCHANGED( OwnerId )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
