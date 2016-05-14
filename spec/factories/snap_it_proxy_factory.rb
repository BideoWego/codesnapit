FactoryGirl.define do
  factory :snap_it_proxy do
    sequence(:title) { |n| "My Snapit #{n}" }
    description "The description..."
    body "var foo = bar;"
  end
end

