require 'rails_helper'

RSpec.describe Follow, type: :model do
  describe "relationships" do
    it { is_expected.to belong_to(:initiator) }
    it { is_expected.to belong_to(:following) }
  end

  describe "validations" do
    subject { build(:follow) }

    it 'with an initiator and following is valid' do
      created_users = create_pair(:user)
      follow = build(:follow, initiator_id: created_users[0].id, following_id: created_users[1].id)
      expect(follow).to be_valid
    end

    it { is_expected.to validate_presence_of(:initiator) }
    it { is_expected.to validate_presence_of(:following) }
    it { is_expected.to validate_uniqueness_of(:following_id).scoped_to(:initiator_id) }
  end
end
