<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>DNBI__Send_Credit_Status_Change_Notification_Account</fullName>
        <description>Send Credit Status Change Notification for Account</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>DNBI__DNBI_email_Templates/DNBI__DNBI_Credit_Information_Update_for_Account</template>
    </alerts>
    <outboundMessages>
        <fullName>ECUSTOMS__RPSAccount_PROD</fullName>
        <apiVersion>40.0</apiVersion>
        <description>RPS screening (PROD) for accounts</description>
        <endpointUrl>https://sf.visualcompliance.com/RPS_SF_WS/AccountNotificationService_Managed.asmx</endpointUrl>
        <fields>BillingCity</fields>
        <fields>BillingCountry</fields>
        <fields>BillingState</fields>
        <fields>BillingStreet</fields>
        <fields>Id</fields>
        <fields>Name</fields>
        <includeSessionId>true</includeSessionId>
        <integrationUser>control@seattleav.com</integrationUser>
        <name>RPSAccount_PROD</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <outboundMessages>
        <fullName>ECUSTOMS__eCustoms_RPSAccount_OM</fullName>
        <apiVersion>32.0</apiVersion>
        <description>RPS Screening using eCustoms NameSpace using testsite</description>
        <endpointUrl>https://sftest.visualcompliance.com/RPS_SF_WS/AccountNotificationService_Managed.asmx</endpointUrl>
        <fields>AccountNumber</fields>
        <fields>BillingCountry</fields>
        <fields>Id</fields>
        <fields>Name</fields>
        <includeSessionId>true</includeSessionId>
        <integrationUser>control@seattleav.com</integrationUser>
        <name>eCustoms_RPSAccount_OM</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <rules>
        <fullName>DNBI__Account Credit Status Change</fullName>
        <actions>
            <name>DNBI__Send_Credit_Status_Change_Notification_Account</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Account Credit Status Change notification email</description>
        <formula>AND(ISCHANGED(DNBI__DnB_Application_Modified_Date__c),  $Setup.DNBI__EnableStatusEmailNotification1__c.DNBI__Enable_Email_Notification__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ECUSTOMS__eCustoms Account RPS</fullName>
        <active>true</active>
        <description>eCustoms  Account RPS Workflow Rule</description>
        <formula>OR(isNew(), isChanged( Name ), isChanged( BillingCity ), isChanged( BillingState ), isChanged( BillingCountry ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
