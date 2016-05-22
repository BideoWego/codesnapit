require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "relationships" do
    it { is_expected.to belong_to(:author) }
    it { is_expected.to belong_to(:parent) }
  end

  describe "validations" do
    it { is_expected.to validate_length_of(:body).is_at_most(512) }
    it { is_expected.to validate_length_of(:body).is_at_least(4) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:author) }
    it { is_expected.to validate_presence_of(:parent) }
  end

  describe "default scope" do
    let!(:comment_one) { create(:comment) }
    let!(:comment_two) { create(:comment) }

    it "groups comments in ascending order" do
      expect(Comment.all).to eq([comment_one, comment_two])
    end
  end
end
