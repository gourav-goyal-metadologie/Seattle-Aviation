<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>DNBI__Send_Credit_Status_Change_Notification_for_Opportunity</fullName>
        <description>Send Credit Status Change Notification for Opportunity</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>DNBI__DNBI_email_Templates/DNBI__DNBI_Credit_Information_Update_for_Opportunity</template>
    </alerts>
    <fieldUpdates>
        <fullName>ECUSTOMS__RPS_ACC_Trigger</fullName>
        <field>ECUSTOMS__Screening_Trigger__c</field>
        <literalValue>1</literalValue>
        <name>RPS_ACC_Trigger</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>AccountId</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>DNBI__Opportunity Credit Status Change</fullName>
        <actions>
            <name>DNBI__Send_Credit_Status_Change_Notification_for_Opportunity</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(ISCHANGED(DNBI__DnB_Application_Modified_Date__c), $Setup.DNBI__EnableStatusEmailNotification1__c.DNBI__Enable_Email_Notification__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ECUSTOMS__OppProbability</fullName>
        <actions>
            <name>ECUSTOMS__RPS_ACC_Trigger</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND( OR( Account.ECUSTOMS__RPS_Status__c  = &apos;&apos; ,Account.ECUSTOMS__RPS_Status__c  = &apos;Pending&apos;) , Probability &gt; 0.40)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
