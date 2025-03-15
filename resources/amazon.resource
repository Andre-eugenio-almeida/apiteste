
*** Settings ***

Library    SeleniumLibrary

*** Variables ***
${BROWSER}    edge
${URL}        http://www.amazon.com.br 

*** Keywords ***
Acessar o site da amazon
    Open Browser     url=${URL}    browser=${BROWSER}   options=add_experimental_option("detach", True)
    

Pesquisar por Celulares
    Input Text        locator=id:twotabsearchtextbox    text=Celular
    Click Element     locator=id:nav-search-submit-button

Validar resultado
    Wait Until Page Contains    text=Resultados