*** Settings ***
Documentation    Official documentation of keywords : https://guykisel.github.io/robotframework-faker/
Library     FakerLibrary    locale=fr_FR


*** Test Cases ***
FakerLibrary Words Generation
    ${words}=    FakerLibrary.Words
    Log    words: ${words}
    ${words}=    FakerLibrary.Words    nb=${10}
    Log    words: ${words}
    ${ipv4}=    FakerLibrary.Ipv 4    nb=${10}
    Log    ipv4: ${ipv4}
    