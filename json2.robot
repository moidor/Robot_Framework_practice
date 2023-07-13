*** Settings ***
Library    Collections
Library    BuiltIn
Library    Dialogs
Library    OperatingSystem
Library    JSONLibrary
Library    file_treatment.py
# Resource    ../chatgpt/main_keywords.robot
# Resource    ../chatgpt/chatgpt_keywords.robot

*** Variables ***
# ${my_text_file_path2}    

*** Test Cases ***
Loading a text file to create a JSON file
    ${my_text_file_path2}    Set Variable    C:\\Users\\cham.zein\\Documents\\RF_perso\\Robot_Framework_practice-main\\json\\fichier_texte.txt
    Create a JSON file from a dictionary    ${my_text_file_path2}

*** Keywords ***
Create a JSON file from a dictionary
    [Arguments]    ${text_file_path}
    &{read}    read_file_treat_lines    ${text_file_path}       
    Log    ${read}
    # ${key_user}    Set Variable    ${result_from_file}[0]
    # ${value_user}    Set Variable   ${result_from_file}[1]
    # &{dict}    Create Dictionary    ${key_user}=${value_user}
    # Should Be True	${dict} == {${key_user}: ${value_user}}
    Dump JSON To File	${CURDIR}${/}output.json	${read}


# Create a JSON file from a dictionary
    # [Arguments]    ${text_file_path}
    # ${result_from_file}    Open file with conversation    ${text_file_path}
    # ${key_user}    Set Variable    ${result_from_file}[0]
    # ${value_user}    Set Variable   ${result_from_file}[1]
    # &{dict}    Create Dictionary    ${key_user}=${value_user}
    # # Should Be True	${dict} == {${key_user}: ${value_user}}
    # Dump JSON To File	${CURDIR}${/}output.json	${dict}
