Feature: View sites
  In order to hold Leeds City Council to account
  As a citizen of Leeds
  I want to see what the draft allocations for housing are

  Background:
    Given there are some allocations
    And I visit the allocations page

  @javascript @wip
  Scenario: Look at the unfiltered list
    Then I should see a list of allocations with a count
    And I should see a key for the map markers

  Scenario: Filtering by policy
    When I filter by policy "HG1"
    Then I should not see the Area (ha) column
    And I should see the construction progress columns

  Scenario: Searching for allocatins by address or plan ref
    When I search for allocations with some text
    Then I should see only those allocations that match that text
    And I should see my search text

