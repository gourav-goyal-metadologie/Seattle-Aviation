<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__Email_Alert_for_New_NC_Owner</fullName>
        <description>Email Alert for New NC Owner</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__NC_New_Owner</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_Alert_to_New_NC_Owner_Upon_Change_NC_Owner</fullName>
        <description>Email Alert to New NC Owner Upon Change NC Owner</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__NCChangeOwnerApproved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_to_NC_Owner_On_Rejecting_Task</fullName>
        <description>Email to NC Owner On Rejecting Task</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__NCChangeOwnerRejection</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_to_NC_Owner_on_Recalling_Task</fullName>
        <description>Email to NC Owner on Recalling Task</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__ChangeNCOwnerApprovalRecall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__NC_New_Owner_assignment</fullName>
        <description>NC New Owner assignment</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__New_Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__NC_New_Owner</template>
    </alerts>
    <alerts>
        <fullName>QPMS__NC_Void_Approved_Alert</fullName>
        <description>NC Void : Approved Alert</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__NC_Void_Approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__NC_Void_Recalled_Alert</fullName>
        <description>NC Void : Recalled Alert</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__NC_Void_Recalled</template>
    </alerts>
    <alerts>
        <fullName>QPMS__NC_Void_Rejected_Alert</fullName>
        <description>NC Void : Rejected Alert</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__NC_Void_Rejected</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Non_Conformance_Resolution_Code_Approved_alert</fullName>
        <description>Non-Conformance Resolution Code : Approved alert</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__NC_Resolution_Code_Approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Non_Conformance_Resolution_Code_Recalled_alert</fullName>
        <description>Non-Conformance Resolution Code : Recalled alert</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__NC_Resolution_Code_Recalled</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Non_Conformance_Resolution_Code_Rejected_alert</fullName>
        <description>Non-Conformance Resolution Code : Rejected alert</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__NC_Resolution_Code_Rejected</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Notify_NC_Owner_regarding_new_NC_Creation</fullName>
        <description>Notify NC Owner regarding new NC Creation</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__NC_Creation</template>
    </alerts>
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
        <fullName>QPMS__Approved</fullName>
        <field>QPMS__ApprovalStatus__c</field>
        <literalValue>Approved</literalValue>
        <name>Approved</name>
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
        <fullName>QPMS__CurrentApprovalSequenceNumber_NC</fullName>
        <field>QPMS__CurrentApprovalSequenceNumber__c</field>
        <formula>99999999</formula>
        <name>CurrentApprovalSequenceNumber_NC</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__InReview</fullName>
        <field>QPMS__NC_Status__c</field>
        <literalValue>In Review</literalValue>
        <name>InReview</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Locked</fullName>
        <field>QPMS__isLocked__c</field>
        <literalValue>1</literalValue>
        <name>Locked</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__NCApprovalActionOnChangeFieldOwner</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Approve</literalValue>
        <name>NCApprovalActionOnChangeFieldOwner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__NCApprovalStatusForChangedField</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Pending</literalValue>
        <name>NCApprovalStatusForChangedField</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__NC_Recall</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Recall</literalValue>
        <name>NC Recall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__NC_Status_update_to_NC_Workflow</fullName>
        <field>QPMS__NC_Status__c</field>
        <literalValue>NC Workflow</literalValue>
        <name>NC Status update to NC Workflow</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__NC_Void_Approval_Status_Approved</fullName>
        <description>NC Void Approval Status Approved</description>
        <field>QPMS__Void_Approval_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>NC Void Approval Status Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__NC_Void_Approval_Status_Pending_Approval</fullName>
        <description>NC Void Approval Status Pending Approval</description>
        <field>QPMS__Void_Approval_Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>NC Void Approval Status Pending Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__NC_Void_Approval_Status_Recalled</fullName>
        <description>NC Void Approval Status Recalled</description>
        <field>QPMS__Void_Approval_Status__c</field>
        <literalValue>Recalled</literalValue>
        <name>NC Void Approval Status Recalled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__NC_Void_Approval_Status_Rejected</fullName>
        <description>NC Void Approval Status Rejected</description>
        <field>QPMS__Void_Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>NC Void Approval Status Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__NC_change_owner_rejected</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Reject</literalValue>
        <name>NC change owner rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Open_Status</fullName>
        <field>QPMS__NC_Status__c</field>
        <literalValue>Open</literalValue>
        <name>Open Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Pending_Approval</fullName>
        <field>QPMS__ApprovalStatus__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Pending Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Recall_Sequence_Update</fullName>
        <field>QPMS__CurrentApprovalSequenceNumber__c</field>
        <formula>99999</formula>
        <name>Recall Sequence Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Recalled</fullName>
        <field>QPMS__ApprovalStatus__c</field>
        <literalValue>Recalled</literalValue>
        <name>Recalled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Reject_Sequence_Update</fullName>
        <field>QPMS__CurrentApprovalSequenceNumber__c</field>
        <formula>999999</formula>
        <name>Reject Sequence Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Rejected</fullName>
        <field>QPMS__ApprovalStatus__c</field>
        <literalValue>Rejected</literalValue>
        <name>Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Status_Pending_Approval</fullName>
        <description>NC_Status updated to Pending Approval</description>
        <field>QPMS__NC_Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Status Pending Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_Initiating_Site</fullName>
        <field>QPMS__Initiating_Site_Security__c</field>
        <formula>$Setup.QPMS__QC_settings__c.QPMS__NC_Group_Filter__c +&apos;_&apos;+SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE( QPMS__Initiating_Site__r.QPMS__Code__c ,&apos;(&apos;,&apos;_&apos;),&apos;)&apos;,&apos;_&apos;),&apos; &apos;,&apos;_&apos;),&apos;__&apos;,&apos;_&apos;)</formula>
        <name>Update Initiating Site</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_NC_Stage_to_Closed</fullName>
        <field>QPMS__NC_Status__c</field>
        <literalValue>Closed</literalValue>
        <name>Update NC Stage to Closed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_Signed_off_By</fullName>
        <field>QPMS__Signed_Off_Details__c</field>
        <formula>IF( ISBLANK( QPMS__Signed_Off_Details__c ) , &apos;&apos;+ QPMS__Initial_Submitter__r.FirstName +&apos; &apos;+ QPMS__Initial_Submitter__r.LastName +&apos; | &apos;+ IF(ISBLANK(QPMS__Initial_Submitter__r.Title),&apos;&apos;,QPMS__Initial_Submitter__r.Title+&apos; | &apos;) +&apos; &apos;+ SUBSTITUTE(TEXT( DATETIMEVALUE(NOW()) ),&apos;Z&apos;,&apos;&apos;)+&apos; (UTC)&apos;+ IF(  $Setup.QPMS__QC_settings__c.QPMS__Is_Digital_Signature_Needed__c ,&apos; | &apos;+   $Label.qpms__i_am_the_author_of_this_record,&apos;&apos;), QPMS__Signed_Off_Details__c )</formula>
        <name>Update Signed-off By</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__clearApprover</fullName>
        <description>After approved, Approver field is assigned to null</description>
        <field>QPMS__Approver__c</field>
        <name>clearApprover</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__unlock</fullName>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>unlock</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>QPMS__NC Status update</fullName>
        <actions>
            <name>QPMS__Update_NC_Stage_to_Closed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>QPMS__Non_Conformance__c.QPMS__NC_Resolution_Code__c</field>
            <operation>equals</operation>
            <value>No Action Required,Discarded,Addressed through CAPA</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Non_Conformance__c.QPMS__NC_Status__c</field>
            <operation>notEqual</operation>
            <value>Closed,Reopened</value>
        </criteriaItems>
        <description>If NC resolution code is No Action Required,Discarded or Addressed through CAPA option is selected, then NC is closed with Status changed to “CLOSED”</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Non-Conformance New Owner</fullName>
        <actions>
            <name>QPMS__Email_Alert_for_New_NC_Owner</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Non-Conformance: New Owner should get Email.</description>
        <formula>ISCHANGED( OwnerId )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Send email to NC Owner upon NC creation</fullName>
        <actions>
            <name>QPMS__Notify_NC_Owner_regarding_new_NC_Creation</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__Non_Conformance__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Non-Conformance</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
