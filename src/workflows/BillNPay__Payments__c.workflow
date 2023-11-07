<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>BillNPay__Send_Payment_Declined</fullName>
        <description>Send Payment Declined</description>
        <protected>false</protected>
        <recipients>
            <field>BillNPay__Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>ar@seattleav.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>BillNPay__Bill_Pay_Templates/BillNPay__Payment_Declined</template>
    </alerts>
    <alerts>
        <fullName>BillNPay__Send_Payment_Receipt</fullName>
        <description>Send Payment Receipt</description>
        <protected>false</protected>
        <recipients>
            <field>BillNPay__Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>finance@seattleav.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>BillNPay__Bill_Pay_Templates/BillNPay__Payment_Receipt</template>
    </alerts>
    <alerts>
        <fullName>BillNPay__Send_Payment_Request</fullName>
        <description>Send Payment Request</description>
        <protected>false</protected>
        <recipients>
            <field>BillNPay__Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>ar@seattleav.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>BillNPay__Bill_Pay_Templates/BillNPay__Send_Payment_Request_Email</template>
    </alerts>
</Workflow>
