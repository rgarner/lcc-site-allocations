When(/^I visit the home page$/) do
  visit '/'
end

Then(/^I should see a list of sites with a count$/) do
  expect(page).to have_selector('.site', count: @sites.count)
  expect(page).to have_content("#{@sites.count} sites")
end

Then(/^I should see colour\-coded scores for each site$/) do
  expect(page).to have_selector('.site-total-score.very-positive', count: 1)
  expect(page).to have_selector('.site-total-score.neutral', count: 1)
  expect(page).to have_selector('.site-total-score.very-negative', count: 1)
end
