When(/^I click on an allocation's row in the list$/) do
  @old_bounds = evaluate_script(MAP_BOUNDS_JS)
  find('tr.allocation:first-child').click
end

When(/^I visit the allocations page$/) do
  visit '/allocations'
end

Then(/^I should see a list of allocations with a count$/) do
  expect(page).to have_selector('.allocation', count: @allocations.count)
  expect(page).to have_content("#{@allocations.count} allocations")
end

Then(/^I should see a map showing boundaries for allocations that have them and markers for those that don't$/) do
  expect(page).to have_selector('#map')
  expect(page).to have_selector('.leaflet-marker-icon', count: 1)
  expect(page).to have_selector('.boundary', count: 2)
end
