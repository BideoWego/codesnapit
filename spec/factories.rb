FactoryGirl.define do
  factory :follow do
    initiator_id 1
    following_id 2
  end

  factory :snap_it_theme do
    name 'Monokai'
    editor_name 'monokai'
  end


  factory :snap_it_language do
    name 'JavaScript'
    editor_name 'javascript'
  end


  factory :snap_it do
  end


  factory :snap_it_proxy do
    sequence(:title) { |n| "My Snapit #{n}" }
    description "The description..."
    body "var foo = bar;"
  end


  factory :user do
    sequence(:username) { |n| "foouser#{n}" }
    sequence(:email) { |n| "foo#{n}@example.com" }
    password { "password" }
    # password confirmation not needed here
    confirmed_at Time.now
  end


  factory :profile do
    full_name "Foo Bar"
    website "http://example.com"
    bio "a" * 15
    association :user
  end
end


