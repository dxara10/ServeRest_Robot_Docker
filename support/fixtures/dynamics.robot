*** Settings ***
Documentation     Keywords e variaveis para geração de Massa de Dados
Library           FakerLibrary




*** Keywords ***
Criar Dados Usuario Válido
    ${nome} =    FakerLibrary.Name
    ${email} =    FakerLibrary.Email
    ${payload} =    Create Dictionary    nome=${nome}    email=${email}    password=senha123    administrador=true
    Log To Console         ${payload}
    Set Global Variable    ${payload}
