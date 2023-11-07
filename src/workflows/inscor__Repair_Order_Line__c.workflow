<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>inscor__Copy_Expected_Part_Serial</fullName>
        <field>inscor__Expected_Part_Serial__c</field>
        <formula>inscor__Original_Part_Serial__c</formula>
        <name>Copy Expected Part Serial</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>inscor__RO_Line_set_status_to_Received</fullName>
        <field>inscor__Status__c</field>
        <literalValue>Received</literalValue>
        <name>RO Line set status to Received</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>inscor__RO_Status_In_Progress</fullName>
        <field>inscor__Status__c</field>
        <literalValue>In Progress</literalValue>
        <name>RO_Status_In_Progress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>inscor__Repair_Order__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>inscor__Set_Status_to_Shipped</fullName>
        <field>inscor__Status__c</field>
        <literalValue>Shipped</literalValue>
        <name>Set Status to Shipped</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>inscor__Update_Orignal_Repair_Value</fullName>
        <field>inscor__Orignal_Quantity_To_Repair__c</field>
        <formula>inscor__Quantity_to_Repair__c</formula>
        <name>Update Orignal Repair Value</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>inscor__Copy Expected Part Serial</fullName>
        <actions>
            <name>inscor__Copy_Expected_Part_Serial</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED(inscor__Original_Inventory_Line__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>inscor__RO Line when Qty Shipped %3D Qty Received</fullName>
        <actions>
            <name>inscor__RO_Line_set_status_to_Received</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>RETIRED</description>
        <formula>AND(inscor__Quantity_Shipped__c  =  inscor__Quantity_Received__c, inscor__Quantity_to_Repair__c =  inscor__Quantity_Received__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>inscor__RO Line when Qty to Repair %3D Qty Shipped</fullName>
        <actions>
            <name>inscor__Set_Status_to_Shipped</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>RETIRED</description>
        <formula>AND(inscor__Quantity_to_Repair__c = inscor__Quantity_Shipped__c, OR(inscor__Quantity_Shipped__c &lt;&gt;   inscor__Quantity_Received__c,ISNULL(inscor__Quantity_Received__c )))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>inscor__Status in Progress</fullName>
        <actions>
            <name>inscor__RO_Status_In_Progress</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>inscor__Repair_Order__c.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>RETIRED</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>inscor__Update Orignal Repair Value</fullName>
        <actions>
            <name>inscor__Update_Orignal_Repair_Value</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>inscor__Repair_Order_Line__c.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
