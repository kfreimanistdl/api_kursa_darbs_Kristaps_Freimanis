@project
Feature:  Kursa darbs

  Scenario: 2 un 3 uzdevums Kursa darba
    Given I am logged in apimation.com as a regular user
    And I find existing project
    And I select existing project
    And I add PREPROD environment
    And I add 3 global variables to environment
    And I add Login collection
    And I add successfull Login test case
    And I add Active collection
    And I add successfull Active project test case
    And I create new test case with previously defined steps