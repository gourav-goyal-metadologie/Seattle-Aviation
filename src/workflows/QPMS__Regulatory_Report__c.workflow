<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__Email_Alert_for_regulatory_report_approval_approved</fullName>
        <description>Email Alert for regulatory report approval approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Email_Template_for_regulatory_report_approval_approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_Alert_for_regulatory_report_approval_assignment</fullName>
        <description>Email Alert for regulatory report approval assignment</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Email_Template_for_regulatory_report_approval_assignment</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_Alert_for_regulatory_report_approval_recall</fullName>
        <description>Email Alert for regulatory report approval recall</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Email_Template_for_regulatory_report_approval_recall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_Alert_for_regulatory_report_approval_rejected</fullName>
        <description>Email Alert for regulatory report approval rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Email_Template_for_regulatory_report_approval_rejected</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_Alert_for_regulatory_report_change_due_date_approval_approved</fullName>
        <description>Email Alert for regulatory report change due date approval approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Email_Template_for_regulatory_report_change_due_date_approval_approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_Alert_for_regulatory_report_change_due_date_approval_assignment</fullName>
        <description>Email Alert for regulatory report change due date approval assignment</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Email_Template_for_regulatory_report_change_due_date_approval_assignment</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_Alert_for_regulatory_report_change_due_date_approval_rejected</fullName>
        <description>Email Alert for regulatory report change due date approval rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Email_Template_for_regulatory_report_change_due_date_approval_rejected</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_Alert_for_regulatory_report_change_owner_approval_approved</fullName>
        <description>Email Alert for regulatory report change owner approval approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Email_Template_for_regulatory_report_change_owner_approval_approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_Alert_for_regulatory_report_change_owner_approval_assignment</fullName>
        <description>Email Alert for regulatory report change owner approval assignment</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Email_Template_for_regulatory_report_change_owner_approval_assignment</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_Alert_for_regulatory_report_change_owner_approval_recall</fullName>
        <description>Email Alert for regulatory report change owner approval recall</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Email_Template_for_regulatory_report_change_owner_approval_recall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_Alert_for_regulatory_report_change_owner_approval_rejected</fullName>
        <description>Email Alert for regulatory report change owner approval rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Email_Template_for_regulatory_report_change_owner_approval_rejected</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_Alert_for_regulatory_report_due_date_change_approval_recall</fullName>
        <description>Email Alert for regulatory report due date change approval recall</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Email_Template_for_regulatory_report_due_date_change_approval_recall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_Alert_for_regulatory_report_new_owner_assignment</fullName>
        <description>Email Alert for regulatory report new owner assignment</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Email_Template_for_regulatory_report_new_owner_assignment</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_Alert_for_regulatory_report_owner_upon_regulatory_report_creation</fullName>
        <description>Email Alert for regulatory report owner upon regulatory report creation</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Email_Template_for_regulatory_report_owner_upon_regulatory_report_creation</template>
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
        <fullName>QPMS__Update_Status_As_In_Progress</fullName>
        <description>Update Status As In Progress</description>
        <field>QPMS__Status__c</field>
        <literalValue>In Progress</literalValue>
        <name>Update Status As In Progress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_Status_As_In_Review</fullName>
        <description>Update Status As Pending Review</description>
        <field>QPMS__Status__c</field>
        <literalValue>Pending Review</literalValue>
        <name>Update Status As In Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_Status_As_Open</fullName>
        <description>Update Status As Open</description>
        <field>QPMS__Status__c</field>
        <literalValue>Open</literalValue>
        <name>Update Status As Open</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_Status_As_Pending_Review</fullName>
        <description>Update Status As Pending Review</description>
        <field>QPMS__Status__c</field>
        <literalValue>Pending Review</literalValue>
        <name>Update Status As Pending Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>QPMS__Send email to regulatory report new owner</fullName>
        <actions>
            <name>QPMS__Email_Alert_for_regulatory_report_new_owner_assignment</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Send email to regulatory report new owner</description>
        <formula>ISCHANGED( OwnerId )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Send email to regulatory report owner upon regulatory report creation</fullName>
        <actions>
            <name>QPMS__Email_Alert_for_regulatory_report_owner_upon_regulatory_report_creation</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__Regulatory_Report__c.QPMS__Status__c</field>
            <operation>equals</operation>
            <value>Draft</value>
        </criteriaItems>
        <description>Send email to regulatory report owner upon regulatory report creation</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
