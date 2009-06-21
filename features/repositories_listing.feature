Feature: Listing Git repositories
  In oder to review code
  developer
  wants watch at repositories list

  Scenario: Developer access repo listing
    Given repositories:
      | name        |
      | tomato      |
      | capistrator |

    When I go to the repositories

    Then I should see "Repositories"
    And I should see links:
      | name        |
      | tomato      | 
      | capistrator |

