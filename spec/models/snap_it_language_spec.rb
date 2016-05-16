require 'rails_helper'

describe SnapItLanguage do
  subject { build(:snap_it_language) }

  it { is_expected.to have_many(:snap_its) }
  it { is_expected.to have_many(:snap_it_proxies) }

  it { is_expected.to validate_presence_of(:name).on(:create) }
  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to allow_value("", nil).for(:name).on(:update) }
  it { is_expected.to validate_presence_of(:editor_name).on(:create) }
  it { is_expected.to validate_uniqueness_of(:editor_name).on(:create) }


  it 'does not overwrite name when updated with nil or blank' do
    subject.save!
    subject.update!(:editor_name => nil)
    expect(subject.name).to_not be_nil
  end


  it 'does overwrite editor_name when updated with nil' do
    subject.save!
    subject.update!(:editor_name => nil)
    expect(subject.editor_name).to be_nil
  end
end






