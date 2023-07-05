*** Keywords ***
SEARCH WIKIPEDIA
  [Arguments]    ${text}
  input text    css:.cdx-text-input__input    ${text}
  click button    css:.cdx-button

*** Variables ***
${wikipedia_login}    RobotTests
${wikipedia_password}    RobotFramework
