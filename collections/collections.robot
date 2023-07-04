*** Settings ***
Library    Collections


*** Variables ***
# Creation of a dictionary with "&"
&{my_dict}    country=France    city=Paris    dpt_number=75
@{my_list}    Lundi    Mardi    Mercredi    Jeudi    Vendredi    Samedi    Dimanche

*** Test Cases ***
Conversion as a list
    @{dict_converted_as_a_list}    Convert To List    ${my_dict}
    Log List    ${dict_converted_as_a_list}    level=INFO
    Log Dictionary    ${my_dict}

Get values from dictionary
    Log To Console    ${my_dict}[country]
    ${first_index}    Get From List    ${my_list}    0
    Log To Console    ${first_index}

Remove all the keys in dictionary except the specified ones
    Keep In Dictionary    ${my_dict}    country    city
    Log To Console    ${my_dict}

Remove specified values from list
    # Case sensitive
    Remove Values From List    ${my_list}    Mardi    
    Log To Console    ${my_list}

Insert into list and set value
    Insert Into List    ${my_list}    1    Bonjour
    Set List Value    ${my_list}    3    Au revoir
    Log To Console    ${my_list}

List should contain match
    # Every word starting by "M" in capital
    ${matches in list_capital}    Get Matches    ${my_list}    M*
    Log To Console    ${matches in list_capital}
    # Every word starting by "m" or "M"
    ${matches in list}    Get Matches    ${my_list}    m*    case_insensitive=True
    Log To Console    ${matches in list}