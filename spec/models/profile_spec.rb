require 'rails_helper'

RSpec.describe Profile, type: :model do
  let(:profile) { build(:profile) }
  let!(:user) { create(:user, ) }

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

    it "adds http:// to website if needed" do
      profile.website = "google.com"
      profile.save

      expect(profile.website).to eq("http://google.com")
    end

    it "has_attached_file :avatar" do
      expect(profile).to have_attached_file(:avatar)
    end

    it "validates avatar image content type" do
      expect(profile).to validate_attachment_content_type(:avatar).
                         rejecting('text/plain', 'text/xml')
    end


    it "validates avatar image size" do
      expect(profile).to validate_attachment_size(:avatar).
                         less_than(5.megabytes)
    end
  end

  describe '#gr_or_avatar' do
    let!(:avatar_user) { create(:user, profile: profile) }

    it "returns the missing_avatar paperclip image by default" do
      expect(avatar_user.profile.gr_or_avatar).to include("missing_avatar")
    end

    it "returns the gravatar URL, if gravatar attribute is true" do
      u = avatar_user
      p = u.profile
      p.update(gravatar: true)

      expect(p.gr_or_avatar).to include(Digest::MD5.hexdigest u.email)
    end

    it "returns the paperclip avatar if one has been uploaded" do
      u = avatar_user
      p = u.profile
      p.update(avatar: File.new("#{Rails.root}/spec/support/test.png", "r"))

      expect(p.gr_or_avatar).to include("test.png")
    end

    it "returns a 'medium' sized avatar by default" do
      u = avatar_user
      p = u.profile
      p.update(avatar: File.new("#{Rails.root}/spec/support/test.png", "r"))

      expect(p.gr_or_avatar).to include("medium")
    end

    it "returns a 'small' avatar if :small size specified" do
      u = avatar_user
      p = u.profile
      p.update(avatar: File.new("#{Rails.root}/spec/support/test.png", "r"))

      expect(p.gr_or_avatar(:small)).to include("small")
    end

    it "returns a 180px gravatar by default" do
      u = avatar_user
      p = u.profile
      p.update(gravatar: true)

      expect(p.gr_or_avatar).to include("s=180")
    end

    it "returns a 32px gravatar if :small size specified" do
      u = avatar_user
      p = u.profile
      p.update(gravatar: true)

      expect(p.gr_or_avatar(:small)).to include("s=32")      
    end
  end
end
