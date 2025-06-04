*** Settings ***
Documentation     Keywords e Variables para ações usuarios_keyword_keyword
Resource          ../support/base.robot



*** Keywords ***
POST /usuarios
    [Arguments]    ${email}=${EMAIL}    ${password}=${PASSWORD}
    ${payload}=    Create Dictionary
    ...    nome=Fulano da Silva   
    ...    email=${email}    
    ...    password=${password}
    ...    administrador=true
    ${response}=    POST Request    serverest    /usuarios    json=${payload}
    
GET /usuarios
    ${response}=    GET Request    serverest    /usuarios
    [Return]    ${response}

GET /usuarios/ID
    [Arguments]    ${id}
    ${response}=    GET Request    serverest    /usuarios/${id}
    [Return]    ${response}

DELETE /usuario
    [Arguments]    ${id}
    ${response}=    DELETE Request    serverest    /usuarios/${id}
    [Return]    ${response}

PUT /usuario
    [Arguments]    ${id}    ${email}=${EMAIL}    ${password}=${PASSWORD}
    ${payload}=    Create Dictionary
    ...    nome=Fulano da Silva Atualizado
    ...    email=${email}
    ...    password=${password}
    ...    administrador=true
    ${response}=    PUT Request    serverest    /usuarios/${id}    json=${payload}
    [Return]    ${response}

POST /usuarios email=invalid-email@    [Arguments]    ${email}=${EMAIL}    ${password}=${PASSWORD}
    ${payload}=    Create Dictionary
    ...    nome=Fulano da Silva   
    ...    email=${email}    
    ...    password=${password}
    ...    administrador=true
    ${response}=    POST Request    serverest    /usuarios    json=${payload}
    [Return]    ${response}

POST /usuarios senha errada
    [Arguments]    ${email}=${EMAIL}    ${password}=${PASSWORD}
    ${payload}=    Create Dictionary
    ...    nome=Fulano da Silva   
    ...    email=${email}    
    ...    password=senha errada
    ...    administrador=true
    ${response}=    POST Request    serverest    /usuarios    json=${payload}
    [Return]    ${response}

