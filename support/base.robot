*** Settings ***
Documentation     Arquivo simples para requisições http
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