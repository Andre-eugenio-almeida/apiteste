*** Settings ***

Library    SeleniumLibrary

*** Variables ***
${BROWSER} =   edge
${URL} =      http://signup.live.com
${EMAIL} =    almeida.ae@outlook.com
${EMAIL2} =    vugo_broquinha@outlook.com
${SENHA} =    123456
${SENHA2} =   Meggie@bibi12
${NOME} =     André

*** Keywords ***


Acessar o site 
    Open Browser     url=${URL}    browser=${BROWSER}      options=add_experimental_option("detach", True)
    Maximize Browser Window
    Sleep    3s
   
  
Quando eu clicar em avançar  
    Click Element    xpath=//button[contains(text(), 'Avançar')]
    Sleep    3s

Então deve retornar uma mensagem 
    [Arguments]    ${mensagem_retorno}
   ${mensagem}    Get Text    xpath=//div[contains(text(), '${mensagem_retorno}')]
    Close Browser 


Quando eu inserir um e-mail
    Wait Until Element Is Visible    xpath=//*[@id="usernameInput"] 
    Input Text    xpath=//*[@id="usernameInput"]    ${EMAIL} 

Quando eu inserir uma senha numérica
     
    Click Element    xpath=//*[@id="easiSwitch"]
    Input Text       xpath=//*[@id="usernameInput"]    ${EMAIL2} 
    Click Element    xpath=//button[contains(text(), 'Avançar')]
    Wait Until Element Is Visible   xpath=//*[@id="Password"]   
    Input Text       xpath=//*[@id="Password"]    ${SENHA}
    Sleep    3s
    Click Element    //*[@id="nextButton"]
    

Quando eu inserir uma senha válida  
    Click Element    xpath=//*[@id="easiSwitch"]
    Input Text       xpath=//*[@id="usernameInput"]    ${EMAIL2} 
    Click Element    xpath=//button[contains(text(), 'Avançar')]
    Wait Until Element Is Visible   xpath=//*[@id="Password"]   
    Sleep    2s
    Input Text       xpath=//*[@id="Password"]    ${SENHA2}
    Sleep    2s
    Click Element    //*[@id="nextButton"]
