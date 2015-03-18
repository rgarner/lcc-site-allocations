FactoryGirl.define do
  sequence :shlaa_ref do |ref|
    "#{ref}"
  end

  factory :site do
    shlaa_ref
  end
end
