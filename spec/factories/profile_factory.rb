FactoryGirl.define do
  factory :profile do
    full_name "Foo Bar"
    website "http://example.com"
    bio "a" * 15
    association :user
  end
end

