*** Settings ***
Library     RPA.OpenAI
Resource    open_pictures_in_webbrowser.robot
Resource    api_key.robot
Resource    my_variables.robot


*** Keywords ***
Generate an image
    [Documentation]    Generation of an image based on the summarized description from the conversation
    [Tags]    image    image_generation
    [Arguments]    ${image_description}
    Authorize To OpenAI    api_key=${my_api_key}
    ${images}    Image Create
    ...    ${image_description}
    ...    size=512x512
    ...    num_images=2
    FOR    ${url}    IN    @{images}
        Log    ${url}
        Open pictures in browser    ${url}
    END
    
