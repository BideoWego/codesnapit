require 'rails_helper'

describe SnapIt do

  describe 'relationships' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:snap_it_language) }
    it { is_expected.to belong_to(:snap_it_theme) }
    it { is_expected.to have_one(:photo) }
  end


  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_length_of(:description).is_at_most(512) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:snap_it_language) }
    it { is_expected.to validate_presence_of(:snap_it_theme) }
  end
end



