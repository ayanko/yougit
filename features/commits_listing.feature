Feature: Listing repository commits
  In oder to compare commits in repository
  developer
  wants to compare certain branches

  Scenario: Listing compare from default reference
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

    Then I should see "Commit list"
    Then I should see commits:
      | message                  |
      | RP-1: Tomato initialized |      
      | RP-2: Fixed mind         |      
      | RP-3: Added IQ           |      
      | RP-4: Improved IQ        |      
      | RP-5: Monkey evolution   |



  Scenario: Listing commits with reference filter
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
      | banana  | HEAD~2      |
      | monkey  | HEAD        |
      | human   | HEAD        |

    When I go to the cuke commits page
    And I select "banana" from "reference"
    And I press "Show"

    Then I should see "Commit list"
    And I should see commits:
      | message                  |
      | RP-1: Tomato initialized |      
      | RP-2: Fixed mind         |      
      | RP-3: Added IQ           |      
    And I should NOT see commits:
      | message                  |
      | RP-4: Improved IQ        |      
      | RP-5: Monkey evolution   |



  Scenario: Listing commits with one exclude option
    Given repository with "cuke" name
    And repository has commits:
      | message     |
      | RP-1: FIX 1 |      
      | RP-2: FIX 2 |      
      | RP-3: FIX 3 |      
      | RP-4: FIX 4 |      
      | RP-5: FIX 5 |
      | RP-6: FIX 6 |
      | RP-7: FIX 7 |
      | RP-8: FIX 8 |
      | RP-9: FIX 9 |
    And repository has branches:
      | name    | start_point |
      | monkey  | HEAD~2      |
      | banana  | HEAD~5      |

    When I go to the cuke commits page
    And I select "monkey" from "reference"
    And I select "banana" from "exclude_0"
    And I press "Show"

    Then I should see "Commit list"
    And I should see commits:
      | message     |
      | RP-5: FIX 5 |
      | RP-6: FIX 6 |
      | RP-7: FIX 7 |
    And I should NOT see commits:
      | message     |
      | RP-1: FIX 1 |      
      | RP-2: FIX 2 |      
      | RP-3: FIX 3 |      
      | RP-4: FIX 4 |      
      | RP-8: FIX 8 |
      | RP-9: FIX 9 |

