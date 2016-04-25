require 'rails_helper'

RSpec.feature "Profiles", type: :feature do
  let(:user) { create(:user, email: "foo@example.com") }

  # context "Signed in user" do
  #   scenario "A user can update their profile" do
  #     capy_sign_in(user)
  #     visit edit_profile_path
  #     fill_in "profile[website]", with: "http://www.google.com"
  #     click_button "Update Profile"

  #     expect(page).to have_link("Website", :href=>"http://google.com")
  #   end
  # end
end
