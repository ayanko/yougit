Feature: Listing repository revisions
  In oder to compare commits in repository
  developer
  wants to compare certain branches

  Scenario: Listing revisions from default reference
    Given repository with "cuke" name
    And repository has commits:
      | message                  |
      | RP-1: Tomato initialized |      
      | RP-2: Fixed mind         |      
      | RP-3: Added IQ           |      
      | RP-4: Improved IQ        |      
      | RP-5: Monkey evolution   |
    And repository has branches:
      | name    | start_point |
      | tomato  | HEAD        |
      | banana  | HEAD        |
      | monkey  | HEAD        |
      | human   | HEAD        |

    When I go to the cuke commits page

    Then I should see list:
      | name |
      | RP-1: Tomato initialized |      
      | RP-2: Fixed mind         |      
      | RP-3: Added IQ           |      
      | RP-4: Improved IQ        |      
      | RP-5: Monkey evolution   |


