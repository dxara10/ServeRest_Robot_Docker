*** Settings ***
Documentation     Arquivo de testes para endpoint login
Resource          ../Keywords/login_keyword.robot

*** Variables ***

#Suite Setup       Criar Sessao

*** Test Cases ***
Realizar login com credenciais corretas
    [Tags]    POSTlogin
    Criar Sessão
    Executar login
    #Validar status code 200
    #Armazenar token de autenticação

#Validar tempo de expiração do token
#    Extrair tempo de expiração do token
#    Validar expiração do token

#Tentar login com usuário não cadastrado
#    Executar login com usuário inexistente
#    Validar status code 401  

#Tentar login com senha incorreta
#    Executar login
#    Validar status code 401      
