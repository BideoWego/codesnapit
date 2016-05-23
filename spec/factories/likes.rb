FactoryGirl.define do
  factory :like do
    association :creator, factory: :user
    association :parent, factory: :snap_it
  end
end
