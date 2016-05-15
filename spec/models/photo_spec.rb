require 'rails_helper'

describe Photo do
  subject { build(:photo) }

  it { is_expected.to belong_to(:attachable) }
  it { is_expected.to have_attached_file(:file) }

  it { is_expected.to validate_attachment_presence(:file) }
  it { is_expected.to validate_attachment_size(:file).less_than(2.megabytes) }
  it do
    is_expected.to validate_attachment_content_type(:file)
      .allowing("image/jpeg", "image/gif", "image/png")
  end
end






