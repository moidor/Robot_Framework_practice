*** Settings ***
Library     RPA.OpenAI
Resource    Open_pictures_in_browser.robot
Resource    api_key.robot

*** Variables ***
# La variable "my_personal_api_key" provient du fichier "api_key.robot" importé via le mot-clé Resource car elle contient la donnée sensible
${local_variable_api_key}    ${my_personal_api_key}

*** Keywords ***
Generate an image
    [Arguments]    ${image_description}
    Authorize To OpenAI    api_key=${local_variable_api_key}
    ${images}    Image Create
    ...    ${image_description}
    ...    size=512x512
    ...    num_images=2
    FOR    ${url}    IN    @{images}
        Log    ${url}
        Open pictures in browser    ${url}
    END
    
