Feature: View sites
  In order to hold Leeds City Council to account
  As a citizen of Leeds
  I want to see what sites are likely to be allocated for housing

  Background:
    Given there are some sites

  @javascript
  Scenario: Look at the unfiltered list
    When I visit the home page
    Then I should see a list of sites with a count
    And I should see colour-coded scores for each site
    And I should see a map showing boundaries for sites that have them and markers for those that don't
    And I should see a key for the map markers
    When I click on a site's row in the list
    Then it should zoom to a feature on the map
    When I toggle the filter panel
    Then the map should expand
    And I should not see any filter controls

  Scenario: Filtering by sites without score
    When I visit the home page
    Then I should see the scores column
    When I show only sites without scores
    Then I should not see the scores column
    And I should not see a key for the map markers

  Scenario: Searching for sites by address or reason
    When I search for sites with some text
    Then I should see only those sites that match that address text
    And I should see my search text
