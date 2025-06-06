*** Settings ***
Documentation     Keywords e Variaveis para ações Gerais
Library           OperatingSystem
Library           Collections
Library           json

*** Keywords ***
Validar Status Code "${statuscode}"
    Should Be True    ${response.status_code} == ${statuscode}

Validar Se Mensagem Contem "${palavra}"
    Should Contain    ${response.json()["message"]}    ${palavra}

Importar JSON Estatico
    [Arguments]    ${nome_arquivo}
    ${arquivo}     Get File    ${EXECDIR}/support/fixtures/static/${nome_arquivo}
    ${data}        Evaluate    json.loads('''${arquivo}''')    json
    [Return]       ${data}

Verificar Resposta Contem Campo
    [Arguments]    ${campo}
    Dictionary Should Contain Key    ${response.json()}    ${campo}
    
Verificar Resposta Nao Contem Campo
    [Arguments]    ${campo}
    Dictionary Should Not Contain Key    ${response.json()}    ${campo}
