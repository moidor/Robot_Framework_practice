*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${url}

*** Keywords ***
Open pictures in browser
    [Documentation]    Call of the browser driver so that to open the url in a maximized window
    [Tags]    browser    webdriver
    [Arguments]    ${url}
    # Avec un keyword appelant le keyword "Create Webdriver"
    # Create a local webdriver    $url
    Open Browser    ${url}    Chrome
    Maximize Browser Window
    Get Window Titles    CURRENT
    Log To Console    Opened picture in the browser at this url : ${url} 

# Create a local webdriver
#     [Documentation]     Creating a local webdriver if not installed as an env. variable
#     [Arguments]    ${url}
#     Create Webdriver    Chrome  executable_path=C:/Users/cham.zein/Documents/chromedriver_win32/chromedriver.exe
#     Go To    ${url}
