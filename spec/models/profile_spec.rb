require 'rails_helper'

RSpec.describe Profile, type: :model do
  let!(:user) { create(:user) }
  let(:profile) { build(:profile) }

  describe "user association" do
    it 'is created when a user is created' do
      expect(user.profile).to be_present
    end

    it 'is destroyed along with the user' do
      expect{user.destroy}.to change(Profile, :count).by(-1)
    end
  end

  describe "attributes" do
    it 'valid with blank full name, website, and bio' do
      profile.full_name = ""
      profile.website = ""
      profile.bio = ""
      expect(profile).to be_valid
    end

    it 'enforces min and max length if attribute is specified' do
      profile.full_name = "a"

      expect(profile).not_to be_valid
    end

    it 'validates website URL format' do #uses valid_url gem
      profile.website = "hhh.h"

      expect(profile).not_to be_valid
    end
  end
end
