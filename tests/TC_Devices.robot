*** Settings ***
Library      RequestsLibrary
Library      JSONLibrary
Library      Collections
Library      OperatingSystem
Library      String

Variables            ../envs/qa.py

***Variables***
#${Global}       ${access_value_bearer}


*** Test Cases ***
TC1_Get_Single_Device
    create session      mysession       ${base_url}
    ${headers}=     create dictionary     Authorization=${access_value_bearer}
    ${response1}=    Get On Session    mysession   /api/v1/device/airpurifier_1648716405257      ${headers}


    log to console     ${response1.status_code}
    log to console     Result=${response1.content}


##############################
TC5_Post_Devices

    create session      mysession       ${base_url}
    ${body}=        create dictionary         query_string:"*"
    ${headers}=     create dictionary     Authorization=${access_value_bearer}
    ${response1}=    post request    mysession          /api/v1/device       data=${body}      ${headers}

# Validations
  #  log to console     ${response1.status_code}
    log to console     ${response1.content}
    #${Result}=      convert to string     ${response1.content}
    #Should be Equal     ${response1.status_code}        ${post_status_code}


