<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__Date_of_Purge_is_Today</fullName>
        <description>Date of Purge is Today</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__DOC_Purge_Date</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Doc_Record_approved</fullName>
        <description>Doc Record approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__DOC_Approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Doc_Record_recalled</fullName>
        <description>Doc Record recalled</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__DOC_Recall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Doc_Record_rejected</fullName>
        <description>Doc Record rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__DOC_Rejected</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Doc_change_owner_approved</fullName>
        <description>Doc change owner approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__DOC_Change_Owner_approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Doc_change_owner_recalled</fullName>
        <description>Doc change owner recalled</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__DOC_ChangeOwnerRecall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Doc_change_owner_rejected</fullName>
        <description>Doc change owner rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__DOC_ChangeOwnerRejection</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Document_made_current</fullName>
        <description>Document made current</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__DOC_Made_Current</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_is_sent_out_to_the_document_owner_when_the_Effectiveness_Review_task_start</fullName>
        <description>Email is sent out to the document owner when the Effectiveness Review task start date is today’s date</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__DOC_Effectiveness_Review_Task</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Notify_DOC_owner_on_creation_of_DOC</fullName>
        <description>Notify DOC owner on creation of DOC</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__DOC_Creation</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Send_email_to_Authorize_user_and_doc_owner_when_security_is_enabled</fullName>
        <description>Send email to Authorize user and doc owner when security is enabled</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__DOC_Security_Enabled</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Send_email_to_Document_owner_when_collaboration_review_starts</fullName>
        <description>Send email to Document owner when collaboration review starts</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__DOC_Collaboration_Review</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Send_email_when_effectiveness_review_started</fullName>
        <description>Send email when effectiveness review started</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__DOC_Effectiveness_Review_Task</template>
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
        <fullName>QPMS__Approval_Process_Document_Approval</fullName>
        <field>QPMS__ApprovalProcess__c</field>
        <literalValue>Document Approval</literalValue>
        <name>Approval Process Document Approval</name>
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
        <fullName>QPMS__Custom_Unlock</fullName>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>Custom Unlock</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Doc_pending_approval</fullName>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Doc pending approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Document_status_Recalled</fullName>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Recall</literalValue>
        <name>Document status Recalled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Document_status_Rejected</fullName>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Document status Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Document_status_approved</fullName>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Document status approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__NewOwnerUpdate</fullName>
        <field>QPMS__New_Owner__c</field>
        <name>NewOwnerUpdate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__NewOwnerUpdateOnReject</fullName>
        <field>QPMS__New_Owner__c</field>
        <name>NewOwnerUpdateOnReject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__On_Recall_SequenceNumber</fullName>
        <field>QPMS__CurrentApprovalSequenceNumber__c</field>
        <formula>99999</formula>
        <name>On Recall SequenceNumber</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_Unique_Document_Number</fullName>
        <description>Update Unique Document Number</description>
        <field>QPMS__Unique_Document_Number__c</field>
        <formula>Name&amp;QPMS__Current_Rev__c</formula>
        <name>Update Unique Document Number</name>
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
    <rules>
        <fullName>QPMS__Date of Purge is Today</fullName>
        <actions>
            <name>QPMS__Date_of_Purge_is_Today</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__Document_Profile__c.QPMS__Date_of_Purge__c</field>
            <operation>equals</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Document_Profile__c.QPMS__Status__c</field>
            <operation>equals</operation>
            <value>Obsolete</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Document Made current</fullName>
        <actions>
            <name>QPMS__Document_made_current</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__Document_Profile__c.QPMS__Status__c</field>
            <operation>equals</operation>
            <value>Current</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Send email to DOC owner on creation of DOC</fullName>
        <actions>
            <name>QPMS__Notify_DOC_owner_on_creation_of_DOC</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__Document_Profile__c.QPMS__Status__c</field>
            <operation>equals</operation>
            <value>Draft</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Send email when Effectiveness Review date is Today</fullName>
        <actions>
            <name>QPMS__Send_email_when_effectiveness_review_started</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(QPMS__Effectiveness_Review_Date__c  =TODAY(),TEXT(QPMS__Status__c)=&apos;Current&apos;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Unique Document Number</fullName>
        <actions>
            <name>QPMS__Update_Unique_Document_Number</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Unique Document Number</description>
        <formula>NOT( ISBLANK(Name) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
