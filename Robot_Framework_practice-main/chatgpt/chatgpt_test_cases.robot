*** Settings ***
Library    RPA.OpenAI
Library    String
Library    OperatingSystem
Test Setup    Make sure that the API key is filled
Resource    chatgpt_keywords.robot
Resource    Image_chatgpt.robot
Resource    main_keywords.robot
    

*** Variables ***
@{chatgpt_conversation}
${my_text}
${my_image}

*** Test Cases ***
Create a complete conversation with a generated image in the end
    [Documentation]    A complete conversation with a generated image in the end
    [Tags]    conversation_chatgpt    complete_conversation    chatgpt
    # Call of the first keyword
    ${first_question_conversation}    Launch ChatGPT asking one question    
    ...    @{chatgpt_conversation}\[]    
    ...    Tell me about a Waikiki Beach-style beach in Hawaii in three lines.
    # Call of the second keyword taking the first conversation in argument
    ${second_question_conversation}    Ask another question related to the previous conversation
    ...    ${first_question_conversation}    
    ...    Can you summarize it in a maximum of three words please.
    Research on Google    ${second_question_conversation}
    Generate an image    ${second_question_conversation}


Test temporaire
    [Tags]    chat    chien
    ${my_text}=    Set Variable    Beach with tropical water and a kayak and dolphins
    # Research on Google    ${my_text}
    Generate an image    ${my_text}
    Log    Salut !


