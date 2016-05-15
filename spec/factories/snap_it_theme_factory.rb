FactoryGirl.define do
  factory :snap_it_theme do
    initialize_with  do
      SnapItTheme.find_or_create_by(
        :name => 'Monokai',
        :editor_name => 'monokai'
      )
    end
  end
end

