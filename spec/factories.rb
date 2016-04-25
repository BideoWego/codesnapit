FactoryGirl.define do
  factory :editor_theme do
    
  end
  factory :editor_language do
    
  end
  factory :snap_it_theme do
    
  end
  factory :snap_it_language do
    
  end
  factory :snap_it do
    
  end
  
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