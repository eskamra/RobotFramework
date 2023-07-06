*** Settings ***
Library    SeleniumLibrary
Library    Collections
Test Teardown    Close Browser
Resource    resource.robot

*** Variables ***
${empikbestsellers_url}    https://www.empik.com/bestsellery

*** Keywords ***
OPEN EMPIK BESTSELLER
    open browser    ${empikbestsellers_url}    Chrome    executable_path=/Users/eskam/Desktop/chromedriver.exe

CLICK ON SPECIFIC ELEMENT
    [Arguments]    ${specific_book}

    ${index}    set variable    1

    ${empikbestsellers_list}    get webelements    css:.ta-product-title
    FOR    ${element}    IN    @{empikbestsellers_list}
      exit for loop if    '${element.text}' == '${specific_book}'
      ${index}    evaluate    ${index} + 1
    END

    click element    xpath:(//*[@class='search-list-item-hover'])[${index}]/a

*** Test Cases ***
EMPIK TEST CASE
    OPEN EMPIK BESTSELLER

    @{empikbestsellers_text}    create list
    ${empikbestsellers_list}    get webelements    css:.ta-product-title
    log list    ${empikbestsellers_list}

    FOR    ${element}    IN    @{empikbestsellers_list}
      append to list    ${empikbestsellers_text}    ${element.text}
    END

    log list    ${empikbestsellers_text}
    list should contain value    ${empikbestsellers_text}    16 Widmo Brockenu

    CLICK ON SPECIFIC ELEMENT    16 Widmo Brockenu