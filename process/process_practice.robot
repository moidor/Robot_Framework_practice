*** Settings ***
Documentation       Tags testing in Robot Framework
# Library             Process
Library             OperatingSystem
Library             Dialogs
Library             python_tag_class.py
# Suite Teardown      Terminate All Processes    kill=True

*** Variables ***

# *** Test Cases ***
# Test Case 1
#     [Tags]    smoke
#     Log To Console    This is test case 1

# Test Case 2
#     [Tags]    regression
#     Log To Console    This is test case 2

# Test Case 3
#     [Tags]    regression
#     Log To Console    This is test case 3

# Test Case 4
#     [Tags]    smoke
#     Log To Console    This is test case 4

# Test Case 5
#     [Tags]    sanity
#     Log To Console    This is test case 5

# Launch tag tests
#     Launch tag test - selection

*** Keywords ***
Launch tag test - selection
#    [Arguments]    ${tag_name}
   ${tag_name}    Get Selection From User    Select a tag to execute a test    smoke    sanity    regression    chat
   ${result}    launch_py_tags_test    ${tag_name}
    Should Be Equal As Integers    ${result}    0
    Log    The return code is ${result}
    Log To Console    The return code is ${result}

Launch tag test - value user
    [Documentation]    Very unstable : the letter "o" makes the function stop...
   ${tag_name}    Get Value From User    A tag
   ${result}    launch_py_tags_test    ${tag_name}
    Should Be Equal As Integers    ${result}    0
    Log    The return code is ${result}
    Log To Console    The return code is ${result}
