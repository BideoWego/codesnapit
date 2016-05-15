FactoryGirl.define do
  factory :snap_it do
    sequence(:title) { |n| "SnapIt Title - #{n}" }
    sequence(:description) { |n| "SnapIt description = #{n}" }
    body "for (var i = 0; i < 100; i++) console.log('foobar');"
    association :photo, :factory => :snap_it_photo
    association :user
    association :snap_it_language
    association :snap_it_theme
  end
end

