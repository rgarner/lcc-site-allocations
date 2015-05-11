Feature: Statistics
  As a citizen of Leeds
  I want to see how the site allocations break down between green and brown
  So I can be informed about the true figures before making an argument

  Background:
    Given there are some sites with scores

  Scenario: Overall statistics
    When I visit the statistics page
    Then I should see a large pie chart showing green/brown/mix proportions
    And I should see a table of averages, minima and maxima linking to each green/brown type

  Scenario: Site distribution
    When I visit the distribution page
    Then I should see a graph showing the distribution of site scores by green, brown and mixed

  @javascript
  Scenario: Unsustainable sites
    Given that there are enough unsustainable sites
    When I visit the unsustainable sites page
    Then I should see a table with the top 10 unsustainable sites
    And I should see a map of those sites
