When(/^I visit the statistics page$/) do
  visit '/stats'
end

Then(/^I should see a large pie chart showing green\/brown\/mix proportions$/) do
  expect(page.body).to include('var data = [')
  # One value: 1 per green/brown site
  expect(page.body).to have_content('value: 1', count: 3)
end

Then(/^I should see a table of averages, minima and maxima linking to each green\/brown type$/) do
  expect(page).to have_content('Scores')
  expect(page).to have_selector('table.averages > tbody > tr > td > a', count: 3)
end

When(/^I visit the distribution page$/) do
  visit '/stats/distribution'
end

Then(/^I should see a graph showing the distribution of site scores by green, brown and mixed$/) do
  expect(page.body).to include('var data = {')
  expect(page.body).to include('"label":"Green"')
  expect(page.body).to include('"label":"Brown"')
  expect(page.body).to include('"label":"Mix"')
end


When(/^I visit the unsustainable sites page$/) do
  visit '/stats/unsustainable'
end

Then(/^I should see a table with the top 10 unsustainable sites$/) do
  expect(page).to have_selector('.site', count: 10)
end

And(/^I should see a map of those sites$/) do
  expect(page).to have_selector('#map')
  expect(page).to have_selector(
    '.leaflet-marker-icon',
    count: Site.unsustainable.where('boundary IS NULL AND centroid IS NOT NULL').count
  )
end

And(/^the columns should not be sortable$/) do
  expect(page).not_to have_selector('th a.sort')
end
