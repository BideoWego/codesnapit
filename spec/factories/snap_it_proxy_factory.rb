FactoryGirl.define do
  factory :snap_it_proxy do
    sequence(:title) { |n| "My SnapItProxy - #{n}" }
    description "The description..."
    body "var foo = bar;"
    association :user
    association :snap_it_language
    association :snap_it_theme
  end
end

