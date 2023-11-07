<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>QPMS__Number_Scheme_Name</fullName>
        <field>QPMS__Name_Module__c</field>
        <formula>Name +&apos;&apos;+ TEXT( QPMS__Module__c )+&apos;&apos;+ QPMS__Site__c</formula>
        <name>Number Scheme Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_Scheme_Formate</fullName>
        <description>Update scheme(Prefix_Number_format_Suffix_Revision__c) used in validation</description>
        <field>QPMS__Prefix_Number_format_Suffix_Revision__c</field>
        <formula>QPMS__Prefix__c +&apos;&apos;+ IF(ISNUMBER(QPMS__Number_format__c), &apos;ISNUMBER&apos;,&apos;ISTEXT&apos;) +&apos;&apos;+ QPMS__Suffix__c +&apos;&apos;+ TEXT(QPMS__Revision__c)</formula>
        <name>Update Scheme Formate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>QPMS__Update Scheme</fullName>
        <actions>
            <name>QPMS__Number_Scheme_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QPMS__Update_Scheme_Formate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__Number_Scheme__c.CreatedDate</field>
            <operation>notEqual</operation>
            <value>&quot;10/8/1990, 10:30 AM&quot;</value>
        </criteriaItems>
        <description>Used For Validation for clone</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
