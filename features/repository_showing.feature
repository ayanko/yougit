Feature: Showing repository
  In oder to view code
  developer
  wants show certain repository

  Scenario: Developer access certain repo
    Given repository with "cuke" name
    And repository has branches:
      | name    |
      | tomato  |
      | banana  |

    When I go to the repository cuke

    Then I should see "Welcome to Cuke repository"
    And I should see "Branches"
    And I should see list:
      | name    |
      | master  |
      | tomato  |
      | banana  |


