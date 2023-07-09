*** Settings ***
Documentation    Testing archive and PDF files like getting the PDF text and insert it in a new zipped text file
Library    OperatingSystem
Library    RPA.Archive
Library    RPA.PDF
Library    String
Library    Collections
Library    doctest

*** Variables ***
${extracted_pdf}    documents\\extracted_zip_archive\\PDF_origine.pdf

*** Test Cases ***
Extraction
    Extract Archive    C:\\Users\\Cham\\Downloads\\code-Part1.zip   ${CURDIR}${/}extracted_zip_archive

PDF File
    Open and zip a PDF file    documents\\pdf_origine.zip    ${CURDIR}${/}extracted_zip_archive
    # C:\\Users\\Cham\\Downloads\\code-Part1.zip
    # ${CURDIR}${/}extracted_zip_archive
    

*** Keywords ***
Open and zip a PDF file
    [Documentation] 
    [Arguments]    ${file_path}    ${output_path}
    # 1. Unzip the pdf file 
    Extract Archive    ${file_path}   ${output_path}
    # 2. Open it from its extraction folder
    ${opened_pdf_file}    Open PDF    ${extracted_pdf}
    # 3. Get its text and store it in a collection/list splitting lines
    ${text_pdf_file}    Get Text From Pdf    ${opened_pdf_file}
    Log    ${text_pdf_file}


