Given(/^there are some sites$/) do
  @sites = [
    create(:site, total_score: -19),
    create(:site, total_score: 0),
    create(:site, total_score: +19)
  ]
end
