*** Settings ***
Documentation     Arquivo de testes para endpoint de usuários
Resource          ../Keywords/usuarios_keyword.robot

*** Variables ***


#Suite Setup       Criar Sessão

*** Test Cases ***
Criar usuário válido
    Criar Sessão
    POST /usuarios
    #Validar status code "201"

Atualizar usuário criado 
    Criar Sessão
    PUT /usuario    0uxuPY0cbmQhpEz1
    Validar Status Code "200"

Listar usuários e validar atualização
    Criar Sessão
    GET /usuarios 
    #Validar presença de usuário

Deletar usuário
    Criar Sessão
    DELETE /usuario    0uxuPY0cbmQhpEz1
    #Validar status code "200"

Tentar criar usuário com e-mail inválido
    Criar Sessão
    POST /usuarios email=invalid-email@    password=${PASSWORD}
#    Validar status code 400
#    Validar mensagem de erro apropriada

Tentar criar usuário com senha inválida
    Criar Sessão
    POST /usuarios senha errada
#    Validar status code 400

Listar usuarios por ID
    Criar Sessão
    GET /usuarios/ID    0uxuPY0cbmQhpEz1
    #Validar status code 200
    #Validar presença de usuário