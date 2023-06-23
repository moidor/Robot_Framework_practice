*** Settings ***
Library    OperatingSystem
Library    String
Library    SeleniumLibrary

*** Variables ***
${cookies_rejection}    W0wltc

*** Keywords ***
Evaluate the type of a given variable
    [Documentation]    Give in arguments the expected variable and its type
    [Tags]    variable_type    type
    [Arguments]    ${given_variable}
    ${variable_type}    Evaluate    type(${given_variable})

Research on Google
    [Documentation]    . Take an argument from a direct question or the ChatGPT conversation
    [Tags]    google    google_research
    [Arguments]    ${research_text}
    Open Browser    https://google.fr/    Chrome
    Maximize Browser Window
    Get Window Titles    CURRENT
    Click Button    ${cookies_rejection}
    Input Text    //*[@id="APjFqb"]    ${research_text}
    # \\13 représente le code ASCII pour la touche "Entrée"
    Press Keys    //*[@id="APjFqb"]    RETURN


