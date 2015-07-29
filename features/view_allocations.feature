Feature: View sites
  In order to hold Leeds City Council to account
  As a citizen of Leeds
  I want to see what the draft allocations for housing are

  Background:
    Given there are some allocations
    And I visit the allocations page

  Scenario: Look at the unfiltered list
    Then I should see a list of allocations with a count
    And I should see a key for the map markers

  Scenario: Filtering by policy HG1 (identified)
    When I filter by policy "HG1"
    Then I should not see the Area (ha) column
    And I should see the construction progress columns
    But I should not see the green/brown filters

  Scenario: Filtering by policy HG2
    When I filter by policy "HG2"
    Then I should see the Area (ha) column
    And I should see the green/brown filters
    But I should not see the construction progress columns
    When I filter by greenfield status "brownfield"
    Then I should see only brownfield allocations

  Scenario: Searching for allocatins by address or plan ref
    When I search for allocations with some text
    Then I should see only those allocations that match that text
    And I should see my search text

