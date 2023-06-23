*** Settings ***
Library    RPA.OpenAI
Library    String
Library    OperatingSystem
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
    [Return]    ${response}
    