FactoryGirl.define do
  factory :snap_it do
    sequence(:title) { |n| "SnapIt Title - #{n}" }
    sequence(:description) { |n| "SnapIt description = #{n}" }
    body "for (var i = 0; i < 100; i++) console.log('foobar');"
  end
end

