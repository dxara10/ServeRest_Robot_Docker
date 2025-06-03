*** Settings ***
Documentation     Keywords e Variaveis para ações Gerais
Library           OperatingSystem


*** Keywords ***
Validar Status Code "${statuscode}"
    Should Be True    ${response.status_code} == ${statuscode}


Pegar Dados Usuario Estatico Válido
    ${json}        Importar JSON Estatico    json_usuario_ex.json
    ${payload}     Set Variable    ${json_usuario_ex.json}
    Set Global Variable    ${payload}


