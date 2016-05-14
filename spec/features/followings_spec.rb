require 'rails_helper'

RSpec.feature "Followings", type: :feature do
  let(:user_a) { create(:user, username: "foouser") }
  let(:user_b) { create(:user, username: "baruser") }

  context "Signed in user" do
    before do
      capy_sign_in(user_a)
    end
    
    feature "Following" do
      scenario "A user can follow another user from that user's profile" do
        visit user_profile_path(user_b)

        expect{ 
          click_link "Follow" 
        }.to change(user_a.following, :count).by(1)
      end

      scenario "A user can unfollow another user from that user's profile" do
        visit user_profile_path(user_b)
        click_link "Follow"

        expect{ 
          click_link "Following" 
        }.to change(user_a.following, :count).by(-1)
      end

      scenario "A user does not see a follow button on their own profile" do
        visit user_profile_path(user_a)

        expect(page).not_to have_link("Follow", {exact: true})
      end
    end

    feature "Following/Followers list" do
      before do
        user_a.following << user_b
      end

      scenario "A user can view a list of those they are following" do
        visit user_profile_path(user_a)
        
        expect(page).to have_content("Following (1)")
        expect(page).to have_content("baruser")
      end

      scenario "A user can view a list of those that are following them" do
        visit user_profile_path(user_b)

        expect(page).to have_content("Followers (1)")
        expect(page).to have_content("foouser")
      end
    end
  end

  context "Signed out user/visitor" do
    scenario "Visitors do not see follow/unfollow buttons" do
      visit user_profile_path(user_a)

      expect(page).not_to have_link("Follow", {exact: true})
      expect(page).not_to have_link("Unfollow", {exact: true})
    end
  end
end
