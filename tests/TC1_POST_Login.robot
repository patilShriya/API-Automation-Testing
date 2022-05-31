*** Settings ***
Library     RequestsLibrary
Library     JSONLibrary
Library     Collections
Library     OperatingSystem
Library     String

Variables            ..${/}envs/qa.py
Variables            ..${/}res/json_apis/json_apis_res_data.py
Library             ..${/}data/json_apis/json_apis_data.py


*** Test Cases ***
TC1_Login_user

    create session      mysession       ${base_url}
    ${body} =       read_post_data_login
    ${header} =     create dictionary   Content-Type=application/json
    ${response} =    post request   mysession     /login       data=${body}     headers=${header}

 #Validations
    Should be Equal       ${response.status_code}         ${post_status_code}

#Get access token
    ${access_token}=     get value from json         ${response.json()}          access_token
    ${access_value}=     get from list        ${access_token}     0
    ${access_value_bearer}=     Catenate    Bearer  ${access_value}
    set global variable    ${access_value_bearer}

    log to console     Result=${access_value_bearer}

###############################################################################################################
TC2_Get_dashboard
    create session      mysession      ${base_url}
    ${headers1}=   create dictionary    Authorization=${access_value_bearer}
    ${response1}=    get request    mysession      /dashboard   headers=${headers1}
# Validations
    Should be Equal     ${response1.status_code}          ${get_status_code}
    log to console     ${response1.content}

#################################################################################################################

TC3_Refresh
    create session      mysession1       ${base_url}
    ${response2}=    options request    mysession1   /refresh
   # Validations
    Should be Equal     ${response2.status_code}        ${get_status_code}

#################################################################################################################

TC4_Get_single_device
    create session      mysession       ${base_url}
    ${headers}=     create dictionary     Authorization=${access_value_bearer}
    ${response1}=    get request    mysession   /device/airpurifier_1648716405257      ${headers}
# Validations
    log to console     ${response1.status_code}
    log to console     ${response1.content}
    ${Result}=      convert to string     ${response1.content}
    Should contain     ${Result}            input_aqi       output_aqi
    Should be Equal     ${response1.status_code}        ${get_status_code}


#####################################################################################################
TC5_Add customer
    create session      mysession       ${base_url}
    ${body}=        read_post_data_device
    ${headers}=     create dictionary     Authorization=${access_value_bearer}
    ${response1}=    post request     mysession       /organization       data=${body}      headers=${headers}

# Validations
    log to console     ${response1.content}
#    Should be Equal     ${response1.status_code}        ${post_status_code}


##################################################################################################

TC6_Get Customer
        create session    mysession         ${baseurl}
        ${headers1}=  create dictionary       Authorization=${access_value_bearer}
        ${response1}=   get request         mysession       /organization       headers=${headers1}

# Validations
    log to console     ${response1.status_code}
    log to console     ${response1.content}
    Should be Equal     ${response1.status_code}        ${get_status_code}
    ${Result}=          convert to string        ${response1.content}
    Should contain     ${Result}            address       city       contact_email       status

