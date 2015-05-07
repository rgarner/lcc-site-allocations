Given(/^there are some sites(?: with scores)?$/) do
  @sites = [
    create(:site, :with_boundary, total_score: -19, green_brown: 'green', address: 'Green site'),
    create(:site, :with_centroid, :with_boundary, total_score: 0, green_brown: 'mix', address: 'Mixed site'),
    create(:site, :with_centroid, total_score: +19, green_brown: 'brown', address: 'Brown site')
  ]
end

Given(/^that a site exists with some scores and a boundary$/) do
  @site = create :site, :with_boundary
  @site.scores = [create(:score), create(:score)]
end

Given(/^that a site exists with no boundary$/) do
  @site = create :site
end
