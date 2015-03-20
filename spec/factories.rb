FactoryGirl.define do
  sequence :shlaa_ref do |ref|
    "#{ref}"
  end

  sequence :sa_objective_code do |num|
    "SA#{num}"
  end

  factory :site do
    shlaa_ref
  end

  factory :score_type do
    sa_objective_code
  end

  factory :score do
    association :score_type
    score 0
  end
end
