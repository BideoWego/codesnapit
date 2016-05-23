require 'rails_helper'

RSpec.describe Like, type: :model do


  describe "relationships" do
    it { is_expected.to belong_to(:creator) }
    it { is_expected.to belong_to(:parent) }
  end

  describe "validations" do
    let(:user) { create(:user) }
    let!(:snap_it) { create(:snap_it) }
    subject { Like.new(creator: user, parent_id: snap_it.id, parent_type:"SnapIt") }

    it { is_expected.to validate_presence_of(:creator) }
    it { is_expected.to validate_presence_of(:parent) }
    # some issue with shoulda matchers here
    # it { is_expected.to validate_uniqueness_of(:parent_type).
    #   scoped_to(:parent_id, :user_id) }
  end
end
