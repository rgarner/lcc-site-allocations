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

Then(/^I should see the scores column$/) do
  expect(page).to have_selector('th.site-total-score')
end

When(/^I show only sites without scores$/) do
  within '.filters' do
    click_link 'Without'
  end
end

Then(/^I should not see the scores column$/) do
  expect(page).not_to have_selector('th.site-total-score')
end

When(/^I search for sites with some text$/) do
  step 'I visit the home page'
  within '.filters' do
    @search_text = 'Green site'
    fill_in 'Containing text', with: @search_text
    click_button 'Search'
  end
end

Then(/^I should see only those sites that match that address text$/) do
  expect(page).to have_selector('.site', count: 1)
end

Then(/^I should see my search text$/) do
  expect(page).to have_selector(%(input[value="#{@search_text}"]))
end

Then(/^I should see a map showing boundaries for sites that have them and markers for those that don't$/) do
  expect(page).to have_selector('#map')
  expect(page).to have_selector('.leaflet-marker-icon', count: 1)
  expect(page).to have_selector('.boundary', count: 2)
end

And(/^I should see a key for the map markers$/) do
  expect(page).to have_selector('.marker-key')
end

And(/^I should not see a key for the map markers$/) do
  expect(page).not_to have_selector('.marker-key')
end

When(/^I click on a site's row in the list$/) do
  @old_bounds = evaluate_script(MAP_BOUNDS_JS)
  find('tr.site:first-child').click
end

Then(/^it should zoom to a feature on the map$/) do
  @new_bounds = evaluate_script(MAP_BOUNDS_JS)
  expect(@old_bounds['_northEast']['lng']).not_to be_within(0.01).of(@new_bounds['_northEast']['lng'])
end

When(/^I toggle the filter panel$/) do
  find('#filters-panel-collapser').click
end

Then(/^the map should expand/) do
  expect(evaluate_js('$("#map").attr("class")')).to include('expanded')
end

And(/^I should not see any filter controls$/) do
  expect(page).not_to have_selector('.filter_type')
end

When(/^I filter by I&O\/RAG "([^"]*)"$/) do |io_rag|
  within '.filter-type.io-rag' do
    find('.caret').click
    @io_rag = io_rag
    click_link RAGStatus[io_rag].display_name
  end
end

Then(/^I should see only sites that match the I&O\/RAG I selected$/) do
  expect(page).to have_selector('.site', count: Site.where(io_rag: @io_rag).count)
end

Then(/^I should see what I&O\/RAG I filtered by$/) do
  within '.filter-type.io-rag' do
    expect(page).to have_selector('button', text: RAGStatus[@io_rag].display_name)
  end
end

Then(/^I should see the "([^"]*)" filter$/) do |text|
  expect(page).to have_selector('label.filter-type-heading', text: text)
end

Then(/^I should not see the "([^"]*)" filter$/) do |text|
  expect(page).not_to have_selector('label.filter-type-heading', text: text)
end
