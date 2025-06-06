*** Settings ***
Documentation     Keywords e Variables para ações login_keyword_keyword
Resource          ../support/base.robot

*** Keywords ***
Criar Usuario Dinamico
    ${nome}=    FakerLibrary.Name
    ${email}=    FakerLibrary.Email
    ${password}=    FakerLibrary.Password    length=8
    &{payload}=    Create Dictionary
    ...    nome=${nome}
    ...    email=${email}
    ...    password=${password}
    ...    administrador=true
    Log To Console    Usuário criado: ${payload}
    ${response}=    POST On Session    serverest    /usuarios    json=${payload}    expected_status=any
    Log To Console    Resposta da criação: ${response.content}
    Set Global Variable    ${response}
    Set Global Variable    ${DYNAMIC_EMAIL}    ${email}
    Set Global Variable    ${DYNAMIC_PASSWORD}    ${password}
    Run Keyword If    ${response.status_code} == 201    Set Global Variable    ${USUARIO_ID}    ${response.json()["_id"]}
    [Return]    ${response}

Executar login
    [Arguments]    ${email}=${EMAIL}    ${password}=${PASSWORD}
    &{payload}=    Create Dictionary    
    ...    email=${email}    
    ...    password=${password}
    ${response}=    POST On Session    serverest    /login    json=${payload}    expected_status=any
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}
    Run Keyword If    ${response.status_code} == 200    Capturar token    ${response}
    [Return]    ${response}

Fazer login com usuario Dinamico e Armazenar Token
    &{payload}=    Create Dictionary
    ...    email=${DYNAMIC_EMAIL}
    ...    password=${DYNAMIC_PASSWORD}
    Log To Console    Tentando login com: ${payload}
    ${response}=    POST On Session    serverest    /login    json=${payload}    expected_status=any
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}
    Run Keyword If    ${response.status_code} == 200    Capturar token    ${response}
    [Return]    ${response}
    
Configurar Usuario e Login
    Criar Usuario Dinamico
    Fazer login com usuario Dinamico e Armazenar Token

Validar Ter Logado
    Should Be Equal    ${response.json()["message"]}    Login realizado com sucesso
    Should Not Be Empty    ${response.json()["authorization"]}

Capturar token
    [Arguments]    ${resp}
    ${token}=    Set Variable    ${resp.json()['authorization']}
    Log To Console    Token: ${token}
    Set Global Variable    ${token_auth}    ${token}
    Configurar Autenticação    ${token}
    [Return]    ${token}

Verificar Token Valido
    Run Keyword If    "${token_auth}" == "${EMPTY}"    Executar login
    # Adicionar lógica para verificar expiração do token se necessário

Fazer login e Armazenar Token
    Executar login
    Validar Ter Logado
    ${token_auth}=    Set Variable    ${response.json()["authorization"]}
    Log To Console    Token Salvo: ${token_auth}
    Set Global Variable    ${token_auth}