FactoryGirl.define do
  
  sequence :email do |n|
    "foo#{n}@example.com"
  end

  factory :user do
    username { "foouser" }
    email
    password { "password" }
    # password confirmation not needed here
  end

end