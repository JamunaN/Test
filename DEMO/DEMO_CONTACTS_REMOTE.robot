*** Settings ***
Suite Setup       Suite Setup
Suite Teardown    Suite Teardown
Test Teardown     Test Teardown
Library           AndroidGeneric.py
Library           STFClient.py


*** Variables ***
${NAME}           Alvin
${NUMBER}         9999999999
${NEW_NAME}       Simon
${NEW_NUMBER}     8888888888
${LINK_NAME}      Theodore

*** Test Cases ***
TC_CREATE_CONTACT
	Add Contact    ${NAME}    ${NUMBER}

TC_EDIT_CONTACT_NAME
	Edit Contact Name    ${NAME}    ${NEW_NAME}

TC_EDIT_CONTACT_NUMBER
	Edit Contact Number    ${NEW_NAME}    ${NUMBER}    ${NEW_NUMBER}

TC_SET_AS_FAVORITE
	Set Contact As Favorite    ${NEW_NAME}

TC_LINK_CONTACT
	Create And Link Contact    ${NEW_NAME}    ${LINK_NAME}

TC_CALL_CONTACT
	Make Call To Contact    ${NEW_NAME}
	
*** Keywords ***
Suite Setup
	Print Message    SUITE SETUP HAS STARTED
    Log To Console    ------------------------------------------------------------------------------
    Initialize Stf Connection    ${STF_ADDRESS}    ${TOKEN}
    Print Message    Creating driver for device 1.
    @{DEVICE_1}     Connect To Device    ${DEVICE_1_CAP}
    &{CAPABILITIES_1}     Create Dictionary     udid=@{DEVICE_1}[1]
    &{DRIVER_1}    Create Android Driver    ${APPIUM_HOST_1}    &{CAPABILITIES_1}
    Set Suite Variable    &{DRIVER_1}
    @{ARGS}=    Create List    DemoContacts.py    Test    ${DRIVER_1}
    Import Suite Library    ${ARGS}

Suite Teardown
    Run Keyword And Ignore Error    Quit Driver    &{DRIVER_1}
    Release All Connected Devices In Current Session

Test Setup
    Print Message    \n

Test Teardown
    Run Keyword If Test Failed    Run Keyword And Ignore Error    Capture Screenshot And Logs    &{DRIVER_1}
    Move To Home    &{DRIVER_1}
    Log To Console    ------------------------------------------------------------------------------

