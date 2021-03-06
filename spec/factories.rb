FactoryGirl.define do
  sequence :shlaa_ref do |ref|
    "#{ref}"
  end

  sequence :plan_ref do |ref|
    "HG1-#{ref}"
  end

  sequence :sa_objective_code do |num|
    "SA#{num}"
  end

  factory :site do
    shlaa_ref

    trait :with_boundary do
      boundary 'POLYGON((-1.47486759802822 53.8426310787134,-1.47405228707635 53.8434637700614,-1.47035086877967 53.8433086917616,-1.47021270788897 53.8433910009922,-1.46758423736764 53.8432845766634,-1.4696329352046 53.8407270784017,-1.47323823376588 53.840839869631,-1.47336705217763 53.8412007147184,-1.47395562835178 53.8421119831296,-1.47399856782236 53.8424949717742,-1.47440631312983 53.8425993840685,-1.47486759802822 53.8426310787134))'
    end

    trait :with_centroid do
      centroid 'POINT(-1.47486759802822 53.8426310787134)'
    end

    trait :with_allocation do
      allocation
    end

    io_rag 'G'
  end

  factory :score_type do
    sa_objective_code
  end

  factory :score do
    association :score_type
    score 0
  end

  factory :allocation do
    plan_ref
    green_brown 'greenfield'

    address 'The old allocation site'

    trait :with_site do
      after(:create) { |a| a.sites = FactoryGirl.create_list(:site, 1) }
    end

    trait :with_sites do
      after(:create) { |a| a.sites = [FactoryGirl.create(:site, :with_boundary),FactoryGirl.create(:site, :with_centroid)] }
    end
  end
end
