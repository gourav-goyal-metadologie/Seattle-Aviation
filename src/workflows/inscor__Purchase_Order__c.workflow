<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>inscor__Community_New_PO_Notification</fullName>
        <description>Community : New PO Notification</description>
        <protected>false</protected>
        <recipients>
            <field>inscor__Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>inscor__AvSight_Community/inscor__Community_PO_Notification</template>
    </alerts>
</Workflow>
