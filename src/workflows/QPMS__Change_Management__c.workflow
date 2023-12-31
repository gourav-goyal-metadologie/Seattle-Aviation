<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__Cr_is_created_and_submit_for_approval_initially</fullName>
        <description>Cr is created and submit for approval initially</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CR_request</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_to_CR_Owner_on_approving_cr</fullName>
        <description>Email to CR Owner on approving cr</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__ParentOwner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CR_Approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_to_CR_Post_Change_approval_on_Recalling_cr</fullName>
        <description>Email to CR Post Change approval on Recalling cr</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CR_PostChangeApprovalRecall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_to_CR_Post_Change_approval_on_Rejected_cr</fullName>
        <description>Email to CR Post Change approval on Rejected cr</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CR_PostChangeApprovalRejected</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_to_CR_Post_approval_on_approving_cr</fullName>
        <description>Email to CR Post change approval on approving cr</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CR_PostChangeApprovalApproved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_to_CR_Pre_change_approval_on_approving_cr</fullName>
        <description>Email to CR Pre change approval on approving cr</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CR_PreChangeApprovalApproved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_to_CR_Resolution_approval_on_approving</fullName>
        <description>Email to CR Resolution approval on approving</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CR_ResolutionApprovalApproved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_to_CR_pre_change_approval_on_Rejecting_cr</fullName>
        <description>Email to CR pre change approval on Rejecting  cr</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CR_PreChangeApprovalRejected</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_to_CR_pre_change_approval_on_recall_cr</fullName>
        <description>Email to CR pre change approval on recall cr</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CR_PreChangeApprovalRecalled</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Notify_Approver_for_changing_owner_of_CR</fullName>
        <description>Notify Approver for changing owner of CR</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CR_ChangeOwnerApproval</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Notify_CR_owner_on_creation_of_change_request</fullName>
        <description>Notify CR owner on creation of change request</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CR_Creation</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Notify_when_change_owner_is_Recalled</fullName>
        <description>Notify when change owner is Recalled</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CR_ChangeOwnerApprovalRecall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Notify_when_change_owner_is_Rejected</fullName>
        <description>Notify when change owner is Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CR_ChangeOwnerRejection</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Notify_when_change_owner_is_approved</fullName>
        <description>Notify when change owner is approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CR_Change_Owner_approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Send_email_when_cr_is_rejected</fullName>
        <description>Send email when cr is rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CR_Rejected</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Send_email_when_cr_resolution_approval_is_rejected</fullName>
        <description>Send email when cr resolution approval is rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CR_ResolutionApprovalRejected</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Send_email_when_recalled</fullName>
        <description>Send email when recalled</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CR_Recall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Send_email_when_resolution_approval_is_recalled</fullName>
        <description>Send email when resolution approval is recalled</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CR_ResolutionApprovalRecall</template>
    </alerts>
    <fieldUpdates>
        <fullName>QPMS__Approval_Process_Change_Owner</fullName>
        <field>QPMS__ApprovalProcess__c</field>
        <literalValue>Change Owner</literalValue>
        <name>Approval Process Change Owner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Approval_Status_Update</fullName>
        <field>QPMS__ApprovalStatus__c</field>
        <literalValue>Approved</literalValue>
        <name>Approval Status Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__CM_Approval_Process_Complete</fullName>
        <field>QPMS__Approver_process_complete__c</field>
        <literalValue>0</literalValue>
        <name>CM Approval Process Complete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__CRTaskStatusOpen</fullName>
        <field>QPMS__Status__c</field>
        <literalValue>Open</literalValue>
        <name>CRTaskStatusOpen</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__CR_Status</fullName>
        <description>CR Status</description>
        <field>QPMS__Status__c</field>
        <literalValue>Pending Review</literalValue>
        <name>CR Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ChangeFieldApprovalStatus_Approved</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Approved</literalValue>
        <name>ChangeFieldApprovalStatus Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ChangeFieldApprovalStatus_Pending_Approv</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>ChangeFieldApprovalStatus Pending Approv</name>
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
        <fullName>QPMS__ChangeFieldApprovalStatuss_Rejected</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Rejected</literalValue>
        <name>ChangeFieldApprovalStatuss Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ChangeManagementStatus</fullName>
        <field>QPMS__Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>ChangeManagementStatus</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Clear_Post_SignOff</fullName>
        <field>QPMS__Post_Signed_Off_Details__c</field>
        <name>Clear Post SignOff</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Clear_Pre_SignOff</fullName>
        <field>QPMS__Pre_Signed_Off_Details__c</field>
        <name>Clear Pre SignOff</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Lock_CR_Record</fullName>
        <field>QPMS__isLocked__c</field>
        <literalValue>1</literalValue>
        <name>Lock CR Record</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__OnRecallCrSequencenumberr</fullName>
        <field>QPMS__CurrentApprovalSequenceNumber__c</field>
        <formula>99999</formula>
        <name>OnRecallCrSequencenumberr</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__OnRejectionCRsequenceNumberr</fullName>
        <field>QPMS__CurrentApprovalSequenceNumber__c</field>
        <formula>99999</formula>
        <name>OnRejectionCRsequenceNumberr</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__PostChangeSubmit</fullName>
        <field>QPMS__PostChangeApprovalStatus__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>PostChangeSubmit</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Post_Change_Approval</fullName>
        <field>QPMS__ApprovalProcess__c</field>
        <literalValue>Post Change Approval</literalValue>
        <name>PostChangeApproval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Post_Change_Recall</fullName>
        <field>QPMS__PostChangeApprovalStatus__c</field>
        <literalValue>Recall</literalValue>
        <name>Post_Change_Recall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Post_Change_Reject</fullName>
        <field>QPMS__PostChangeApprovalStatus__c</field>
        <literalValue>Reject</literalValue>
        <name>Post_Change_Reject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Pre_Change_Approval</fullName>
        <field>QPMS__PreChangeApprovalStatus__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Pre Change Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Pre_Change_Approval_Process</fullName>
        <field>QPMS__ApprovalProcess__c</field>
        <literalValue>Pre Change Approval</literalValue>
        <name>Pre Change Approval Process</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Pre_Change_Recall</fullName>
        <field>QPMS__PreChangeApprovalStatus__c</field>
        <literalValue>Recall</literalValue>
        <name>Pre_Change_Recall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Pre_Change_Reject</fullName>
        <field>QPMS__PreChangeApprovalStatus__c</field>
        <literalValue>Reject</literalValue>
        <name>Pre_Change_Reject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__RecallStatus</fullName>
        <field>QPMS__Status__c</field>
        <literalValue>Open</literalValue>
        <name>RecallStatus</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ResolutionApprovalOnRecall</fullName>
        <field>QPMS__Resolution_Approval_Status__c</field>
        <literalValue>Recall</literalValue>
        <name>ResolutionApprovalOnRecall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ResolutionApprovalOnReject</fullName>
        <field>QPMS__Resolution_Approval_Status__c</field>
        <literalValue>Reject</literalValue>
        <name>ResolutionApprovalOnReject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ResolutionApprovalOnSubmit</fullName>
        <field>QPMS__Resolution_Approval_Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>ResolutionApprovalOnSubmit</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Resolution_Approval_Process</fullName>
        <field>QPMS__ApprovalProcess__c</field>
        <literalValue>Resolution Approval</literalValue>
        <name>Resolution Approval Process</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Started_Approval_Process</fullName>
        <field>QPMS__Approver_process_complete__c</field>
        <literalValue>0</literalValue>
        <name>Started Approval Process</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Unlock_CM_Record</fullName>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>Unlock CM Record</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__UpdateApprovalRequired</fullName>
        <field>QPMS__Approval_Required__c</field>
        <literalValue>Yes</literalValue>
        <name>UpdateApprovalRequired</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__UpdateSequenceNull</fullName>
        <field>QPMS__ApproverSequence__c</field>
        <name>UpdateSequenceNull</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_Sign_Off_Details</fullName>
        <field>QPMS__Pre_Signed_Off_Details__c</field>
        <formula>IF( ISBLANK( QPMS__Pre_Signed_Off_Details__c ) , &apos;&apos;+ QPMS__Initial_Submitter__r.FirstName +&apos; &apos;+ QPMS__Initial_Submitter__r.LastName +&apos; | &apos;+ IF(ISBLANK(QPMS__Initial_Submitter__r.Title),&apos;&apos;,QPMS__Initial_Submitter__r.Title+&apos; | &apos;) +&apos; &apos;+ SUBSTITUTE(TEXT( DATETIMEVALUE(NOW()) ),&apos;Z&apos;,&apos;&apos;)+&apos; (UTC)&apos;+ IF( $Setup.QPMS__QC_settings__c.QPMS__Is_Digital_Signature_Needed__c ,&apos; | &apos;+ $Label.qpms__i_am_the_author_of_this_record ,&apos;&apos;), QPMS__Pre_Signed_Off_Details__c )</formula>
        <name>Update Sign Off Details</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_Sign_Off_Details_Post</fullName>
        <field>QPMS__Post_Signed_Off_Details__c</field>
        <formula>IF( ISBLANK( QPMS__Post_Signed_Off_Details__c ) , &apos;&apos;+ QPMS__Initial_Submitter__r.FirstName +&apos; &apos;+ QPMS__Initial_Submitter__r.LastName +&apos; | &apos;+ IF(ISBLANK(QPMS__Initial_Submitter__r.Title),&apos;&apos;,QPMS__Initial_Submitter__r.Title+&apos; | &apos;) +&apos; &apos;+ SUBSTITUTE(TEXT( DATETIMEVALUE(NOW()) ),&apos;Z&apos;,&apos;&apos;)+&apos; (UTC)&apos;+ IF( $Setup.QPMS__QC_settings__c.QPMS__Is_Digital_Signature_Needed__c ,&apos; | &apos;+ $Label.qpms__i_am_the_author_of_this_record ,&apos;&apos;), QPMS__Post_Signed_Off_Details__c )</formula>
        <name>Update Sign Off Details</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__final_recall_data</fullName>
        <field>QPMS__ApprovalStatus__c</field>
        <literalValue>Recall</literalValue>
        <name>final recall data</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__final_rejection</fullName>
        <field>QPMS__ApprovalStatus__c</field>
        <literalValue>rejected</literalValue>
        <name>final rejection</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__updatePhasefieldonRecall</fullName>
        <field>QPMS__Phase__c</field>
        <literalValue>Review</literalValue>
        <name>updatePhasefieldonRecall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__updatePhasefieldonRejectionupdatePhasefi</fullName>
        <field>QPMS__Phase__c</field>
        <literalValue>Workflow</literalValue>
        <name>updatePhasefieldonRejection</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__update_status_when_approval_is_checked</fullName>
        <field>QPMS__Status__c</field>
        <literalValue>Open</literalValue>
        <name>update status when approval is checked</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__updatephasefieldfinally</fullName>
        <field>QPMS__Phase__c</field>
        <literalValue>Workflow</literalValue>
        <name>updatephasefieldfinally</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__updatephasefieldinitially</fullName>
        <field>QPMS__Phase__c</field>
        <literalValue>Review</literalValue>
        <name>updatephasefieldinitially</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__updatestatuswhenNoResolutionSelected</fullName>
        <field>QPMS__Status__c</field>
        <literalValue>Open</literalValue>
        <name>updatestatuswhenNoResolutionSelected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>QPMS__send email to CR owner on creation of CR</fullName>
        <actions>
            <name>QPMS__Notify_CR_owner_on_creation_of_change_request</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__Change_Management__c.QPMS__Status__c</field>
            <operation>equals</operation>
            <value>Open</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
