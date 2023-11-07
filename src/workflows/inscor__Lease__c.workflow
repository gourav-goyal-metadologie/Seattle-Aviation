<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>inscor__Community_New_Lease_Notification</fullName>
        <description>Community : New Lease Notification</description>
        <protected>false</protected>
        <recipients>
            <field>inscor__Assigned_To__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>inscor__AvSight_Community/inscor__Community_Lease_Notification</template>
    </alerts>
</Workflow>
