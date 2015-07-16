When(/^I click on an allocation's row in the list$/) do
  @old_bounds = evaluate_script(MAP_BOUNDS_JS)
  find('tr.allocation:first-child').click
end

When(/^I visit the allocations page$/) do
  visit '/allocations'
end
