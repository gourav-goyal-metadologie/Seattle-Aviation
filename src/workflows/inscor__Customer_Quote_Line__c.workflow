<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>inscor__Update_Customer_Quote_to_in_progress</fullName>
        <field>inscor__Status__c</field>
        <literalValue>In Progress</literalValue>
        <name>Update Customer Quote to in progress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>inscor__Customer_Quote__c</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>inscor__When customer quote line is created</fullName>
        <actions>
            <name>inscor__Update_Customer_Quote_to_in_progress</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>inscor__Customer_Quote_Line__c.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>inscor__Customer_Quote__c.inscor__Status__c</field>
            <operation>equals</operation>
            <value>New</value>
        </criteriaItems>
        <description>Update customer quote record status to In Progress</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
