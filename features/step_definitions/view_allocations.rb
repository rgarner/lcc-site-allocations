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
  expect(page).to have_selector('.boundary', count: 1)
end

When(/^I filter by policy "([^"]*)"$/) do |policy|
  within '.filter-type .policy' do
    click_link policy
  end
end

Then(/^I should not see the Area \(ha\) column$/) do
  expect(page).not_to have_selector('th', text: 'Area (ha)')
end

Then(/^I should see the Area \(ha\) column$/) do
  expect(page).to have_selector('th', text: 'Area (ha)')
end

And(/^I should see the construction progress columns$/) do
  expect(page).to have_selector('th', text: 'Not started')
  expect(page).to have_selector('th', text: 'Completed post-2012')
  expect(page).to have_selector('th', text: 'Under construction')
end

When(/^I search for allocations with some text$/) do
  within '.filters' do
    @search_text = 'new allocation'
    fill_in 'Containing text', with: @search_text
    click_button 'Search'
  end
end

Then(/^I should see only those allocations that match that text$/) do
  expect(page).to have_selector('.allocation', count: 1)
end

And(/^I should see the green\/brown filters$/) do
  expect(page).to have_selector('.filter-type .greenfield-status')
end

But(/^I should not see the green\/brown filters$/) do
  expect(page).not_to have_selector('.filter-type .greenfield-status')
end

But(/^I should not see the construction progress columns$/) do
  expect(page).not_to have_selector('th', text: 'Not started')
  expect(page).not_to have_selector('th', text: 'Completed post-2012')
  expect(page).not_to have_selector('th', text: 'Under construction')
end

When(/^I filter by greenfield status "brownfield"$/) do
  within '.greenfield-status' do
    click_link 'Brownfield'
  end
end

Then(/^I should see only brownfield allocations$/) do
  within 'table.allocations' do
    expect(page).to have_selector('.allocation .glyphicon-oil', count: 1)
  end
end
