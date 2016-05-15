require 'rails_helper'

describe SnapItProxy do
  let(:snap_it_language) { create(:snap_it_language) }
  let(:snap_it_theme) { create(:snap_it_theme) }
  let(:user) { create(:user) }
  let(:snap_it_proxy) { build(:snap_it_proxy, :user => user, :snap_it_language => snap_it_language, :snap_it_theme => snap_it_theme) }
  subject { snap_it_proxy }


  before do
    snap_it_language
    snap_it_theme
  end


  describe 'relationships' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:snap_it_language) }
    it { is_expected.to belong_to(:snap_it_theme) }
  end


  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_length_of(:description).is_at_most(512) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:token) }
    it { is_expected.to validate_uniqueness_of(:token) }
    it { is_expected.to validate_inclusion_of(:font_size).in_array(SnapItProxy::FONT_SIZES) }
    it { is_expected.to validate_numericality_of(:wrap_limit).is_greater_than(1) }
    it { is_expected.to allow_value("", nil).for(:wrap_limit) }


    it 'is valid when the snap_it_language is present' do
      expect(snap_it_proxy).to be_valid
    end

    it 'is valid when the snap_it_language has an editor_name' do
      expect(snap_it_proxy).to be_valid
    end


    it 'is invalid when the snap_it_language is not present' do
      snap_it_proxy.snap_it_language_id = 0
      expect(snap_it_proxy).to_not be_valid
    end


    it 'is invalid when the snap_it_language does not have an editor_name' do
      snap_it_language.update!(:editor_name => nil)
      expect(snap_it_proxy).to_not be_valid
    end


    it 'is valid when the snap_it_theme is present' do
      expect(snap_it_proxy).to be_valid
    end

    it 'is valid when the snap_it_theme has an editor_name' do
      expect(snap_it_proxy).to be_valid
    end


    it 'is invalid when the snap_it_theme is not present' do
      snap_it_proxy.snap_it_theme_id = 0
      expect(snap_it_proxy).to_not be_valid
    end


    it 'is invalid when the snap_it_theme does not have an editor_name' do
      snap_it_theme.update!(:editor_name => nil)
      expect(snap_it_proxy).to_not be_valid
    end
  end


  describe 'default attributes' do
    it 'has a default font_size' do
      expect(snap_it_proxy.font_size).to eq(18)
    end
  end


  describe 'callbacks' do
    describe 'token creation callback' do

      it 'creates a token' do
        snap_it_proxy.save!
        expect(snap_it_proxy.token).to_not be_nil
      end
    end


    describe 'clean up callback' do

      it 'destroys all other persisted snap_it_proxies' do
        3.times { create(:snap_it_proxy, :user => user) }
        proxy = create(:snap_it_proxy, :user => user)
        expect(user.snap_it_proxies.count).to eq(1)
        expect(user.snap_it_proxies.first).to eq(proxy)
      end
    end
  end


  describe '#create_image_data' do

    before do
      VCR.use_cassette 'screenshot_api/get_base64' do
        snap_it_proxy.create_image_data
      end
    end


    it 'creates a base64 string of the image data on the snap_it_proxy' do
      expect { Base64.strict_decode64(snap_it_proxy.image_data) }.to_not raise_error
    end
  end


  describe '#image_data_to_image_file' do

    before do
      VCR.use_cassette 'screenshot_api/get_base64' do
        snap_it_proxy.create_image_data
      end
    end


    it 'returns a paperclip image instance' do
      image = snap_it_proxy.image_data_to_image_file
      expect(image).to be_an_instance_of(Paperclip::DataUriAdapter)
    end


    it 'returns a file with a filename of the snap_it_proxy token' do
      image = snap_it_proxy.image_data_to_image_file
      expect(image.original_filename).to eq("#{snap_it_proxy.token}.jpg")
    end
  end
end

















