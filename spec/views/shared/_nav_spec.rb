require 'rails_helper'

describe "shared/_nav.html.erb" do
  let(:user){ create(:user) }

  context "logged in user" do
    before do
      def view.user_signed_in?
        true
      end

      @user = user
      def view.current_user
        @user
      end
    end

    it "shows logged in links" do
      render
      expect(rendered).to have_selector("a[href=\"#{destroy_user_session_path}\"]", :text => "Logout")
      expect(rendered).to have_selector("a", text: 'Edit Profile')
      expect(rendered).to have_selector("a", text: 'Timeline')
      expect(rendered).to have_selector("a[href=\"#{edit_user_registration_path}\"]", text: 'Account Settings')
    end

    it "shows brand link as activities page" do
      render
      expect(rendered).to have_selector("a[href=\"#{activities_path}\"][class=\"navbar-brand\"]")
    end

    it "shows search bar" do
      render
      expect(rendered).to have_selector("form[action=\"#{search_path}\"]")
    end
  end

  context "not logged in user" do
    before do
      def view.user_signed_in?
        false
      end
    end

    it "shows logged out links" do
      render
      expect(rendered).to have_selector("a[href=\"#{new_user_session_path}\"]", text: 'Login')
      expect(rendered).to have_selector("a[href=\"#{new_user_registration_path}\"]", text: 'Sign Up!')
    end

    it "shows brand link as root page" do
      render
      expect(rendered).to have_selector("a[href=\"#{root_path}\"][class=\"navbar-brand\"]")
    end

    it "shows search bar" do
      render
      expect(rendered).to have_selector("form[action=\"#{search_path}\"]")
    end

  end
end