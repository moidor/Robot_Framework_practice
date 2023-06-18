*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${url}

*** Keywords ***
Open pictures in browser
    [Arguments]    ${url}
    Open Browser    ${url}    Chrome
    Maximize Browser Window
    Get Window Titles    CURRENT
    Log To Console    Opened picture in the browser this url : ${url} 
