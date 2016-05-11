require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe "attributes" do
    it "is valid with a username, email, and password" do
      expect(user).to be_valid
    end

    it "has basic email validation" do
      user.email = "IT IS NOT AN EMAIL!"
      expect(user).not_to be_valid
    end

    it "is invalid without a password confirmation" do
      user.password_confirmation = ""
      expect(user).not_to be_valid
    end
  end

  describe "relationships" do
    it { is_expected.to have_one(:profile).dependent(:destroy) }
    it { is_expected.to have_many(:snap_it_proxies).dependent(:destroy) }
    it { is_expected.to have_many(:snap_its).dependent(:destroy) }
    it { is_expected.to have_many(:following_relations).dependent(:destroy) }
    it { is_expected.to have_many(:following) }
    it { is_expected.to have_many(:follower_relations).dependent(:destroy) }
    it { is_expected.to have_many(:followers) }
  end
end
