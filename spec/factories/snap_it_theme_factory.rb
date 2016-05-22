FactoryGirl.define do
  factory :snap_it_theme do
    sequence(:name) { |n| "Monokai#{n}"}
    sequence(:editor_name) { |n| "monokai#{n}" }
  end
end

