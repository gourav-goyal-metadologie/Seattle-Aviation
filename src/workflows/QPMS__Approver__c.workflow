<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__Email_To_Approver_Manager_On_Due_Date_Exceed</fullName>
        <description>Email To Approver Manager On Due Date Exceed</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Approval_assignment</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_To_Approver_On_Due_Date_Exceed</fullName>
        <description>Email To Approver On Due Date Exceed</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Approval_assignment</template>
    </alerts>
</Workflow>
