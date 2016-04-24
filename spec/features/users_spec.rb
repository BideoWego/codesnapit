require 'rails_helper'

RSpec.feature "Users", type: :feature do
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
