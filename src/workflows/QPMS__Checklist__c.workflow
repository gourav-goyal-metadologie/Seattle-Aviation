<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__Checklist_Approval_rejection</fullName>
        <description>Checklist Approval rejection</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Assigned_To__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Checklist_Rejection</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_alert_to_the_Checklist_Assigned_To_User</fullName>
        <description>Email alert to the Checklist Assigned To User</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Assigned_To__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Checklist_Assigned_To_email</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_alert_to_the_Checklist_Owner</fullName>
        <description>Email alert to the Checklist Owner</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Assigned_To__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Checklist_Approval</template>
    </alerts>
    <alerts>
        <fullName>QPMS__email_to_checklist_new_owner_after_approval</fullName>
        <description>email to checklist new owner after approval</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__New_Assigned_To__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Checklist_new_assigned_to_after_approval</template>
    </alerts>
    <alerts>
        <fullName>QPMS__emailwhenapproverisassigned</fullName>
        <description>emailwhenapproverisassigned</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Approval_assignment_checklist</template>
    </alerts>
    <alerts>
        <fullName>QPMS__notification_when_checklist</fullName>
        <description>notification when checklist approval process is recalled</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Checklist_Change_AssignedToRecall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__send_an_email_to_lead_Auditor</fullName>
        <description>send an email to lead Auditor</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Assigned_To__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Checklist_Assigned_To_email</template>
    </alerts>
    <fieldUpdates>
        <fullName>QPMS__ApprovalStatusForChangeField</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Pending</literalValue>
        <name>ApprovalStatusForChangeField</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ApproveActionOnChangeField</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Approve</literalValue>
        <name>ApproveActionOnChangeField</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ChangeFieldApprovalStatus_Reject</fullName>
        <description>this  actions fires on rejection of assigned To</description>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Reject</literalValue>
        <name>ChangeFieldApprovalStatus Reject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ChangeSecqueceOnRecallFieldUpdate</fullName>
        <field>QPMS__CurrentApprovalSequenceNumber__c</field>
        <formula>99999999</formula>
        <name>ChangeSecqueceOnRecallFieldUpdate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Change_assigned_To</fullName>
        <field>QPMS__ApprovalProcess__c</field>
        <literalValue>Change Assigned To</literalValue>
        <name>Change assigned To</name>
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
        <fullName>QPMS__Recall</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Recall</literalValue>
        <name>Recall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__clearApprover1</fullName>
        <field>QPMS__Approver_1__c</field>
        <name>clearApprover1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__clearApprover2</fullName>
        <field>QPMS__Approver_2__c</field>
        <name>clearApprover2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__clearApprover3</fullName>
        <field>QPMS__Approver_3__c</field>
        <name>clearApprover3</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__clearApprover4</fullName>
        <field>QPMS__Approver_4__c</field>
        <name>clearApprover4</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__unLock_Record</fullName>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>unLock_Record</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__unLock_Record1</fullName>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>unLock_Record1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>QPMS__Assignment of Checklist</fullName>
        <actions>
            <name>QPMS__Email_alert_to_the_Checklist_Assigned_To_User</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Sends an email to the Checklist Assigned to user</description>
        <formula>AND( QPMS__New_Assigned_To__c != QPMS__Assigned_To__c  , NOT(ISBLANK( QPMS__New_Assigned_To__c )))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Assignment of Checklist to Lead Auditor</fullName>
        <actions>
            <name>QPMS__send_an_email_to_lead_Auditor</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Sends an email to the Checklist lead Auditor</description>
        <formula>AND(  NOT( ISNULL( QPMS__Audit__c ) ), ISPICKVAL( QPMS__Audit__r.QPMS__Status__c , &apos;InProgress&apos;),  QPMS__Assigned_To__c ==  QPMS__Audit__r.QPMS__Lead_Auditor__c, ISPICKVAL( QPMS__Attached__c , &apos;Yes&apos;),  QPMS__UpdateChecklistWorkflow__c  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>