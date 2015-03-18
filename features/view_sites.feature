Feature: View sites
  In order to hold Leeds City Council to account
  As a citizen of Leeds
  I want to see what sites are likely to be allocated for housing

  Background:
    Given there are some sites

  Scenario: Look at the unfiltered list
    When I visit the home page
    Then I should see a list of sites with a count
    And I should see colour-coded scores for each site

  Scenario: Filtering by sites without score
    When I visit the home page
    Then I should see the scores column
    When I show only sites without scores
    Then I should not see the scores column
