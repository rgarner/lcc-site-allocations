Given(/^there are some sites(?: with scores)?$/) do
  @sites = [
    create(:site, total_score: -19, green_brown: 'green'),
    create(:site, total_score: 0, green_brown: 'mix'),
    create(:site, total_score: +19, green_brown: 'brown')
  ]
end