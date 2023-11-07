<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>inscor__Set_RMA_Line_Status_To_Cancelled</fullName>
        <field>inscor__Status__c</field>
        <literalValue>Cancelled</literalValue>
        <name>Set RMA Line Status To Cancelled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>inscor__Set_RMA_Line_Status_To_Complete</fullName>
        <field>inscor__Status__c</field>
        <literalValue>Complete</literalValue>
        <name>Set RMA Line Status To Complete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>inscor__Set_RMA_Line_Status_To_Credited</fullName>
        <field>inscor__Status__c</field>
        <literalValue>Credited</literalValue>
        <name>Set RMA Line Status To Credited</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>inscor__Set_RMA_Line_Status_To_Open</fullName>
        <field>inscor__Status__c</field>
        <literalValue>Open</literalValue>
        <name>Set RMA Line Status To Open</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>inscor__Set_RMA_Line_Status_To_Received</fullName>
        <field>inscor__Status__c</field>
        <literalValue>Received</literalValue>
        <name>Set RMA Line Status To Received</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>inscor__Set_RMA_Line_Status_To_Repaired</fullName>
        <field>inscor__Status__c</field>
        <literalValue>Repaired</literalValue>
        <name>Set RMA Line Status To Repaired</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>inscor__RMA Line Status Cancelled</fullName>
        <actions>
            <name>inscor__Set_RMA_Line_Status_To_Cancelled</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Changes the RMA Line status to Cancelled when Qty to Return = 0</description>
        <formula>inscor__Quantity_To_Return__c = 0</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>inscor__RMA Line Status Complete</fullName>
        <actions>
            <name>inscor__Set_RMA_Line_Status_To_Complete</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Changes the RMA Line status to Complete when Qty Credited=Qty Received and Qty Credited = Qty to Return and Qty to Return&lt;&gt;0</description>
        <formula>AND( inscor__Quantity_Credited__c = inscor__Quantity_To_Return__c, inscor__Quantity_To_Return__c &lt;&gt; 0)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>inscor__RMA Line Status Credited</fullName>
        <actions>
            <name>inscor__Set_RMA_Line_Status_To_Credited</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( inscor__Quantity_To_Return__c =  inscor__Quantity_Credited__c, inscor__Quantity_To_Return__c &lt;&gt; 0 )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>inscor__RMA Line Status Open</fullName>
        <actions>
            <name>inscor__Set_RMA_Line_Status_To_Open</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Changes the RMA Line status to Open when Qty to Return &gt; Qty Received and Qty to Return &lt;&gt; 0</description>
        <formula>AND( inscor__Quantity_To_Return__c &lt;&gt; 0, inscor__Quantity_Received__c = 0, inscor__Quantity_Credited__c = 0 )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>inscor__RMA Line Status Received</fullName>
        <actions>
            <name>inscor__Set_RMA_Line_Status_To_Received</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Changes the RMA Line status to Received when Qty to Return=Qty Received and Qty to Return&lt;&gt;Qty Credited and Qty to Return&lt;&gt;0</description>
        <formula>AND( inscor__Quantity_To_Return__c = inscor__Quantity_Received__c,  inscor__Quantity_To_Return__c &lt;&gt;  inscor__Quantity_Credited__c, inscor__Quantity_To_Return__c &lt;&gt; 0)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>inscor__RMA Line Status Repaired</fullName>
        <actions>
            <name>inscor__Set_RMA_Line_Status_To_Repaired</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( inscor__Quantity_To_Return__c =  inscor__Quantity_Received__c, inscor__Quantity_To_Return__c =  inscor__Quantity_Repaired__c, inscor__Quantity_To_Return__c &lt;&gt; 0 )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
