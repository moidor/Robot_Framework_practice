*** Settings ***
Documentation       To execute a test case using a tag, write this command in the terminal :robot -d results -i Smoke Tests/Tags.robot
...                 For further information: https://testersdock.com/robot-framework-tags/

Library             RPA.OpenAI
Library             String
Library             OperatingSystem
Library             Screenshot
Library             ..\\process\\python_tag_class.py
Library             Dialogs
# Suite Teardown    Terminate All Processes    kill=True
Resource            chatgpt_keywords.robot
Resource            Image_chatgpt.robot
Resource            main_keywords.robot
# Resource            ..\\process\\process_practice.robot
Resource            d:\\Sauvegarde travaux Cham\\Robot_Framework\\Robot_Framework_practice\\process\\process_practice.robot

Test Setup          Make sure that the API key is filled


*** Variables ***
@{chatgpt_conversation}             @{EMPTY}
${path_text_file_conversation}      chatgpt\\chatgpt_conversations\\conversations.txt
${my_text}                          ${EMPTY}
${my_image}                         ${EMPTY}


*** Test Cases ***
Create a complete conversation from a text file to insert the answers in another text file
    [Documentation]    A complete conversation with a generated image in the end
    [Tags]    conversation    chatgpt
    ${text_file_conversation}    Open file with conversation    ${path_text_file_conversation}
    # Call of the first keyword
    ${first_question_conversation}    Launch ChatGPT asking one question
    ...    @{chatgpt_conversation}\[]
    ...    ${text_file_conversation}
    # Call of the second keyword taking the first conversation in argument
    ${second_question_conversation}    Ask another question related to the previous conversation
    ...    ${first_question_conversation}
    ...    ${text_file_conversation}
    # Getting the content of the first answer from the object
    ${content_entire_conversation}    Set Variable    ${first_question_conversation}[0][1][content]
    ${str_entire_conversation}    Convert To String    ${content_entire_conversation}
    Copy of the conversation in a text file    ${str_entire_conversation}

Create a complete conversation from a text file with a generated image in the end
    [Documentation]    A complete conversation with a generated image in the end
    [Tags]    conversation_chatgpt    complete_conversation    chatgpt
    ${text_file_conversation_first}    ${text_file_conversation_second}
    ...    Open file with conversation    ${path_text_file_conversation}
    # Call of the first keyword
    ${first_question_conversation}    Launch ChatGPT asking one question
    ...    @{chatgpt_conversation}\[]
    ...    ${text_file_conversation_first}
    # Call of the second keyword taking the first conversation in argument
    ${second_question_conversation}    Ask another question related to the previous conversation
    ...    ${first_question_conversation}
    ...    ${text_file_conversation_second}
    # ...    Can you summarize it in a maximum of three words please.
    # Research on Google    ${second_question_conversation}
    Generate an image    ${second_question_conversation}

Generate an image with a template
    [Documentation]    Using the "template" keyword, only the argument is required
    [Tags]    template    image
    [Template]    Generate an image
    Beach with tropical water and a kayak and a coconut floating on the water

Test temporaire
    [Tags]    chat
    ${result}    Launch tag test - selection
    Log    ${result}

Example Test Case
    ${input_string}    Set Variable    Hello, World!
    ${left_part}    Fetch From Right    ${input_string}    ,
    Log    Left part: ${left_part}
    Log To Console    Left part: ${left_part}
    Take Screenshot

# *** Keywords ***
# Launch tag test - selection_2
# #    [Arguments]    ${tag_name}
#    ${tag_name}    Get Selection From User    Select a tag to execute a test    smoke    sanity    regression
#    ${result}    launch_py_tags_test    ${tag_name}
#     Should Be Equal As Integers    ${result}    0
#     Log    The return code is ${result}
#     Log To Console    The return code is ${result}
