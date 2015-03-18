When(/^I visit the home page$/) do
  visit '/'
end

Then(/^I should see a list of sites with a count$/) do
  expect(page).to have_selector('.site', count: @sites.count)
  expect(page).to have_content("#{@sites.count} sites")
end
