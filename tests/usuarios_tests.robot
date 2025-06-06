*** Settings ***
Documentation     Arquivo de testes para endpoint de usuários
Resource          ../Keywords/usuarios_keyword.robot
Resource          ../support/common/common.robot
Resource          ../support/fixtures/dynamics.robot
Library           FakerLibrary

*** Variables ***
${USUARIO_ID}     ${EMPTY}    # Variável para armazenar ID do usuário criado dinamicamente

*** Settings ***
Suite Setup       Setup Test Suite
Suite Teardown    Teardown Test Suite

*** Test Cases ***
Criar usuário válido com dados estáticos
    ${usuario_valido}=    Set Variable    ${json_usuario["usuario_valido"]}
    POST /usuarios    email=${usuario_valido["email"]}    password=${usuario_valido["password"]}
    Validar Status Code "201"
    Armazenar ID Usuario    # Armazena o ID para uso em outros testes
    
Criar usuário válido dinâmico
    Criar Usuario Dinamico
    Validar Status Code "201"
    Armazenar ID Usuario    # Armazena o ID para uso em outros testes

Atualizar usuário criado
    ${email_aleatorio}=    FakerLibrary.Email
    PUT /usuario    ${USUARIO_ID}    email=${email_aleatorio}
    Validar Status Code "200"
    common.Validar Se Mensagem Contem "Registro alterado com sucesso"

Listar usuários e validar atualização
    GET /usuarios 
    Validar Status Code "200"

Listar usuario específico por ID
    GET /usuarios/ID    ${USUARIO_ID}
    Validar Status Code "200"

Tentar criar usuário com e-mail inválido
    ${usuario_sem_email}=    Set Variable    ${json_usuario["user_sememail"]}
    POST /usuarios    email=${usuario_sem_email["email"]}    password=${usuario_sem_email["password"]}
    Validar Status Code "400"
    ${error_field}=    Set Variable    ${response.json()["email"]}
    Should Contain    ${error_field}    email

Tentar criar usuário com senha inválida
    ${usuario_sem_senha}=    Set Variable    ${json_usuario["user_semsenha"]}
    POST /usuarios    email=${usuario_sem_senha["email"]}    password=${usuario_sem_senha["password"]}
    Validar Status Code "400"
    ${error_field}=    Set Variable    ${response.json()["password"]}
    Should Contain    ${error_field}    password

Deletar usuário
    DELETE /usuario    ${USUARIO_ID}
    Validar Status Code "200"
    common.Validar Se Mensagem Contem "Registro excluído com sucesso"

*** Keywords ***
Setup Test Suite
    Create Session    serverest    ${BASE_URL}    verify=${FALSE}
    Set Global Variable    ${BASE_URL}
    ${json_usuario}=    Importar JSON Estatico    json_usuario.json
    Set Global Variable    ${json_usuario}

Teardown Test Suite
    Delete All Sessions
    Log    Finalizando suite de testes de usuários

Armazenar ID Usuario
    ${USUARIO_ID}=    Set Variable    ${response.json()["_id"]}
    Set Global Variable    ${USUARIO_ID}
    Log To Console    ID do Usuário Criado: ${USUARIO_ID}