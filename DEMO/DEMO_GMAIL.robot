*** Settings ***
Suite Setup       Suite Setup
Suite Teardown    Suite Teardown
Test Teardown	  Test Teardown
Library           AndroidGeneric.py

*** Variables ***
${EMAIL}      Amazon
${PATH}    sdcard
${IMAGE}    photo_koala.png

*** Test Cases ***

Insert Attachment
    Insert Attachment    ${MAIL_ID}    ${IMAGE}
	
Report An Email As Spam
    Report An Email As Spam    ${MAIL_ID}
	
Mark An Email Unread
	Mark An Email Unread     ${MAIL_ID}    

Snooze An Email
    Snooze An Email     ${MAIL_ID}    

Delete A Draft
    Delete A Draft     ${MAIL_ID}    

Search Specified Mail
    Search Specified Mail    ${MAIL_ID}
	
Forward Mail
    Forward Mail    ${MAIL_ID}  

Reply Mail
    Reply Mail    ${MAIL_ID}
	
Delete Mail From Inbox
	Delete Mail From Inbox    ${MAIL_ID}     
	
Open Specified Mail From Sent Box
	Open Specified Mail From Sent Box    ${MAIL_ID}    

Empty Trash
    Empty Trash

Compose New Email
    Compose New Email    ${MAIL_ID}

Send Email Multiple Ids
    Send Email Multiple Ids    ${MAIL_ID}    ${MAIL_ID2}

Mark An Email As Important
    Mark An Email As Important    ${MAIL_ID} 	    

*** Keywords ***
Suite Setup
    Print Message    SUITE SETUP HAS STARTED
    Log To Console    ------------------------------------------------------------------------------
    Print Message    Creating driver for device 1.
	&{CAPABILITIES_1}     Create Dictionary     udid=${DEVICE_1_CAP}
    &{DRIVER_1}    Create Android Driver    ${APPIUM_HOST_1}    &{CAPABILITIES_1}
    Set Suite Variable    &{DRIVER_1}

    @{ARGS}=    Create List    GmailSuite.py    GmailSuite    ${DRIVER_1} 
    Import Suite Library    ${ARGS}
	AndroidGeneric.Push File    ${DRIVER_1.driver}    ${PATH}    ${IMAGE}
	Print Message    \n

Suite Teardown
    Run Keyword And Ignore Error    Quit Driver    &{DRIVER_1}

Test Setup
    Print Message    \n
	
Test Teardown
    Run Keyword If Test Failed    Run Keyword And Ignore Error   Capture Screenshot And Logs    &{DRIVER_1}
	Move To Home    &{DRIVER_1}
    Log To Console    ------------------------------------------------------------------------------
