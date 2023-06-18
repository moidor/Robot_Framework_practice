*** Settings ***
Library    RPA.OpenAI
Library    String
Library    OperatingSystem
Resource    Image_chatgpt.robot
Resource    api_key.robot

*** Variables ***
# La variable "my_personal_api_key" provient d'un fichier importé via le mot-clé Resource car elle contient la donnée sensible
${local_variable_api_key}    ${my_personal_api_key}

*** Tasks ***
Create a text completion
    [Documentation]    Call OpenAI Chat Completion API to generate a response in French.
    Authorize To OpenAI    api_key=${local_variable_api_key}
    # Get response without conversation history.
    ${response}   @{chatgpt_conversation}=     Chat Completion Create
    ...    temperature=0.6
    ...    user_content=Tell me about the Molokini crater in Hawaii please !
    Log    ${response}
    # Generate an image    ${response}[0:50]
    Ask another question related to the previous conversation
    ...    ${chatgpt_conversation}
    ...    Résume-moi le sujet abordé


*** Keywords ***
Ask another question related to the previous conversation
    [Arguments]    ${conversation}    ${new_question}
    # Continue the conversation by using the "conversation" argument.
    ${response}   @{conversation}=     Chat Completion Create
    ...    conversation=${conversation}
    ...    user_content=${new_question}
    Log    ${response}
    ${response_string}    Should Be String    ${response}
    Generate an image    ${response}
