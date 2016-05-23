FactoryGirl.define do
  factory :comment do
    association :author, factory: :user
    association :parent, factory: :snap_it
    body "MyText"
  end
end
