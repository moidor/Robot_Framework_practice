*** Settings ***
Library    RPA.OpenAI
Library    String
Library    OperatingSystem
Library    RPA.FileSystem

*** Variables ***
${path of my file}    Robot_Framework_practice-main/operatingsystem/mon_fichier.txt
${path of new directory}    Robot_Framework_practice-main/operatingsystem/created_directory

*** Test Cases ***
Append content to a text file
    OperatingSystem.Append To File    ${path of my file}    \nSalut !
    ${file_content}    Get File    ${path of my file}
    Log    ${file_content}

Check if the file contains a given string
    Grep File    ${path of my file}    jour    UTF-8
    
Check different features of the read file 
    ${file_size}    Get File Size    ${path of my file}
    Log    ${file_size}
    ${file_owner}    Get File Owner    ${path of my file}
    Log    ${file_owner}
    ${file_name}    Get File Name    ${path of my file}
    Log    ${file_name}
    File Should Exist    ${path of my file}
    File Should Not Be Empty    ${path of my file}

File extension and split
    ${file_extension}    Set Variable    .txt
    ${extension}    Get File Extension    ${path of my file}
    Log    ${extension}
    Run Keyword If    '${extension}' == '${file_extension}'    Log    The file extension is 'txt'
    ...    ELSE    Log    The file extension is not 'txt'
    
    # Getting the extension of the given file in the logs
    Split Extension    ${path of my file}

Create a directory including a new file
    OperatingSystem.Create Directory    ${path of new directory}
    OperatingSystem.Copy File    ${path of my file}    ${path of new directory}/copied_file.txt
    ${copied_file}    Set Variable    ${path of new directory}/copied_file.txt
    OperatingSystem.Append To File    ${copied_file}    \nNew content in the text file !


*** Keywords ***


