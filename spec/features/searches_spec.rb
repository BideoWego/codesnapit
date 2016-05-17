require 'rails_helper'

RSpec.feature "Searches", type: :feature do
  let!(:user_b) { create(:user, username: "other") }
  let!(:user) { create(:user, username: "unique83") }
  let!(:snap_it) { create(:snap_it, 
    title: "neato title", 
    description: "clever description") }

  before do
    visit root_path
  end

  context "Visitors" do
    feature 'Snap It Search' do
      scenario "Search for snap its based on title" do
        fill_in "q", with: "neato"
        find('button[name="search"]').click

        expect(page).to have_content("neato title")
      end

      scenario "Search for snap its based on description" do
        fill_in "q", with: "clever"
        find('button[name="search"]').click

        expect(page).to have_content("clever description")      
      end   

      scenario "A helpful message is shown if there are no results" do
        fill_in "q", with: "zull"
        find('button[name="search"]').click

        expect(page).to have_content(" Sorry, I can't find any Snap Its")     
      end
    end

    feature "User search" do
      scenario "Search for users based on full name" do
        user.profile.update!(full_name: "doctor mario")
        fill_in "q", with: "mario"
        find('button[name="search"]').click

        expect(page).to have_content("doctor mario")            
      end

      scenario "Search for users based on username" do
        fill_in "q", with: "unique"
        find('button[name="search"]').click

        expect(page).to have_content("unique")            
      end

      scenario "Visitors do not see follow buttons for users" do
        fill_in "q", with: "unique"
        find('button[name="search"]').click

        expect(page).not_to have_content("follow")   
      end   
    end
  end

  context "Signed in user" do
    before do
      capy_sign_in(user)
    end

    scenario "Users see follow buttons for other users" do
      fill_in "q", with: "other"
      find('button[name="search"]').click

      expect(page).to have_content("Follow")   
    end   
  end


end
