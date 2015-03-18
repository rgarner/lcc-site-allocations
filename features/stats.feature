Feature: Statistics
  As a citizen of Leeds
  I want to see how the site allocations break down between green and brown
  So I can be informed about the true figures before making an argument

  Scenario: Overall statistics
    Given there are some sites with scores
    When I visit the statistics page
    Then I should see a large pie chart showing green/brown/mix proportions
    And I should see a table of averages, minima and maxima linking to each green/brown type

