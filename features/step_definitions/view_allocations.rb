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

When(/^I filter by policy "([^"]*)"$/) do |policy|
  within '.filter-type .policy' do
    click_link 'HG1'
  end
end

Then(/^I should not see the Area \(ha\) column$/) do
  expect(page).not_to have_selector('th', text: 'Area (ha)')
end

And(/^I should see the construction progress columns$/) do
  expect(page).to have_selector('th', text: 'Not started')
  expect(page).to have_selector('th', text: 'Completed post-2012')
  expect(page).to have_selector('th', text: 'Under construction')
end
