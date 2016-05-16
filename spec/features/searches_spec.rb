require 'rails_helper'

RSpec.feature "Searches", type: :feature do
  let(:user) { create(:user) }
  let!(:snap_it) { create(:snap_it, 
    title: "neato title", 
    description: "clever description") }

  context "Signed in user" do
    before do
      capy_sign_in(user)
    end

    scenario "A user can search for snap its based on title" do
      visit root_path
      fill_in "search", with: "neato"
      click_button "search"

      expect(page).to have_content("neato title")
    end
  end
end
