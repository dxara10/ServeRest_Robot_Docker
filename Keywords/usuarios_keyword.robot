*** Settings ***
Documentation     Keywords e Variables para ações usuarios_keyword_keyword
Resource          ../support/base.robot
Library           RequestsLibrary

*** Keywords ***
POST /usuarios
    [Arguments]    ${email}=${EMAIL}    ${password}=${PASSWORD}
    ${payload}=    Create Dictionary
    ...    nome=Fulano da Silva   
    ...    email=${email}    
    ...    password=${password}
    ...    administrador=true
    ${response}=    POST On Session    serverest    /usuarios    json=${payload}    expected_status=any
    Set Global Variable    ${response}
    [Return]    ${response}

Criar Usuario Dinamico
    ${payload}=    Criar Dados Usuario Aleatorio Válido
    ${response}=    POST On Session    serverest    /usuarios    json=${payload}    expected_status=any
    Set Global Variable    ${response}
    Log To Console    Resposta da criação: ${response.content}
    [Return]    ${response}
    
GET /usuarios
    ${response}=    GET On Session    serverest    /usuarios
    Set Global Variable    ${response}
    [Return]    ${response}

GET /usuarios/ID
    [Arguments]    ${id}
    ${response}=    GET On Session    serverest    /usuarios/${id}
    Set Global Variable    ${response}
    [Return]    ${response}

DELETE /usuario
    [Arguments]    ${id}
    ${response}=    DELETE On Session    serverest    /usuarios/${id}
    Set Global Variable    ${response}
    [Return]    ${response}

PUT /usuario
    [Arguments]    ${id}    ${email}=${EMAIL}    ${password}=${PASSWORD}
    ${payload}=    Create Dictionary
    ...    nome=Fulano da Silva Atualizado
    ...    email=${email}
    ...    password=${password}
    ...    administrador=true
    ${response}=    PUT On Session    serverest    /usuarios/${id}    json=${payload}    expected_status=any
    Set Global Variable    ${response}
    [Return]    ${response}

POST /usuarios email=invalid-email@
    [Arguments]    ${email}=invalid-email@    ${password}=${PASSWORD}
    ${payload}=    Create Dictionary
    ...    nome=Fulano da Silva   
    ...    email=${email}    
    ...    password=${password}
    ...    administrador=true
    ${response}=    POST On Session    serverest    /usuarios    json=${payload}    expected_status=any
    Set Global Variable    ${response}
    [Return]    ${response}

POST /usuarios senha errada
    [Arguments]    ${email}=${EMAIL}    ${password}=s
    ${payload}=    Create Dictionary
    ...    nome=Fulano da Silva   
    ...    email=${email}    
    ...    password=${password}
    ...    administrador=true
    ${response}=    POST On Session    serverest    /usuarios    json=${payload}    expected_status=any
    Set Global Variable    ${response}
    [Return]    ${response}

Validar Quantidade "${quantidade}"
    Should Be Equal    ${response.json()['quantidade']}    ${quantidade}

# Removed duplicate keyword - using common.Validar Se Mensagem Contem instead
