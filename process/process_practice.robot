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
Launch tag test in Python - command line
    [Documentation]    Indicate the command line part after "robot -d results" 
    ...    to execute tag tests in a more flexible way than the other keyword "Launch tag test - tag name and path file".
    ...    The keyword already contains the first part of the command line : "robot -d results"; just add the rest.
    [Arguments]    ${command_line}
    ${result}    Launch Py Tags Command Line    ${command_line}
    Should Be Equal As Integers    ${result}    0
    Log    The return code is ${result}
    Log To Console    The return code is ${result}

Launch tag test with a command line
    [Documentation]    Execution of a command line through the "Run" keyword in the OperatingSystem library
    [Arguments]    ${command_line}
    ${result}    Run    ${command_line}
    # Should Be Equal As Integers    ${result}    0
    Log    The return code is ${result}
    Log To Console    The return code is ${result}


# Launch tag test - tag name and path file
#     [Documentation]    Indicate first the tag, then the path and finally optional tags to target several tags during execution
#     [Arguments]    ${tag_name}    ${path_tests_file}    ${tag_name_2}=${None}
#    ${result}    launch_py_tags_test    ${tag_name}    ${path_tests_file}    ${tag_name_2}
#     Should Be Equal As Integers    ${result}    0
#     Log    The return code is ${result}
#     Log To Console    The return code is ${result}

# Launch tag test - selection
#    ${tag_name}    Get Selection From User    Select a tag to execute a test    smoke    sanity    regression    chat
#    ${result}    launch_py_tags_test    ${tag_name}    ${path_tests_file}
#     Should Be Equal As Integers    ${result}    0
#     Log    The return code is ${result}
#     Log To Console    The return code is ${result}

# Launch tag test - value user
#     [Documentation]    Very unstable : the letter "o" makes the function stop...
#    ${tag_name}    Get Value From User    A tag
#    ${result}    launch_py_tags_test    ${tag_name}    ${path_tests_file}
#     Should Be Equal As Integers    ${result}    0
#     Log    The return code is ${result}
#     Log To Console    The return code is ${result}
