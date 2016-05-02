require 'rails_helper'

RSpec.feature "Profiles", type: :feature do
  let(:user) { create(:user, email: "foo@example.com") }
  let(:profile) { build(:profile) }

  context "Signed in user" do
    before do
      capy_sign_in(user)
    end

    feature "Editing" do
      scenario "A user has a button to edit their profile on the profile page" do
        visit user_profile_path(user)

        expect(page).to have_link("Edit Profile")
      end

      scenario "A user can update their profile" do
        visit edit_profile_path
        fill_in "profile[website]", with: "http://www.google.com"
        click_button "Update Profile"
        click_link "Back To Profile"

        expect(page).to have_link("Website", href: "http://www.google.com")
      end

      scenario "A user can't update their profile with invalid information" do
        visit edit_profile_path
        fill_in "profile[website]", with: ".."
        click_button "Update Profile"

        expect(page).to have_content("invalid URL")
        expect(page).to have_content("went wrong!")
      end
    end

    feature "Avatars" do
      before do
        visit edit_profile_path
      end  

      scenario "A user has a default avatar image" do
        expect(page).to have_selector("img[src*='missing_avatar']")
      end

      scenario "A user can upload an avatar from their computer" do
        attach_file "profile[avatar]", "#{Rails.root}/spec/support/test.png"
        click_button "Upload"

        expect(page).to have_selector("img[src*='test.png']")
      end

      scenario "A user can select to use their Gravatar" do
        click_button "Use Gravatar"

        expect(page).to have_content("Current Avatar Gravatar")
        expect(page).to have_selector("img[src*='#{Digest::MD5.hexdigest user.email}']")
      end

      scenario "A user can remove their avatar, and use the default avatar image" do
        attach_file "profile[avatar]", "#{Rails.root}/spec/support/test.png"
        click_button "Upload"

        expect(page).to have_selector("img[src*='test.png']")

        click_button "Remove Avatar"

        expect(page).to have_selector("img[src*='missing_avatar']")        
      end
    end
  end

  context "Visitor" do
    feature "Public Profile page" do
      scenario "A member of the site has a public profile page with their information" do
        user.profile.update(attributes_for(:profile))
        visit user_profile_path(user)

        expect(page).to have_link("Website", href: profile.website)
        expect(page).to have_content(profile.full_name)
        expect(page).to have_content(profile.bio)
        expect(page).to have_selector("img[src*='missing_avatar']")
      end

      scenario 'A Visitor does not see the "Edit Profile" button' do
        visit user_profile_path(user)

        expect(page).not_to have_link("Edit Profile")
      end
    end
  end
end
