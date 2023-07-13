*** Settings ***
Library    JSONLibrary
Library    Collections
Library    BuiltIn
Library    Dialogs
Library    file_treatment.py
Resource    ../chatgpt/main_keywords.robot
Resource    ../chatgpt/chatgpt_keywords.robot

*** Variables ***
${my_text_file_path}    C:\\Users\\cham.zein\\Documents\\RF_perso\\Robot_Framework_practice-main\\json\\fichier_texte.txt
# ${right_part_first}
# ${right_part_second}

*** Test Cases ***
Convert to JSON and get a value
    ${my_string}    Set Variable    {"name": "John", "phone_number": "123456789"}
    ${json_object}    Convert String to JSON    ${my_string}
    ${values}    Get Value From JSON    ${json_object}    $..phone_number
    Log    ${values}

Loading a JSON file and read values
    ${json_file_content}    Load Json From File    Robot_Framework_practice-main\\json\\json_example.json
    # Getting the value of the "answer" attribute in the "maths" object
    ${values_from_json_file}    Get Value From JSON    ${json_file_content}    $..sport..q1..answer
    Log    ${json_file_content}
    ${converted_value}    Convert To Upper Case     ${values_from_json_file}[0]
    Log    ${converted_value}

Loading a text file to create a JSON file
    Create a JSON file from a dictionary    ${my_text_file_path}

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
