<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>inscor__Alert_New_Stock_Check_Created</fullName>
        <description>Alert - New Stock Check Created</description>
        <protected>false</protected>
        <recipients>
            <recipient>03346000000cvmqaak@00d8f0000008ameuai</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>inscor__AvSight/inscor__Alert_New_Stock_Check_Created</template>
    </alerts>
    <alerts>
        <fullName>inscor__Alert_Stock_Check_Completed</fullName>
        <description>Alert - Stock Check Completed</description>
        <protected>false</protected>
        <recipients>
            <field>inscor__Requested_by__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>inscor__AvSight/inscor__Alert_Stock_Check_Completed</template>
    </alerts>
</Workflow>
