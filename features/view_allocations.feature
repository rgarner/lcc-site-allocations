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

#
#  Scenario: Searching for sites by address or reason
#    When I search for sites with some text
#    Then I should see only those sites that match that address text
#    And I should see my search text
#
#  Scenario: Filtering by Issues and Options Red/Amber/Green
#    When I visit the home page
#    And I filter by I&O/RAG "G"
#    Then I should see what I&O/RAG I filtered by
#    And I should see only sites that match the I&O/RAG I selected
#    And I should see the "With scores" filter
#    When I filter by I&O/RAG "LG"
#    Then I should not see the "With scores" filter

