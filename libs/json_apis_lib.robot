*** Settings ***
Documentation    A test suite for JSON APIs.
Resource        ..${/}libs/json_apis_lib.robot

*** Test Cases ***

JSON_APIs_01
    [Documentation]    Make a POST Request on /login endpoint.
    [tags]    full    smoke
    Make a POST Request

JSON_APIs_02
    [Documentation]    Make a GET Request on /dashboard endpoint.
    [tags]    full
    Make a GET Request