*** Settings ***
Library    DatabaseLibrary
Library    OperatingSystem
Library    FakerLibrary    locale=fr_FR
Library    BuiltIn
Suite Setup    Connect to SQLiteDB
Suite Teardown    Disconnect From Database


*** Variables ***
${DB_DRIVER}    sqlite
${DB_NAME}      D:\\Sauvegarde travaux Cham\\Robot_Framework\\Robot_Framework_practice\\database\\my_database.db

*** Test Cases ***
Create person table
    [Tags]    db    smoke
    ${output}    Execute SQL String    CREATE TABLE people (id integer unique,first_name varchar,last_name varchar);
    Log    ${output}
    Should Be Equal As Strings    ${output}    None

Insert data in the "people" table
    [Tags]    db    smoke
    ${output} =    Execute SQL String    INSERT INTO people VALUES('John','Jackson');
    Log    ${output}
    Should Be Equal As Strings    ${output}    None

Insert data from Faker library in the "people" table
    [Tags]    db    smoke    faker
    ${female_french_first_name}    FakerLibrary.First Name Female
    ${female_french_last_name}    FakerLibrary.Last Name Female
    ${output} =    Execute SQL String    INSERT INTO people VALUES('${female_french_first_name}','${female_french_last_name}');
    Log    ${output}
    Should Be Equal As Strings    ${output}    None

Insert a IPv4 column with data on each row in the table
    # A list is created from a query with the library "Database"
    @{rowid_list}    Query    SELECT rowid FROM people    return=list
    FOR    ${iterated_row_id}    IN    @{rowid_list}
        ${ipv4}    FakerLibrary.Ipv 4
        Log To Console    ${ipv4}
        ${output}    Execute Sql String    UPDATE people SET ipv4 = '${ipv4}' WHERE rowid=${iterated_row_id[0]};
    END

Insert three persons generated from FakerLibrary via a "For in range" loop
    FOR    ${counter}    IN RANGE    3
        ${people_first_name}    FakerLibrary.First Name
        ${people_last_name}    FakerLibrary.Last Name
        ${output} =    Execute SQL String    INSERT INTO people VALUES('${people_first_name}','${people_last_name}');
        Log    ${output}
        Should Be Equal As Strings    ${output}    ${None}
    END

Insert data in the "people" table via a SQL script
    [Tags]    db    smoke
    ${output} =    Execute SQL Script    ./${DB_NAME}_insertData.sql
    Log    ${output}
    Should Be Equal As Strings    ${output}    None

Retrieve Data from Database
    @{results}    Query    SELECT * FROM people
    Log Many    ${results}


*** Keywords ***
Connect to SQLiteDB
    [Tags]    db    smoke
    # Comment    Connect To Database Using Custom Params sqlite3 database='path_to_dbfile\dbname.db'
    Connect To Database Using Custom Params    sqlite3    database="${DB_NAME}", isolation_level=None
