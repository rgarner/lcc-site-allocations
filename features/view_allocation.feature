Feature: Viewing an allocation
  As a person with an interest housing targets
  I want to see the allocations for sites
  So that I know how those targets are being met

  @javascript
  Scenario: Viewing an allocation with more than one site
    Given that an allocation exists with more than one site
    When I visit that allocation's page
    Then I should see details about that allocation
    And I should see links to its sites
    But I should not see details it does not have
    And I should see a map with a feature for each site in it
