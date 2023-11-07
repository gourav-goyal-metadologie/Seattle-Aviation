<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Alert_Release_on_Hold_Export_Hold</fullName>
        <ccEmails>quality@seattleav.com</ccEmails>
        <description>Alert- Release on Hold (Export Hold)</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <senderAddress>notifications@seattleav.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Release_On_Hold_Alert_Export</template>
    </alerts>
    <alerts>
        <fullName>Release_on_hold_Email_Alert</fullName>
        <description>Release on hold Email Alert</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>notifications@seattleav.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Release_on_hold</template>
    </alerts>
    <alerts>
        <fullName>inscor__Alert_Relase_Line_Shipped</fullName>
        <description>Alert- Release Line Shipped</description>
        <protected>false</protected>
        <recipients>
            <field>inscor__Billing_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>inscor__AvSight/inscor__Shipment_Confirmation</template>
    </alerts>
    <alerts>
        <fullName>inscor__Alert_Release_on_Hold</fullName>
        <ccEmails>finance@seattleav.com</ccEmails>
        <description>Alert- Release on Hold</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <senderAddress>notifications@seattleav.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Release_on_hold</template>
    </alerts>
    <rules>
        <fullName>Release on hold WF Rule</fullName>
        <actions>
            <name>Release_on_hold_Email_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>inscor__Release__c.inscor__Export_Status__c</field>
            <operation>equals</operation>
            <value>On Hold</value>
        </criteriaItems>
        <criteriaItems>
            <field>inscor__Release__c.Compliance_Status__c</field>
            <operation>equals</operation>
            <value>Upload Successful</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
