*** Settings ***
Documentation     Teste para verificar comportamento quando o token expira
Resource          ../../Keywords/login_keyword.robot
Resource          ../../Keywords/produtos_keyword.robot

*** Test Cases ***
Tentar criar produto com token expirado
    [Documentation]    Este teste simula o cenário onde o token expira e tenta criar um produto
    [Tags]    bug    token_expiracao
    
    # Primeiro login para obter token
    Criar Sessão
    Fazer login e Armazenar Token
    
    # Simular expiração do token modificando-o
    ${token_auth}=    Set Variable    ${token_auth}INVALIDO
    Set Global Variable    ${token_auth}
    
    # Tentar criar produto com token inválido
    POST /produtos
    Validar Status Code "401"
    Validar Se Mensagem Contem "Token inválido"