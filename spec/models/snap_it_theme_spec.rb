require 'rails_helper'

describe SnapItTheme do
  subject { build(:snap_it_theme) }

  it { is_expected.to have_many(:snap_its) }
  it { is_expected.to have_many(:snap_it_proxies) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to validate_presence_of(:editor_name) }
  it { is_expected.to validate_uniqueness_of(:editor_name) }
end






