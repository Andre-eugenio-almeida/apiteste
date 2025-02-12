
*** Settings ***
Library    RequestsLibrary

*** Variables ***
${url_marvel}    http://gateway.marvel.com/v1/public

*** Keywords ***
DADO QUE EU CONSULTE O ENDPOINT 
    Create Session    marvel    ${url_marvel}
    
QUANDO EU PASSAR OS PARAMETROS 
    ${headers}    Create Dictionary    content-type=application/json
    ${resposta}    GET On Session   marvel   /characters    params=apikey=54404ddf7bcb1f389cf00f7c78a83c1b&hash=b64a96ba9ce4c7f665a29d3e3cbd7b45&ts=1
    Log    ${resposta.text}
    Set Test Variable    ${resposta} 

ENTÃO A API DEVE RETORNAR 
    [Arguments]    ${statuscode_desejada}     
    Should Be Equal As Strings    ${resposta.status_code}   ${statuscode_desejada}
      

QUANDO EU PASSAR OS PARAMETROS INVALIDOS
    Create Session    marvel    ${url_marvel}
    ${headers}    Create Dictionary    content-type=application/json
    ${resposta}    GET On Session   marvel   /characters    params=apikey=54404ddf7bcb1f389cf00f7c78a83c1&hash=b64a96ba9ce4c7f665a29d3e3cbd7b45&ts=1    expected_status=any
    Log    ${resposta.text}
    Set Test Variable    ${resposta}

QUANDO EU PASSAR PARAMETROS SEM USER KEY
    Create Session    marvel    ${url_marvel}
    ${headers}    Create Dictionary    content-type=application/json
    ${resposta}    GET On Session   marvel   /characters    params=hash=b64a96ba9ce4c7f665a29d3e3cbd7b45&ts=1    expected_status=any
    Log    ${resposta.text}
    Set Test Variable    ${resposta}


QUANDO EU PASSAR PARAMETROS COM HASH VALIDO
     ${headers}    Create Dictionary    content-type=application/json
    ${resposta}    GET On Session   marvel   /characters    params=apikey=54404ddf7bcb1f389cf00f7c78a83c1b&hash=b64a96ba9ce4c7f665a29d3e3cbd7b45&ts=1    expected_status=any
    Log    ${resposta.text}
    Set Test Variable    ${resposta} 

    
QUANDO EU PASSAR PARAMETROS COM HASH INVALIDO
       ${headers}    Create Dictionary    content-type=application/json
    ${resposta}    GET On Session   marvel   /characters    params=apikey=54404ddf7bcb1f389cf00f7c78a83c1b&hash=b64a96ba9ce4c7f665a29d3e3cbd7b4&ts=1    expected_status=any
    Log    ${resposta.text}
    Set Test Variable    ${resposta}  

QUANDO EU PASSAR PARAMETROS SEM O HASH 
     ${headers}    Create Dictionary    content-type=application/json
    ${resposta}    GET On Session   marvel   /characters    params=apikey=54404ddf7bcb1f389cf00f7c78a83c1b&ts=1    expected_status=any
    Log    ${resposta.text}
    Set Test Variable    ${resposta} 

           