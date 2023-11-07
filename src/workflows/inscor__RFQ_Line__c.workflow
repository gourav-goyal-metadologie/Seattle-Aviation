<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>inscor__RFQ_Status_to_In_Progress</fullName>
        <field>inscor__Status__c</field>
        <literalValue>In Progress</literalValue>
        <name>RFQ Status to In Progress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>inscor__RFQ_Number__c</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>inscor__When RFQ line is created</fullName>
        <actions>
            <name>inscor__RFQ_Status_to_In_Progress</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>inscor__RFQ__c.inscor__Status__c</field>
            <operation>equals</operation>
            <value>Requested</value>
        </criteriaItems>
        <criteriaItems>
            <field>inscor__RFQ_Line__c.inscor__Status__c</field>
            <operation>equals</operation>
            <value>New</value>
        </criteriaItems>
        <description>Update RFQ status to In Progress</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
