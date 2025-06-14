*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections

*** Variables ***
${url_reqres}    https://reqres.in
${resposta.text}
${resposta.status_code}

*** Keywords ***
DADO QUE CONSULTE O ENDPOINT /api/users
    Create Session    reqres    ${url_reqres}

QUANDO EU PASSAR O PARAMETRO PAGE=1 
    ${headers}    Create Dictionary    content-type=application/json
    ${resposta}    GET On Session    reqres     /api/users  params=page=1        expected_status=any
    Log    ${resposta.text}
    Set Suite Variable    ${resposta}




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



###########################################################################################################

DADO QUE CONSULTE UM SINGLE USER NO ENDPOINT /api/users
    Create Session    reqres    ${url_reqres}

QUANDO EU PASSAR O PARAMETRO ID=2
    ${headers}    Create Dictionary    content-type=application/json
    ${resposta}    GET On Session    reqres    /api/users/2          expected_status=any
    Log    ${resposta.text}
    Set Suite Variable    ${resposta}


QUANDO EU NÃO PASSAR O PARAMETRO ID
    ${headers}    Create Dictionary    content-type=application/json
    ${resposta}    GET On Session    reqres    /api/users      expected_status=any
    Log    ${resposta.text}
    Set Suite Variable    ${resposta}

ENTÃO A API DEVE RETORNAR  
    [Arguments]     ${status_code_desejado}
    Should Be Equal As Strings    ${resposta.status_code}    ${status_code_desejado}



QUANDO EU PASSAR O PARAMETRO COM ID INVALIDO
    ${headers}    Create Dictionary    content-type=application/json
    ${resposta}    GET On Session    reqres    /api/users/23      expected_status=any
    Log    ${resposta.text}
    Set Suite Variable    ${resposta}



#################################################################################################################


DADO QUE EU CONSULTE O ENDPOINT DESCONHECIDO
    Create Session    reqres    ${url_reqres}


QUANDO EU PASSAR SEM PARAMETRO 
     ${headers}    Create Dictionary    content-type=application/json
    ${resposta}    GET On Session    reqres    /api/unknown      expected_status=any
    Log    ${resposta.text}
    Set Suite Variable    ${resposta}



QUANDO EU PASSAR UM PARAMETRO VALIDO
     ${headers}    Create Dictionary    content-type=application/json
    ${resposta}    GET On Session    reqres    /api/unknown/2       expected_status=any
    Log    ${resposta.text}
    Set Suite Variable    ${resposta}


QUANDO EU PASSAR UM PARAMETRO INVALIDO 
     ${headers}    Create Dictionary    content-type=application/json
    ${resposta}    GET On Session    reqres    /api/unknown/23        expected_status=any
    Log    ${resposta.text}
    Set Suite Variable    ${resposta}


ENTÃO VALIDO O CONTEUDO DO RESPONSE BODY DESCONHECIDO
    ${Json_response}    Convert String To JSON    ${resposta.text}
    ${data_list}    Get From Dictionary    ${Json_response}    data 
    
        Dictionary Should Contain Key    ${data_list}    id
        Dictionary Should Contain Key    ${data_list}    name
        Dictionary Should Contain Key    ${data_list}    year
        Dictionary Should Contain Key    ${data_list}    color
        Dictionary Should Contain Key    ${data_list}    pantone_value


ENTÃO VALIDO O CONTEUDO DO RESPONSE BODY DESCONHECIDO LISTA
    ${Json_response}    Convert String To JSON    ${resposta.text}
    ${data_list}    Get From Dictionary    ${Json_response}    data 
    FOR    ${item}    IN    @{data_list}
        Dictionary Should Contain Key    ${item}    id
        Dictionary Should Contain Key    ${item}    name
        Dictionary Should Contain Key    ${item}    year
        Dictionary Should Contain Key    ${item}    color
        Dictionary Should Contain Key    ${item}    pantone_value
                
    END
    
                
   ################################################################################################################

DADO QUE EU TENHA NOME E JOB DO USUARIO 
    ${body}    Create Dictionary    name=Morpheus    job=Leader
    ${resposta}    POST On Session    reqres    /api/users   json=${body}    expected_status=any
    Log    ${resposta.text}
    Set Suite Variable    ${resposta}    

QUANDO EU EFETUAR A REQUISIÇÃO 
     ${body}    Create Dictionary    name=Morpheus    job=Leader
    ${resposta}    POST On Session    reqres    /api/users   json=${body}    expected_status=any
    Log    ${resposta.text}
    Set Suite Variable    ${resposta}   

QUANDO EU EFETUAR A REQUISIÇÃO SEM O JOB
     ${body}    Create Dictionary    name=Morpheus    
    ${resposta}    POST On Session    reqres    /api/users   json=${body}    expected_status=any
    Log    ${resposta.text}
    Set Suite Variable    ${resposta}   

QUANDO EU EFETUAR A REQUISIÇÃO SEM O NOME DO USUARIO
         ${body}    Create Dictionary        job=Leader
    ${resposta}    POST On Session    reqres    /api/users   json=${body}    expected_status=any
    Log    ${resposta.text}
    Set Suite Variable    ${resposta}    


QUANDO EU EFETUAR A REQUISIÇÃO COM NOME DIFERENTE
        ${body}    Create Dictionary    name=André    job=Leader
    ${resposta}    POST On Session    reqres    /api/users   json=${body}   
    Log    ${resposta.text} 
    Set Suite Variable    ${resposta}



##################################################################################



QUANDO QUE EU ATUALIZAR UM USUARIO 
       ${body}   Create Dictionary    name=morpheus    job=zion resident
    ${resposta}   PUT On Session   reqres    /api/users/2    json=${body} 
    Log    ${resposta.text}  
    Set Suite Variable    ${resposta}

QUANDO EU ATUALIZAR O MOME DO USUARIO PARA NUMEROS
        ${body}    Create Dictionary    name=123    job=zion resident
    ${resposta}    PUT On Session   reqres    /api/users/2    json=${body} 
    Log    ${resposta.text}  
    Set Suite Variable    ${resposta}


QUANDO EU ATUALIZAR USUARIO SEM O JOB
     ${body}   Create Dictionary    name=123    
    ${resposta}   PUT On Session    reqres    /api/users/2    json=${body}   
    Log    ${resposta.text}
    Set Suite Variable    ${resposta}

QUANDO EU ATUALIZAR USUARIO SEM NOME 
    ${body}   Create Dictionary          job=zion resident
    ${resposta}   PUT On Session    reqres    /api/users/2    json=${body}   
    Log    ${resposta.text}
    Set Suite Variable    ${resposta}
 

###################################################################################

DADO QUE EU CONSULTE O ENDPOINT 
    Create Session    reqres    ${url_reqres}

QUANDO EU DELETAR UM USUARIO
      ${headers}    Create Dictionary    
    ${resposta}    DELETE On Session    reqres     /api/users/2       expected_status=any
    Log    ${resposta.text}
    Set Suite Variable    ${resposta}