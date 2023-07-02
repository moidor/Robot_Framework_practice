*** Settings ***
Library    RPA.OpenAI
Library    String
Library    OperatingSystem
Library    Collections
Resource    Image_chatgpt.robot
Resource    api_key.robot
Resource    main_keywords.robot
Resource    my_variables.robot


*** Keywords ***
Launch ChatGPT asking one question
    [Documentation]    Call OpenAI Chat Completion API to generate a response in French.
    [Arguments]    ${chatgpt_conversation}    ${launching_question}
    Authorize To OpenAI    api_key=${my_api_key}
    # Get response without conversation history.
    ${response}   @{chatgpt_conversation}=     Chat Completion Create
    ...    temperature=0.6
    ...    user_content=${launching_question}
    Evaluate the type of a given variable    ${chatgpt_conversation}
    Log    ${response}
    [Return]    ${chatgpt_conversation}

Ask another question related to the previous conversation
    [Documentation]    Continue the conversation by using the "conversation" argument and generating an image
    [Arguments]    ${conversation}    ${new_question}
    # Continue the conversation by using the "conversation" argument.
    Evaluate the type of a given variable    ${conversation}
    ${response}   @{conversation}=     Chat Completion Create
    ...    conversation=${conversation}
    ...    user_content=${new_question}
    Log    ${response}
    Should Be String    ${response}
    [Return]    \n${response}
    
Copy of the conversation in a text file
    [Documentation]    The content of the first and second answers from ChatGPT is inserted in a text file in a new directory
    [Tags]    file    copy
    [Arguments]    ${conversation}
    ${path_new_directory}    Set Variable    Robot_Framework_practice-main/chatgpt_answers
    ${path_answers_file}    Set Variable    Robot_Framework_practice-main/chatgpt/chatgpt_answers/answers.txt
    OperatingSystem.Create Directory    ${path_new_directory}
    OperatingSystem.Create File    ${path_answers_file}
    # Créer un nouveau fichier à chaque fois pour ne pas écraser le précédent ???
    OperatingSystem.Append To File    ${path_answers_file}    ${conversation}

Open file with conversation
    [Documentation]    Open a text file containing the conversation to pass as an argument to the ChatGPT keyword
    [Arguments]    ${path_text_file_conversation} 
    ${text_file_conversation}    Get File    ${path_text_file_conversation}  
    ${right_part_first}    Fetch From Right    ${text_file_conversation}    first;
    ${right_part_second}    Fetch From Right    ${text_file_conversation}    second;
    Log    ${text_file_conversation}
    Log    ${right_part_first}
    Log    ${right_part_second}
    [Return]    ${right_part_first}    ${right_part_second}
