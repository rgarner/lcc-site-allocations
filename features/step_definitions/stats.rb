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
