<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>inscor__Alert_EXS_Is_Received</fullName>
        <ccEmails>hcarballosa@inscaletech.com</ccEmails>
        <description>Alert EXS Is Received</description>
        <protected>false</protected>
        <recipients>
            <field>inscor__Assigned_To_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>inscor__AvSight/inscor__EXS_Received</template>
    </alerts>
    <alerts>
        <fullName>inscor__Alert_PO_Is_Received</fullName>
        <ccEmails>hcarballosa@inscaletech.com</ccEmails>
        <description>Alert-PO Is Received</description>
        <protected>false</protected>
        <recipients>
            <field>inscor__Document_Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>inscor__AvSight/inscor__Alert_Your_PO_has_been_received</template>
    </alerts>
    <alerts>
        <fullName>inscor__Alert_WO_Receipt</fullName>
        <ccEmails>hcarballosa@inscaletech.com</ccEmails>
        <description>Alert-WO Receipt</description>
        <protected>false</protected>
        <recipients>
            <field>inscor__Document_Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>inscor__AvSight/inscor__Alert_WO_Receipt</template>
    </alerts>
    <alerts>
        <fullName>inscor__EX_Is_Received</fullName>
        <ccEmails>hcarballosa@inscaletech.com</ccEmails>
        <description>EX Is Received</description>
        <protected>false</protected>
        <recipients>
            <field>inscor__Assigned_To_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>inscor__AvSight/inscor__EX_Received</template>
    </alerts>
    <alerts>
        <fullName>inscor__RMA_Receipt_Notification</fullName>
        <description>RMA Receipt Notification</description>
        <protected>false</protected>
        <recipients>
            <field>inscor__Document_Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>inscor__AvSight/inscor__Receipt_Created_RMA</template>
    </alerts>
    <alerts>
        <fullName>inscor__RO_is_Received</fullName>
        <ccEmails>hcarballosa@inscaletech.com</ccEmails>
        <description>RO is Received</description>
        <protected>false</protected>
        <recipients>
            <field>inscor__Document_Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>inscor__AvSight/inscor__RO_has_been_received</template>
    </alerts>
    <alerts>
        <fullName>inscor__Received_RMA_Alert</fullName>
        <ccEmails>hcarballosa@inscaletech.com</ccEmails>
        <description>Received RMA Alert</description>
        <protected>false</protected>
        <recipients>
            <field>inscor__Assigned_To_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>inscor__AvSight/inscor__RMA_Received</template>
    </alerts>
    <fieldUpdates>
        <fullName>inscor__Update_Assigned_To</fullName>
        <field>inscor__Assigned_To_Email__c</field>
        <formula>IF(
ISPICKVAL(inscor__Document_Type__c , &quot;Purchase Order&quot;),
 inscor__Purchase_Order__r.inscor__Assigned_To__c ,
  IF(
ISPICKVAL(inscor__Document_Type__c , &quot;Repair Order&quot;),
 inscor__Repair_Order__r.inscor__Assigned_To__c, 
 IF(
OR(ISPICKVAL(inscor__Document_Type__c , &quot;RMA&quot;),ISPICKVAL(inscor__Document_Type__c , &quot;Exchange Order&quot;)),
  inscor__Sales_Order_Line__r.inscor__Order__r.inscor__Assigned_To__c , 
&apos;&apos;) ) 
)</formula>
        <name>Update Assigned To</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
</Workflow>
