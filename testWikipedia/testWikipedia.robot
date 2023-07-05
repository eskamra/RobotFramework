*** Settings ***
Library  SeleniumLibrary
Test Setup   OPEN WIKIPEDIA
Test Teardown    Close Browser
Resource    resource.robot

*** Variables ***
${project_path}    /Users/eskam/PycharmProjects/robotFramework/RobotFrameworkTest/testWikipedia
${error_message}    Podany login lub hasło są nieprawidłowe. Spróbuj jeszcze raz.

*** Keywords ***

OPEN WIKIPEDIA
  open browser  https://pl.wikipedia.org  Chrome  executable_path=/Users/eskam/Desktop/chromedriver.exe

Log In Wikipedia
  [Documentation]    Check the sign-in to wikipedia - correct login and password
  [Arguments]    ${login}    ${password}
  click element    id:pt-login-2
  ${my_value}=    get text    id:wpName1
  should be empty    ${my_value}
  checkbox should not be selected    id:wpRemember
  input text    id:wpName1  ${login}
  input password    id:wpPassword1  ${password}
  select checkbox    id:wpRemember
  click button    id:wpLoginAttempt

Incorrect Log In Wikipedia
  [Documentation]    Check the error message - incorrect password
  [Arguments]    ${login}
  click element    id:pt-login-2
  ${my_value}=    get text    id:wpName1
  should be empty    ${my_value}
  checkbox should not be selected    id:wpRemember
  input text    id:wpName1  ${login}
  input password    id:wpPassword1  123123
  select checkbox    id:wpRemember
  click button    id:wpLoginAttempt
  wait until element is visible    css:.mw-message-box    timeout=7
  ${my_error_message} =    get text    css:.mw-message-box
  should be equal as strings    ${my_error_message}    ${error_message}


*** Test Cases ***
FirstTest
  [Documentation]  Test - correct sign-in to wikipedia
  Log In Wikipedia    ${wikipedia_login}    ${wikipedia_password}
  SEARCH WIKIPEDIA    Adam Małysz
  capture page screenshot    ${project_path}/screenshot-correct.png
  sleep    2

SecondTest
  [Documentation]    Test - incorrect sign-in to wikipedia (incorrect password)

  Incorrect Log In Wikipedia    ${wikipedia_login}
  capture page screenshot    ${project_path}/screenshot-incorrect.png
  sleep    2