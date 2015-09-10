When(/^I visit that allocation's page$/) do
  visit allocation_path(@allocation)
end

Then(/^I should see details about that allocation$/) do
  expect(page).to have_selector('.allocation dl')
end

And(/^I should see a map with a feature for each site in it$/) do
  expect(page).to have_selector('#map')
  expect(page).to have_selector('.leaflet-marker-icon', count: @allocation.sites.select { |s| s.centroid.present? }.length)
  expect(page).to have_selector('.boundary',            count: @allocation.sites.select { |s| s.boundary.present? }.length)
end

But(/^I should not see details it does not have$/) do
  expect(page).not_to have_selector('.allocation dl dt', text: 'Area HA')
end
