*** Settings ***
Documentation     Keywords e Variables para ações login_keyword_keyword
Resource          ../support/base.robot


*** Variables ***




*** Keywords ***
Executar login
    &{payload}=    Create Dictionary    
    ...    email=${EMAIL}    
    ...    password=${PASSWORD}
    ${response}    POST On Session    serverest    /login    data=${payload}
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}
    


#Validar status code
