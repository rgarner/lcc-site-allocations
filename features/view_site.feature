Feature: Viewing a site
  As a local resident
  I want to see the scoring for sites I am familiar with
  So that I can report inaccuracies to Leeds City Council

  Scenario: Viewing a site with scores
    Given that a site exists with some scores
    When I visit the site's page
    Then I should see details about that site
    And I should see colour-coded scores for that site
    And I should see help for each type of score
