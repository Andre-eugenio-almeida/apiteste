*** Settings ***

Documentation  teste site Amazon
Resource    ../resources/front_hotmail.resource


*** Test Cases ***
QUANDO EU CLICAR EM AVANÇAR SEM INSERIR E-MAIL
    Acessar o site 
    Quando eu clicar em avançar 
    Então deve retornar uma mensagem      É necessário um endereço de email



QUANDO EU INSERIR UM E-MAIL JÁ EXISTENTE 
    Acessar o site 
    Quando eu inserir um e-mail
    Quando eu clicar em avançar  
    Então deve retornar uma mensagem      já é uma conta Microsoft

QUANDO EU INSERIR UMA SENHA USANDO SOMENTE NÚMEROS
    Acessar o site 
    Quando eu inserir um e-mail
    Quando eu inserir uma senha numérica 
    Então deve retornar uma mensagem     As senhas devem ter, no mínimo, 8 carateres e conter, pelo menos, dois dos seguintes elementos: letras maiúsculas e minúsculas, números e símbolos

QUANDO EU INSERIR UMA SENHA VALIDA
    Acessar o site 
    Quando eu inserir um e-mail
    Quando eu inserir uma senha válida  
    Então deve retornar uma mensagem   Precisamos de um pouco mais de informações para configurar sua conta.
 
    