*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections

*** Variables ***
${url_reqres}    https://reqres.in


*** Keywords ***
DADO QUE CONSULTE O ENDPOINT /api/users
    Create Session    reqres    ${url_reqres}

QUANDO EU PASSAR O PARAMETRO PAGE=1 
    ${headers}    Create Dictionary    content-type=application/json
    ${resposta}    GET On Session    reqres     /api/users  params=page=1        expected_status=any
    Log    ${resposta.text}
    Set Suite Variable    ${resposta}

ENTÃO A API DEVE RETORNAR 200 SUCESSO 
    [Arguments]     ${status_code_desejado}
    Should Be Equal As Strings    ${resposta.status_code}    ${status_code_desejado}
    
ENTÃO VALIDO O CONTEUDO DO RESPONSE BODY
    ${Json_response}    Convert String To JSON    ${resposta.text}
    ${data_list}    Get From Dictionary    ${Json_response}    data 
    FOR    ${item}    IN    @{data_list}
        Dictionary Should Contain Key    ${item}    id
        Dictionary Should Contain Key    ${item}    email
        Dictionary Should Contain Key    ${item}    first_name
        Dictionary Should Contain Key    ${item}    last_name
        Dictionary Should Contain Key    ${item}    avatar
                
    END
        
QUANDO EU NÃO PASSAR O PARAMETRO PAGE
    ${headers}    Create Dictionary    content-type=application/json
    ${resposta}    GET On Session    reqres     /api/users      expected_status=any
    Log    ${resposta.text}
    Set Suite Variable    ${resposta}


QUANDO EU NÃO PASSAR O PARAMETRO PAGE=3
     ${headers}    Create Dictionary    content-type=application/json
    ${resposta}    GET On Session    reqres     /api/users  params=page=3       expected_status=any
    Log    ${resposta.text}
    Set Suite Variable    ${resposta}
