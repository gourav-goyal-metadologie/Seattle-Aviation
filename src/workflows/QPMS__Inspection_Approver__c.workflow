<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__Inspection_Reassign</fullName>
        <description>Inspection Reassign</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__INS_Inspection_Reassign</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Inspection_Standard_Reassign</fullName>
        <description>Inspection Standard Reassign</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__INS_IS_Reassign</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Inspection_Task_Reassign</fullName>
        <description>Inspection Task Reassign</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__INS_Inspection_Task_Reassign</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Purchase_Order_Reassign</fullName>
        <description>Purchase Order Reassign</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__INS_IS_Reassign</template>
    </alerts>
    <rules>
        <fullName>QPMS__INS IS Reassign</fullName>
        <actions>
            <name>QPMS__Inspection_Standard_Reassign</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(QPMS__User__c != PRIORVALUE(QPMS__User__c),ISPICKVAL( QPMS__Status__c , &apos;Pending&apos;), QPMS__Inspection_Standard__c !=null)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__INS Inspection Reassign</fullName>
        <actions>
            <name>QPMS__Inspection_Reassign</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>This is used for  inspection reassign approver.</description>
        <formula>AND(QPMS__User__c != PRIORVALUE(QPMS__User__c),QPMS__Inspection__c !=null)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__INS Inspection Task Reassign</fullName>
        <actions>
            <name>QPMS__Inspection_Task_Reassign</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>This is used for  inspection  task reassign approver.</description>
        <formula>AND(QPMS__User__c != PRIORVALUE(QPMS__User__c),QPMS__Inspection_Task__c !=null)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__INS PO Reassign</fullName>
        <actions>
            <name>QPMS__Purchase_Order_Reassign</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>This is used for reassign approver.</description>
        <formula>AND(QPMS__User__c != PRIORVALUE(QPMS__User__c),QPMS__Purchase_Order__c !=null)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
