<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>QPMS__Approval_approved</fullName>
        <description>Approval approved</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Approval_approves_mgr_Approval</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Approval_rejected</fullName>
        <description>Approval rejected</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Approval_rejection_mgr_Approval</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Course_sessions_users</fullName>
        <description>Course sessions users</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Course_Session_for_users</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_Alert_on_Due_Date_Exceed_To_Trainer_Particepent</fullName>
        <description>Email Alert on Due Date Exceed To Trainer Particepent</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Internal_Trainer_s__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Email_Alert_on_Due_Date_Exceed_To_Trainer_Particepent</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Email_alert_for_training_result</fullName>
        <description>Email alert for training result</description>
        <protected>false</protected>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__Reports_To__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Send_an_email_for_training_result_to_participant</template>
    </alerts>
    <alerts>
        <fullName>QPMS__MailForEnrollingUser</fullName>
        <description>MailForEnrollingUser</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__MailForEnrollingUser</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Notify_participant_when_he_enrolled_for_training</fullName>
        <description>Notify participant when , he enrolled for training</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Notify_an_email_when_participant_is_enrolled_for_training</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Notify_participant_when_training_has_been_created</fullName>
        <description>Notify participant when training has been created.</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Training_has_been_created</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Notify_participant_when_training_status_is_Completed</fullName>
        <description>Notify participant when training status is Completed</description>
        <protected>false</protected>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Notify_an_email_to_participant_when_training_status_is_completed</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Notify_participant_when_training_status_is_Inprogress</fullName>
        <description>Notify participant when training status is Inprogress</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Notify_an_email_to_participant_when_training_status_in_Inprogress</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Readandsignoff_for_jb_users</fullName>
        <description>Readandsignoff for jb users</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Readandsignoff_for_jb_users</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Refresher_Notification_for_read_and_sign_off</fullName>
        <description>Refresher Notification for read and sign off</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Refresher_Notification_for_read_and_sign_off</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Refresher_Period_Document_participants</fullName>
        <description>Refresher Period Document participants</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Refresher_Period_Document_participants</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Send_an_email_for_training_result_fail_to_participant</fullName>
        <description>Send an email for training result fail to participant</description>
        <protected>false</protected>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__Reports_To__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Send_an_email_for_training_result_fail_to_participant</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Session_Internal_trainer_email_alert</fullName>
        <description>Session Internal trainer email alert</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Send_an_email_to_internal_trainer_when_session_is_created</template>
    </alerts>
    <alerts>
        <fullName>QPMS__Training_has_been_created_for_document</fullName>
        <description>Training has been created for document</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Training_has_been_created_for_document</template>
    </alerts>
    <alerts>
        <fullName>QPMS__send_mail_to_Manager_on_fail</fullName>
        <description>send mail to Manager on fail</description>
        <protected>false</protected>
        <recipients>
            <field>QPMS__Reports_To__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>QPMS__User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>QPMS__Qualityze_Emails/QPMS__Email_to_Manager</template>
    </alerts>
    <fieldUpdates>
        <fullName>QPMS__AfterApprovalStatusupdate</fullName>
        <description>AfterApprovalStatusupdate</description>
        <field>QPMS__Course_Session_Status__c</field>
        <literalValue>Not Complete</literalValue>
        <name>AfterApprovalStatusupdate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ApprovalProcessStarted</fullName>
        <description>ApprovalProcessStarted</description>
        <field>QPMS__Approval_Process_Complete__c</field>
        <literalValue>0</literalValue>
        <name>ApprovalProcessStarted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__ApprovalRequiredUpdate</fullName>
        <description>ApprovalRequiredUpdate</description>
        <field>QPMS__Approval_Required__c</field>
        <literalValue>0</literalValue>
        <name>ApprovalRequiredUpdate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Custom_Unlock_On_Approval</fullName>
        <description>Custom Unlock On Approval</description>
        <field>QPMS__isLocked__c</field>
        <literalValue>0</literalValue>
        <name>Custom Unlock On Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Initial_approval_status_ins</fullName>
        <description>Initial approval status</description>
        <field>QPMS__Course_Session_Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Initial approval status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Lock_Record</fullName>
        <description>Lock Record</description>
        <field>QPMS__isLocked__c</field>
        <literalValue>1</literalValue>
        <name>Lock Record</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Rejection_Step</fullName>
        <description>Rejection Step</description>
        <field>QPMS__Course_Session_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Rejection Step</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__Update_Approval_status</fullName>
        <description>Update Approval status</description>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Update Approval status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__field_update_for_inprogress</fullName>
        <description>field update for inprogress</description>
        <field>QPMS__Course_Session_Status__c</field>
        <literalValue>Inprogress</literalValue>
        <name>field update for inprogress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QPMS__update_Rejection_status</fullName>
        <description>update Rejection status</description>
        <field>QPMS__Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>update Rejection status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>QPMS__Assessment Failed</fullName>
        <actions>
            <name>QPMS__send_mail_to_Manager_on_fail</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__Result__c</field>
            <operation>equals</operation>
            <value>Fail</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__Course_Session_Status__c</field>
            <operation>equals</operation>
            <value>Incomplete</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__Send_Mail_To_Manager__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__Type__c</field>
            <operation>equals</operation>
            <value>PersonProfileCourseSession</value>
        </criteriaItems>
        <description>Assessment Failed</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Course sessions users</fullName>
        <actions>
            <name>QPMS__Course_sessions_users</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND (2 OR 3 OR 4) AND 5 AND 6</booleanFilter>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__Course_Session_Status__c</field>
            <operation>equals</operation>
            <value>Inprogress</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__Document_Status__c</field>
            <operation>equals</operation>
            <value>Current</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__Document_Status__c</field>
            <operation>equals</operation>
            <value>Prerelease</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__Document_Status__c</field>
            <operation>equals</operation>
            <value>Prereleased</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__Course_Type__c</field>
            <operation>equals</operation>
            <value>Document</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__Type__c</field>
            <operation>equals</operation>
            <value>PersonProfileCourseSession</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Email Alert on Due Date Exceed To Trainer Particepent</fullName>
        <actions>
            <name>QPMS__Email_Alert_on_Due_Date_Exceed_To_Trainer_Particepent</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Email Alert on Due Date Exceed To Trainer Particepent</description>
        <formula>QPMS__DueDate__c == Today()+1</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__MailForEnrollingUser</fullName>
        <actions>
            <name>QPMS__MailForEnrollingUser</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__Course_Session_Status__c</field>
            <operation>equals</operation>
            <value>Enrolled</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__Type__c</field>
            <operation>equals</operation>
            <value>PersonProfileCourseSession</value>
        </criteriaItems>
        <description>MailForEnrollingUser</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Praticipant Enrolled for training</fullName>
        <actions>
            <name>QPMS__Notify_participant_when_he_enrolled_for_training</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__CourseType__c</field>
            <operation>equals</operation>
            <value>Instructor Led</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__Course_Session_Status__c</field>
            <operation>equals</operation>
            <value>Enrolled</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__Type__c</field>
            <operation>equals</operation>
            <value>PersonProfileCourseSession</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Read and Sign off for jb users</fullName>
        <actions>
            <name>QPMS__Readandsignoff_for_jb_users</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND (2 OR 3 OR 4) AND 5</booleanFilter>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__Course_Session_Status__c</field>
            <operation>equals</operation>
            <value>Inprogress</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__Document_Status__c</field>
            <operation>equals</operation>
            <value>Current</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__Document_Status__c</field>
            <operation>equals</operation>
            <value>Prerelease</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__Document_Status__c</field>
            <operation>equals</operation>
            <value>Prereleased</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__Type__c</field>
            <operation>equals</operation>
            <value>ReadAndSignoff</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Refresher Notification for read and sign off</fullName>
        <actions>
            <name>QPMS__Refresher_Notification_for_read_and_sign_off</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Refresher Notification for read and sign off</description>
        <formula>AND(   OR(ISPICKVAL(QPMS__Document__r.QPMS__Status__c, &apos;Current&apos;),ISPICKVAL(QPMS__Document__r.QPMS__Status__c, &apos;Prereleased&apos;)),  ISPICKVAL( QPMS__Course_Session_Status__c , &apos;Completed&apos;),  QPMS__Document__r.QPMS__Take_Assessment__c = false,  QPMS__Refresher_period_notification_document__c = TODAY() , QPMS__Document__r.QPMS__Refresher_Training_Needed__c =True )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Refresher Period Notice Notification Document</fullName>
        <actions>
            <name>QPMS__Refresher_Period_Document_participants</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>AND( ISPICKVAL( QPMS__Course_Session_Status__c , &apos;Completed&apos;),NOT(ISNULL( QPMS__Document__r.QPMS__Refresher_Interval__c )), QPMS__Refresher_period_notification_document__c == TODAY(), QPMS__Document__r.QPMS__Refresher_Training_Needed__c =True)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Send an email for training result</fullName>
        <actions>
            <name>QPMS__Email_alert_for_training_result</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 3 AND (2 OR 4)</booleanFilter>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__isReadandSignOff__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__Result__c</field>
            <operation>equals</operation>
            <value>Pass</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__Course_Session_Status__c</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__Result__c</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <description>Send an email for training result pass</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Send an email for training result fail to participant</fullName>
        <actions>
            <name>QPMS__Send_an_email_for_training_result_fail_to_participant</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__isReadandSignOff__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__Course_Session_Status__c</field>
            <operation>equals</operation>
            <value>Incomplete</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__Result__c</field>
            <operation>equals</operation>
            <value>Fail</value>
        </criteriaItems>
        <description>Send an email for training result fail to participant</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Sending an email to internal trainer</fullName>
        <actions>
            <name>QPMS__Session_Internal_trainer_email_alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND( ISBLANK( QPMS__Course__c ) , NOT( ISBLANK( QPMS__Course_Sessions__c ) ) , ISPICKVAL( QPMS__Type__c , &apos;InternalTrainer&apos;) )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Training has been created for document</fullName>
        <actions>
            <name>QPMS__Training_has_been_created_for_document</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Training has been created for course type document</description>
        <formula>AND( OR( QPMS__Document_Status__c ==&apos;Current&apos;,QPMS__Document_Status__c ==&apos;Prerelease&apos;),ISPICKVAL( QPMS__Course_Session_Status__c , &apos;Inprogress&apos;), ISPICKVAL( QPMS__Type__c , &apos;PersonProfileCourseSession&apos;), ISPICKVAL( QPMS__Course_Type__c , &apos;Document&apos;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Training record has been created</fullName>
        <actions>
            <name>QPMS__Notify_participant_when_training_has_been_created</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Sending an email to the participant, when training record had been created</description>
        <formula>AND( ISPICKVAL(QPMS__Course_Sessions__r.QPMS__Status__c ,&apos;Open Enrollment&apos;),ISPICKVAL( QPMS__Type__c , &apos;PersonProfileCourse&apos;),   QPMS__CourseType__c  =  &apos;Instructor Led&apos;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Training status is completed</fullName>
        <actions>
            <name>QPMS__Notify_participant_when_training_status_is_Completed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__isReadandSignOff__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__Result__c</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__Course_Session_Status__c</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>QPMS__Training status is inprogress</fullName>
        <actions>
            <name>QPMS__Notify_participant_when_training_status_is_Inprogress</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__Course_Type__c</field>
            <operation>equals</operation>
            <value>Instructor Led</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__Type__c</field>
            <operation>equals</operation>
            <value>PersonProfileCourseSession</value>
        </criteriaItems>
        <criteriaItems>
            <field>QPMS__Training_Junction__c.QPMS__Course_Session_Status__c</field>
            <operation>equals</operation>
            <value>Inprogress</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
