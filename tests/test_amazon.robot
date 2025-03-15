
*** Settings ***

Documentation  teste site Amazon
Resource    ../resources/amazon.resource


*** Test Cases ***
Caso de teste 01
    Acessar o site da amazon
    Pesquisar por Celulares
    Validar resultado


