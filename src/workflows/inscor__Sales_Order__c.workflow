<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Request_for_Billing_Contact</fullName>
        <description>Request for Billing Contact</description>
        <protected>false</protected>
        <recipients>
            <field>inscor__Assigned_To__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>inscor__AvSight/Billing_Contact_is_Not_Available</template>
    </alerts>
</Workflow>
