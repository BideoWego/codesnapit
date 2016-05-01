require 'rails_helper'

RSpec.feature "Users", type: :feature do
  let(:user) { create(:user, email: "foo@example.com") }

  context "Visitor" do  
    scenario "Sign up with valid information succeeds" do
      visit new_user_registration_path
      fill_in "user[username]", with: "foo"
      fill_in "user[email]", with: "foo@bar.com"
      fill_in "user[password]", with: "password"
      fill_in "user[password_confirmation]", with: "password"

      expect{ click_button "Sign up!" }.to change(User, :count).by(1)
    end

    scenario "Sign up with invalid information fails" do
      visit new_user_registration_path
      fill_in "user[username]", with: "f"
      fill_in "user[email]", with: "foo@"
      fill_in "user[password]", with: "password"

      expect{ click_button "Sign up!" }.not_to change(User, :count)
      expect(page).to have_content("Username is too short")
      expect(page).to have_content("Email is invalid")
      expect(page).to have_content("doesn't match")
    end
  end

  context "Signed in user" do
    before do
      capy_sign_in(user)
    end

    scenario "Update basic account information with valid changes succeeds" do
      visit edit_user_registration_path
      fill_in "user[username]", with: "foobarbaz"
      fill_in "user[current_password]", with: "password"
      click_button "Update"

      user.reload
      expect(user.username).to eq("foobarbaz")
    end

    scenario "Edit basic account information with invalid changes fails" do
      visit edit_user_registration_path
      fill_in "user[username]", with: ""
      fill_in "user[current_password]", with: "password"
      click_button "Update"

      user.reload
      expect(user.username).to eq(attributes_for(:user)[:username])
      expect(page).to have_content("Username is too short")
    end

    scenario "Delete account with correct password entered succeeds" do
      visit edit_user_registration_path
      fill_in "user[current_password]", with: "password"
      
      expect{ click_button "Delete Account" }.to change(User, :count).by(-1)
    end

    scenario "Delete account without current password fails" do
      visit edit_user_registration_path
      fill_in "user[current_password]", with: "incorrect"

      expect{ click_button "Delete Account" }.not_to change(User, :count)
    end
  end

end
