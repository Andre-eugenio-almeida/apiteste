*** Settings ***

Library    SeleniumLibrary

*** Variables ***
${BROWSER}    edge
${URL}        http://signup.live.com
${EMAIL}        almeida.ae@outlook.com



*** Keywords ***


Acessar o site 
    Open Browser     url=${URL}    browser=${BROWSER}      options=add_experimental_option("detach", True)
    Maximize Browser Window
    Sleep    3s
   
  
Quando eu clicar em avançar  
    Click Element    xpath=//button[contains(text(), 'Avançar')]
    Sleep    5s

Então deve retornar uma mensagem 
    [Arguments]    ${mensagem_retorno}
   ${mensagem}    Get Text    xpath=//div[contains(text(), '${mensagem_retorno}')]
    Close Browser 


Quando eu inserir um e-mail
    Wait Until Element Is Visible    xpath=//*[@id="usernameInput"] 
    Input Text    xpath=//*[@id="usernameInput"]    ${EMAIL} 

