*** Settings ***
Resource    ../resources/api_reqres.resource

Library    RequestsLibrary


*** Test Cases ***
CONSULTAR USUARIOS COM SUCESSO
	DADO QUE CONSULTE O ENDPOINT /api/users 
	QUANDO EU PASSAR O PARAMETRO PAGE=1 
	ENTÃO A API DEVE RETORNAR 200 SUCESSO    200
	ENTÃO VALIDO O CONTEUDO DO RESPONSE BODY