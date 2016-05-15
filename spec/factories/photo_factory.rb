include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :photo do
    factory :snap_it_photo do
      file do
        fixture_file_upload(FactoryHelper.test_image_path(:jpg), 'image/jpeg')
      end
    end
  end
end




