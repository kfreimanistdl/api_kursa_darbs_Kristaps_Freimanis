@project
Feature:  2. uzdevums

  Scenario: Select existing project and add environment with 3 global variables
    Given I am logged in apimation.com as a regular user
    And I find existing project
    And I select existing project
    And I add PREPROD environment
    And I add 3 global variables to environment
    And I add Login collection
    And I add successfull Login test case
    And I add Active collection
    And I add successfull Active project test case