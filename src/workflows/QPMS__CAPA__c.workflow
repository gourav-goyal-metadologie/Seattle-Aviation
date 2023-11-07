<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__CAPA_New_Owner_assignment</fullName>
        <description>CAPA New Owner assignment</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__New_Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CAPA_New_Owner</template>
    </alerts>
    <alerts>
        <fullName>QPMS__CAPA_Resolution_Code_Approved_alert</fullName>
        <description>CAPA Resolution Code : Approved alert</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CAPA_Resolution_Code_Approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__CAPA_Resolution_Code_Recalled_alert</fullName>
        <description>CAPA Resolution Code : Recalled alert</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CAPA_Resolution_Code_Recalled</template>
    </alerts>
    <alerts>
        <fullName>QPMS__CAPA_Resolution_Code_Rejected_alert</fullName>
        <description>CAPA Resolution Code : Rejected alert</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CAPA_Resolution_Code_Rejected</template>
    </alerts>
    <alerts>
        <fullName>QPMS__CAPA_Void_Approved_Alert</fullName>
        <description>CAPA Void : Approved Alert</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CAPA_Void_Approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__CAPA_Void_Recalled_Alert</fullName>
        <description>CAPA Void : Recalled Alert</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CAPA_Void_Recalled</template>
    </alerts>
    <alerts>
        <fullName>QPMS__CAPA_Void_Rejected_Alert</fullName>
        <description>CAPA Void : Rejected Alert</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CAPA_Void_Rejected</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_Alert_for_CAPA_New_Owner</fullName>
        <description>Email Alert for CAPA: New Owner</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CAPA_New_Owner</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_Alert_to_New_CAPA_Owner_Upon_Change_CAPA_Owner</fullName>
        <description>Email Alert to New CAPA Owner Upon Change  CAPA Owner</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__New_Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CAPA_Change_Owner_approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_to_CAPA_Owner_On_Rejecting_Task</fullName>
        <description>Email to CAPA Owner  On Rejecting Task</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CAPAChangeOwnerRejection</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_to_CAPA_Owner_on_Recalling_Task</fullName>
        <description>Email to CAPA Owner on Recalling Task</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__ChangeCAPAOwnerApprovalRecall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Notify_CAPA_owner_regarding_new_CAPA_creation</fullName>
        <description>Notify CAPA owner regarding new CAPA creation</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__CAPA_Creation</template>
    </alerts>
    <fieldUpdates>
        <fullName>QPMS__Approval_Status_Approved</fullName>
        <description>Void Approval Status Approved</description>
        <field>QPMS__Void_Approval_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Approval Status Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Approval_Status_Pending_Approval</fullName>
        <description>Void Approval Status Pending Approval</description>
        <field>QPMS__Void_Approval_Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Approval Status Pending Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Approval_Status_Recalled</fullName>
        <description>Void Approval Status Recalled</description>
        <field>QPMS__Void_Approval_Status__c</field>
        <literalValue>Recalled</literalValue>
        <name>Approval Status Recalled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Approval_Status_Rejected</fullName>
        <description>Void Approval Status Rejected</description>
        <field>QPMS__Void_Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Approval Status Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Approved</fullName>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__CAPA_Approval_Status_Approved</fullName>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>CAPA Approval Status Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__CAPA_Approval_Status_Pending_Approval</fullName>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>CAPA Approval Status Pending Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__CAPA_Approval_Status_Recalled</fullName>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Recall</literalValue>
        <name>CAPA Approval Status Recalled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__CAPA_Approval_Status_Rejected</fullName>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>CAPA Approval Status Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__InReview</fullName>
        <field>QPMS__CAPA_Status__c</field>
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
        <fullName>QPMS__Open_Status</fullName>
        <field>QPMS__CAPA_Status__c</field>
        <literalValue>Open</literalValue>
        <name>Open Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Pending_Approval</fullName>
        <field>QPMS__Approval_Status__c</field>
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
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Recall</literalValue>
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
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Status_Pending_Approval</fullName>
        <description>Capa_Status updated to Pending Approval</description>
        <field>QPMS__CAPA_Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Status Pending Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_Signed_off_By</fullName>
        <field>QPMS__Signed_Off_Details__c</field>
        <formula>IF( ISBLANK( QPMS__Signed_Off_Details__c ) , &apos;&apos;+  QPMS__Initial_Submitter__r.FirstName +&apos; &apos;+ QPMS__Initial_Submitter__r.LastName +&apos; | &apos;+ IF(ISBLANK(QPMS__Initial_Submitter__r.Title),&apos;&apos;,QPMS__Initial_Submitter__r.Title+&apos; | &apos;) +&apos; &apos;+ SUBSTITUTE(TEXT( DATETIMEVALUE(NOW()) ),&apos;Z&apos;,&apos;&apos;)+&apos; (UTC)&apos;+ IF(   $Setup.QPMS__QC_settings__c.QPMS__Is_Digital_Signature_Needed__c ,&apos; | &apos;+   $Label.qpms__i_am_the_author_of_this_record   ,&apos;&apos;), QPMS__Signed_Off_Details__c )</formula>
        <name>Update Signed-off By</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
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
        <fullName>QPMS__CAPA New Owner</fullName>
        <actions>
            <name>QPMS__Email_Alert_for_CAPA_New_Owner</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>CAPA: New Owner should get the email</description>
        <formula>ISCHANGED( OwnerId )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Send email to CAPA owner upon CAPA Creation</fullName>
        <actions>
            <name>QPMS__Notify_CAPA_owner_regarding_new_CAPA_creation</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__CAPA__c.QPMS__CAPA_Status__c</field>
            <operation>equals</operation>
            <value>Open</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
