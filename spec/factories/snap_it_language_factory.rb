FactoryGirl.define do
  factory :snap_it_language do
    sequence(:name) { |n| "JavaScript#{n}" }
    sequence(:editor_name) { |n| "javascript#{n}" }
  end
end


