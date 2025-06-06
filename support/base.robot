*** Settings ***
Documentation     Arquivo base para requisições HTTP e configurações gerais
Library           RequestsLibrary
Library           Collections
Library           OperatingSystem
Resource          ./common/common.robot
Resource          ./fixtures/dynamics.robot
Resource          ./variaveis/serverest_variaveis.robot

*** Keywords ***
Criar Sessão
    Create Session    serverest    ${BASE_URL}
    Set Global Variable    ${BASE_URL}

Configurar Autenticação
    [Arguments]    ${auth_token}=${token_auth}
    &{header}=    Create Dictionary    authorization=${auth_token}
    Set Global Variable    ${HEADERS}    ${header}
    [Return]    ${header}

Finalizar Sessão
    Delete All Sessions

Setup Test Suite
    Criar Sessão

Teardown Test Suite
    Finalizar Sessão