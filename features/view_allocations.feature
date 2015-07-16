Feature: View sites
  In order to hold Leeds City Council to account
  As a citizen of Leeds
  I want to see what the draft allocations for housing are

  Background:
    Given there are some allocations

  @javascript @wip
  Scenario: Look at the unfiltered list
    When I visit the allocations page
    Then I should see a list of allocations with a count
    And I should see a map showing boundaries for sites that have them and markers for those that don't
    And I should see a key for the map markers
    When I click on an allocation's row in the list
    Then it should zoom to a feature on the map
    When I toggle the filter panel
    Then the map should expand
    And I should not see any filter controls

#  Scenario: Filtering by sites without score
#    When I visit the home page
#    Then I should see the scores column
#    When I show only sites without scores
#    Then I should not see the scores column
#    And I should not see a key for the map markers
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

