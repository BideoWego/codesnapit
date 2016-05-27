require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  let!(:user) { create(:user, username: "unique83") }
  let!(:snap_it) { create(:snap_it, 
    title: "neato title", 
    description: "clever description") }

  context "All users (guests and signed in users)" do
    describe "GET #search" do
      it "redirects back if the search param is missing" do
        get :search

        expect(flash[:warning]).to be_present
        expect(response).to redirect_to root_path
      end

      it "redirects back if the search is invalid" do
        get :search, q: ""

        expect(flash[:warning]).to be_present
        expect(response).to redirect_to root_path
      end

      it "sets the snap_it variable when there's results" do
        get :search, q: "neato"

        expect(assigns(:snap_its)).to include(snap_it)
      end

      it "sets the users variable when there's results" do
        get :search, q: "unique"

        expect(assigns(:users)).to include(user)
      end      
    end
  end
end
