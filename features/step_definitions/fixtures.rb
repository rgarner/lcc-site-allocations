Given(/^there are some sites(?: with scores)?$/) do
  @sites = [
    create(:site, :with_boundary, total_score: -19, green_brown: 'green', address: 'Green site', io_rag: 'G'),
    create(:site, :with_centroid, :with_boundary, total_score: 0, green_brown: 'mix', address: 'Mixed site', io_rag: 'A'),
    create(:site, :with_centroid, total_score: +19, green_brown: 'brown', address: 'Brown site', io_rag: 'R')
  ]
end

Given(/^that a site exists with some scores and a boundary$/) do
  @site = create :site, :with_boundary
  @site.scores = [create(:score), create(:score)]
end

Given(/^that a site exists with no boundary$/) do
  @site = create :site
end


Given(/^that there are enough unsustainable sites$/) do
  expect(@sites.size).to eql(3)
  @sites.concat(
    (-20..-10).map do |score|
      create :site, total_score: score
    end
  )
  expect(@sites.size).to eql(14)
end

Given(/^there are some allocations$/) do
  @allocations = [
    create(:allocation, :with_site),
    create(:allocation, :with_sites),
    create(:allocation, address: 'the new allocation site'),
    create(:allocation, plan_ref: 'HG2-1', green_brown: 'brownfield')
  ]
end
