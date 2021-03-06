When(/^I visit the site's page$/) do
  visit site_path(@site)
end

Then(/^I should see details about that site$/) do
  expect(page).to have_selector('.site-details dl', count: 2)
end

And(/^I should see a link to its allocation$/) do
  expect(page).to have_link("Part of allocation #{@site.allocation.plan_ref}")
end

And(/^I should see colour\-coded scores for that site$/) do
  expect(page).to have_selector('.scores .score.v0', count: @site.scores.count)
end

And(/^I should see help for each type of score$/) do
  expect(page).to have_selector('.scores .help', count: @site.scores.count)
end

And(/^I should see a map for that site$/) do
  expect(page).to have_selector('svg g path.leaflet-clickable')
end

But(/^I should not see a map for that site$/) do
  expect(page).not_to have_selector('svg g path.leaflet-clickable')
end
