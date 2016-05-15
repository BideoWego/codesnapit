require 'rails_helper'

describe SnapItProxy do

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
    it { is_expected.to validate_presence_of(:snap_it_language) }
    it { is_expected.to validate_presence_of(:snap_it_theme) }
  end


  describe 'callbacks' do
    let(:snap_it_proxy) { build(:snap_it_proxy) }

    it 'creates a token before create' do
      snap_it_proxy.save!
      expect(snap_it_proxy.token).to_not be_nil
    end
  end
end



