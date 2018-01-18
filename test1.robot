*** Settings ***

Library         Selenium2Library  timeout=30  implicit_wait=0
Test Setup      Test Setup
Test Teardown   Close Browser


*** Test Cases ***

Scenario: Passing Test
  Open Browser  https://kitconcept.com  chrome
  Go to  https://kitconcept.com/
  Wait until page contains  kitconcept
  Page should contain  driven by quality
