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


