FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "foouser#{n}" }
    sequence(:email) { |n| "foo#{n}@example.com" }
    password { "password" }
    # password confirmation not needed here
    confirmed_at Time.now
  end
end

