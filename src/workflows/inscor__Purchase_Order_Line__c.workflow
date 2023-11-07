<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>inscor__Set_PO_Status_to_In_Progress</fullName>
        <field>inscor__Status__c</field>
        <literalValue>In Progress</literalValue>
        <name>Set PO Status to In Progress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>inscor__PO_Number__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>inscor__Update_Status_to_Cancelled</fullName>
        <field>inscor__Status__c</field>
        <literalValue>Cancelled</literalValue>
        <name>Update Status to Cancelled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>inscor__Update_Status_to_Open</fullName>
        <field>inscor__Status__c</field>
        <literalValue>Open</literalValue>
        <name>Update Status to Open</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>inscor__Update_Status_to_Received</fullName>
        <field>inscor__Status__c</field>
        <literalValue>Received</literalValue>
        <name>Update Status to Received</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>inscor__Set PO Status to In Progress</fullName>
        <actions>
            <name>inscor__Set_PO_Status_to_In_Progress</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>inscor__Purchase_Order_Line__c.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>inscor__Purchase_Order__c.inscor__Status__c</field>
            <operation>equals</operation>
            <value>New</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>inscor__Update Status to Cancelled</fullName>
        <actions>
            <name>inscor__Update_Status_to_Cancelled</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>inscor__Quantity__c == 0</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>inscor__Update Status to Open</fullName>
        <actions>
            <name>inscor__Update_Status_to_Open</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>RETIRED</description>
        <formula>AND( inscor__Quantity__c &lt;&gt; 0,  inscor__Quantity_Received__c &lt;&gt;  inscor__Quantity__c )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>inscor__Update Status to Received</fullName>
        <actions>
            <name>inscor__Update_Status_to_Received</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>RETIRED</description>
        <formula>AND( inscor__Quantity__c &lt;&gt; 0,  inscor__Quantity__c =  inscor__Quantity_Received__c )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
