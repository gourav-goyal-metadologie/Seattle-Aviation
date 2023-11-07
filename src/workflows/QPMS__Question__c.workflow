<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>QPMS__QuestionFieldUpdated</fullName>
        <field>QPMS__Question_In_Group__c</field>
        <formula>LEFT(QPMS__Question__c, 100)</formula>
        <name>QuestionFieldUpdated</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>QPMS__FieldUpdateInQuestion</fullName>
        <actions>
            <name>QPMS__QuestionFieldUpdated</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR( ISNEW(), AND(NOT(ISBLANK(QPMS__Question__c)),ISCHANGED(QPMS__Question__c)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
