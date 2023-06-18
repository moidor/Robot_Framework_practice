*** Settings ***
Library     RPA.OpenAI
Resource    Open_pictures_in_browser.robot

*** Variables ***
${mon_api_key}      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

*** Keywords ***
Generate an image
    [Arguments]    ${image_description}
    Authorize To OpenAI    api_key=${mon_api_key}
    ${images}    Image Create
    ...    ${image_description}
    ...    size=512x512
    ...    num_images=2
    FOR    ${url}    IN    @{images}
        Log    ${url}
        Open pictures in browser    ${url}
    END
    
