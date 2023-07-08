*** Settings ***
Documentation       Tag testing keywords
# Library             Process
Library             OperatingSystem
Library             Dialogs
Library             python_tag_class.py
# Suite Teardown      Terminate All Processes    kill=True

*** Variables ***
${path_tests_file}
${tag_name}

*** Keywords ***
Launch tag test - tag name and path file
    [Arguments]    ${tag_name}    ${path_tests_file}
   ${result}    launch_py_tags_test    ${tag_name}    ${path_tests_file}
    Should Be Equal As Integers    ${result}    0
    Log    The return code is ${result}
    Log To Console    The return code is ${result}

Launch tag test - selection
   ${tag_name}    Get Selection From User    Select a tag to execute a test    smoke    sanity    regression    chat
   ${result}    launch_py_tags_test    ${tag_name}    ${path_tests_file}
    Should Be Equal As Integers    ${result}    0
    Log    The return code is ${result}
    Log To Console    The return code is ${result}

Launch tag test - value user
    [Documentation]    Very unstable : the letter "o" makes the function stop...
   ${tag_name}    Get Value From User    A tag
   ${result}    launch_py_tags_test    ${tag_name}    ${path_tests_file}
    Should Be Equal As Integers    ${result}    0
    Log    The return code is ${result}
    Log To Console    The return code is ${result}
