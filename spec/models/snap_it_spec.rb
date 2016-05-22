require 'rails_helper'

describe SnapIt do
  describe 'relationships' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:snap_it_language) }
    it { is_expected.to belong_to(:snap_it_theme) }
    it { is_expected.to have_one(:photo) }
    it { is_expected.to have_many(:comments) }
  end


  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_length_of(:description).is_at_most(512) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:snap_it_language) }
    it { is_expected.to validate_presence_of(:snap_it_theme) }
  end


  describe 'class methods' do
    let(:snap_it_proxy) { create(:snap_it_proxy) }

    describe '#new_from_token' do
      it 'accepts a snap_it_proxy token as an argument' do
        expect { SnapIt.new_from_token(snap_it_proxy.token) }.to_not raise_error
      end


      it 'raises an error when no token is provided' do
        expect { SnapIt.new_from_token }.to raise_error(ArgumentError)
      end


      it 'returns a new snap_it when the token is not found' do
        expect(SnapIt.new_from_token('Not a token!')).to be_an_instance_of(SnapIt)
      end


      it 'builds a snap_it from the snap_it_proxy when the token is valid' do
        expect(SnapIt.new_from_token(snap_it_proxy.token)).to be_an_instance_of(SnapIt)
      end


      it 'returns a snap_it with attributes matching the snap_it_proxy' do
        snap_it = SnapIt.new_from_token(snap_it_proxy.token)
        expect(snap_it.title).to eq(snap_it_proxy.title)
        expect(snap_it.description).to eq(snap_it_proxy.description)
        expect(snap_it.body).to eq(snap_it_proxy.body)
        expect(snap_it.font_size).to eq(snap_it_proxy.font_size)
        expect(snap_it.wrap_limit).to eq(snap_it_proxy.wrap_limit)
        expect(snap_it.user).to eq(snap_it_proxy.user)
        expect(snap_it.snap_it_language).to eq(snap_it_proxy.snap_it_language)
        expect(snap_it.snap_it_theme).to eq(snap_it_proxy.snap_it_theme)
      end


      it 'builds a snap_it with an associated photo matched the data from the snap_it_proxy' do
        snap_it = SnapIt.new_from_token(snap_it_proxy.token)
        snap_it.save!
        image = File.read(snap_it.photo.file.path)
        base64 = Base64.encode64(image)
        expect(base64).to eq(snap_it_proxy.image_data)
      end
    end
  end
end



