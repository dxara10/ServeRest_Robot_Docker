*** Settings ***
Documentation     Arquivo de testes para endpoint login
Resource          ../Keywords/login_keyword.robot

*** Variables ***
${USUARIO_INEXISTENTE}    naoexiste@example.com
${SENHA_INCORRETA}        senhaerrada123

*** Settings ***
Suite Setup       Setup Test Suite
Suite Teardown    Teardown Test Suite

*** Test Cases ***
Realizar login com credenciais corretas
    [Tags]    POSTlogin
    Executar login
    Validar Status Code "200"
    Validar Ter Logado

Tentar login com usuário não cadastrado
    [Tags]    POSTlogin_erro
    Executar login    email=${USUARIO_INEXISTENTE}
    Validar Status Code "401"
    Validar Se Mensagem Contem "Email e/ou senha inválidos"

Tentar login com senha incorreta
    [Tags]    POSTlogin_erro
    Executar login    password=${SENHA_INCORRETA}
    Validar Status Code "401"
    Validar Se Mensagem Contem "Email e/ou senha inválidos"

*** Keywords ***
Setup Test Suite
    Criar Sessão

Teardown Test Suite
    Log    Finalizando suite de testes de login
