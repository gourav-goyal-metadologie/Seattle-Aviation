<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__Notify_when_change_Observation_Owner_is_Recalled</fullName>
        <description>Notify when change Observation Owner is Recalled</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Change_Observation_Owner_Recalled</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Notify_when_change_Observation_Owner_is_Rejected</fullName>
        <description>Notify when change Observation Owner is Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Change_Observation_Owner_Rejected</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Notify_when_change_Observation_owner_is_approved</fullName>
        <description>Notify when change Observation owner is approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Change_Observation_Owner_Approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Observation_Record_Approved</fullName>
        <description>Observation Record Approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Observation_Record_Approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Observation_Record_Created</fullName>
        <description>Observation Record Created</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Observation_Record_Created</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Observation_Record_Recall</fullName>
        <description>Observation Record Recall</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Observation_Approval_Recall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Observation_Record_Reject</fullName>
        <description>Observation Record Reject</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Observation_Approval_Reject</template>
    </alerts>
    <fieldUpdates>
        <fullName>QPMS__ChangeFieldApprovalStatusToApproved</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Approved</literalValue>
        <name>ChangeFieldApprovalStatusToApproved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ChangeFieldApprovalStatusToPending</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>ChangeFieldApprovalStatusToPending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ChangeFieldApprovalStatusToRecalled</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Recall</literalValue>
        <name>ChangeFieldApprovalStatusToRecalled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ChangeFieldApprovalStatusToRejected</fullName>
        <field>QPMS__ChangeFieldApprovalStatus__c</field>
        <literalValue>Rejected</literalValue>
        <name>ChangeFieldApprovalStatusToRejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_Enable_Security</fullName>
        <description>Update Enable Security</description>
        <field>QPMS__Enable_Security__c</field>
        <literalValue>1</literalValue>
        <name>Update Enable Security</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>QPMS__Observation Created</fullName>
        <actions>
            <name>QPMS__Observation_Record_Created</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__Observation__c.QPMS__Status__c</field>
            <operation>equals</operation>
            <value>Open</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Update Enable Security</fullName>
        <actions>
            <name>QPMS__Update_Enable_Security</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update Enable Security</description>
        <formula>QPMS__Audit__r.QPMS__Enable_Security__c</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
