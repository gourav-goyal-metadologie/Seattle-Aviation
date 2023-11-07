<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__PurchaseOrder_Creation</fullName>
        <description>PurchaseOrder Creation</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Inspection_PurchaseOrder_Creation</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Purchase_Order_Approval_Assignment</fullName>
        <description>Purchase Order Approval Assignment</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Purchase_Order_Approval_Request</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Purchase_Order_Recalled</fullName>
        <description>Purchase Order Recalled</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Purchase_Order_Recall</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Purchase_Order_Record_Approved</fullName>
        <description>Purchase Order Record Approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Purchase_Order_Approved</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Purchase_Order_Rejected</fullName>
        <description>Purchase Order Rejected</description>
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
            <field>QPMS__Approver_8__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver_9__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Purchase_Order_Rject</template>
    </alerts>
    <fieldUpdates>
        <fullName>QPMS__Approval_Status_Pending_Approval</fullName>
        <description>Approval Status Pending Approval</description>
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
        <description>Approval Status Rejected</description>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Approval Status Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__CurrentApprovalSequenceOnRejection</fullName>
        <description>CurrentApprovalSequenceOnRejection</description>
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
        <description>CurrentApproval SequenceOnRecall</description>
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
        <description>Custom Lock</description>
        <field>QPMS__isLocked__c</field>
        <literalValue>1</literalValue>
        <name>Custom Lock</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__PO_Status</fullName>
        <description>PO Status</description>
        <field>QPMS__Status__c</field>
        <literalValue>Draft</literalValue>
        <name>PO Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__PO_status_update_on_recall</fullName>
        <description>PO status update on recall</description>
        <field>QPMS__Status__c</field>
        <literalValue>Draft</literalValue>
        <name>PO status update on recall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__approval_status_update</fullName>
        <description>approval status update</description>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>approval status update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__change_po_status</fullName>
        <description>change po status</description>
        <field>QPMS__Status__c</field>
        <literalValue>InReview</literalValue>
        <name>change po status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__customUnlock</fullName>
        <description>customUnlock</description>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>customUnlock</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__islock_final_approval</fullName>
        <description>islock final approval</description>
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
        <description>unlock record</description>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>unlock record</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>QPMS__Send Email When PurchaseOrder is Created</fullName>
        <actions>
            <name>QPMS__PurchaseOrder_Creation</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__Purchase_Order__c.QPMS__Status__c</field>
            <operation>equals</operation>
            <value>Draft</value>
        </criteriaItems>
        <description>email will sent when PurchaseOrder is created</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
