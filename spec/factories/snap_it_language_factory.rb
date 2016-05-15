FactoryGirl.define do
  factory :snap_it_language do
    initialize_with do
      SnapItLanguage.find_or_create_by(
        :name => 'JavaScript',
        :editor_name => 'javascript'
      )
    end
  end
end


