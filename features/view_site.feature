Feature: Viewing a site
  As a local resident
  I want to see the scoring for sites I am familiar with
  So that I can report inaccuracies to Leeds City Council

  @javascript
  Scenario: Viewing a site with scores and a boundary
    Given that a site exists with some scores and a boundary
    When I visit the site's page
    Then I should see details about that site
    And I should see a map for that site
    And I should see colour-coded scores for that site
    And I should see help for each type of score

  @javascript
  Scenario: Viewing a site with no boundary
    Given that a site exists with no boundary
    When I visit the site's page
    Then I should see details about that site
    But I should not see a map for that site
