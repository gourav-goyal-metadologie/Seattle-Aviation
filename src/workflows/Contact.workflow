<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <outboundMessages>
        <fullName>ECUSTOMS__RPSContact_PROD</fullName>
        <apiVersion>40.0</apiVersion>
        <description>RPS call for Contacts (PROD)</description>
        <endpointUrl>https://sf.visualcompliance.com/RPS_SF_WS/ContactNotificationService_Managed.asmx</endpointUrl>
        <fields>FirstName</fields>
        <fields>Id</fields>
        <fields>LastName</fields>
        <fields>MailingCity</fields>
        <fields>MailingCountry</fields>
        <fields>MailingState</fields>
        <fields>MailingStreet</fields>
        <includeSessionId>true</includeSessionId>
        <integrationUser>control@seattleav.com</integrationUser>
        <name>RPSContact_PROD</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <outboundMessages>
        <fullName>ECUSTOMS__eCustoms_RPSContact_OM</fullName>
        <apiVersion>32.0</apiVersion>
        <description>eCustoms RPS Contact WS call to test server</description>
        <endpointUrl>https://sftest.visualcompliance.com/RPS_SF_WS/ContactNotificationService_Managed.asmx</endpointUrl>
        <fields>FirstName</fields>
        <fields>Id</fields>
        <fields>LastName</fields>
        <fields>MailingCountry</fields>
        <includeSessionId>true</includeSessionId>
        <integrationUser>control@seattleav.com</integrationUser>
        <name>eCustoms_RPSContact_OM</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <rules>
        <fullName>ECUSTOMS__eCustoms Contact RPS</fullName>
        <active>true</active>
        <description>eCustoms Contact RPS Screening</description>
        <formula>OR(ISNEW(),ISCHANGED(FirstName),ISCHANGED(LastName),ISCHANGED(MailingStreet),ISCHANGED(MailingCity),ISCHANGED(MailingState),ISCHANGED(MailingCountry))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
