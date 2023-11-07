<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>inscor__Set_Allocated_Date</fullName>
        <field>inscor__Fully_Allocated_Date__c</field>
        <formula>TODAY()</formula>
        <name>Set Allocated Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>inscor__Set_SO_Status_to_In_Progress</fullName>
        <field>inscor__Status__c</field>
        <literalValue>In_Progress</literalValue>
        <name>Set SO Status to In Progress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>inscor__Order__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>inscor__Set_Status_to_Cancelled</fullName>
        <field>inscor__Status__c</field>
        <literalValue>Cancelled</literalValue>
        <name>Set Status to Cancelled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>inscor__Set_Status_to_Open</fullName>
        <field>inscor__Status__c</field>
        <literalValue>Open</literalValue>
        <name>Set Status to Open</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>inscor__Update_SOL_Status</fullName>
        <field>inscor__Status__c</field>
        <literalValue>Cancelled</literalValue>
        <name>Update SOL Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>inscor__Update_Status_to_Invoiced</fullName>
        <field>inscor__Status__c</field>
        <literalValue>Invoiced</literalValue>
        <name>Update Status to Invoiced</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>inscor__Update_Status_to_Shipped</fullName>
        <field>inscor__Status__c</field>
        <literalValue>Shipped</literalValue>
        <name>Update Status to Shipped</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>inscor__SO Line Qty Ordered %3D 0</fullName>
        <actions>
            <name>inscor__Set_Status_to_Cancelled</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>inscor__Quantity_Ordered__c = 0</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>inscor__SO Line Qty Ordered %3E Qty Shipped</fullName>
        <actions>
            <name>inscor__Set_Status_to_Open</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>RETIRED</description>
        <formula>AND(inscor__Quantity_Ordered__c &lt;&gt; 0, inscor__Quantity_Ordered__c &gt;  inscor__Quantity_Shipped__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>inscor__SO Line Qty Ordered equal Qty Shipped</fullName>
        <actions>
            <name>inscor__Update_Status_to_Shipped</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>RETIRED</description>
        <formula>AND( inscor__Quantity_Ordered__c = inscor__Quantity_Shipped__c, inscor__Quantity_Ordered__c &lt;&gt; 0, inscor__Quantity_Shipped__c &gt;  inscor__Quantity_Invoiced__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>inscor__Set Allocated Date</fullName>
        <actions>
            <name>inscor__Set_Allocated_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(ISNULL(inscor__Fully_Allocated_Date__c), inscor__Quantity_Ordered__c =  inscor__Quantity_Allocated__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>inscor__Update SOL Status</fullName>
        <actions>
            <name>inscor__Update_SOL_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>RETIRED</description>
        <formula>AND(inscor__Quantity_Ordered__c != null, inscor__Quantity_Ordered__c != 0, inscor__Quantity_Shipped__c != null, inscor__Quantity_Shipped__c != 0, inscor__Quantity_Ordered__c =  inscor__Quantity_Shipped__c)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>inscor__Update Status to Invoiced</fullName>
        <actions>
            <name>inscor__Update_Status_to_Invoiced</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>RETIRED</description>
        <formula>AND( inscor__Quantity_Invoiced__c ==  inscor__Quantity_Ordered__c,  inscor__Quantity_Invoiced__c ==  inscor__Quantity_Shipped__c  , inscor__Quantity_Ordered__c &lt;&gt; 0)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>inscor__When SO Line is created%2E</fullName>
        <actions>
            <name>inscor__Set_SO_Status_to_In_Progress</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>inscor__Sales_Order__c.inscor__Status__c</field>
            <operation>equals</operation>
            <value>New</value>
        </criteriaItems>
        <description>RETIRED</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
