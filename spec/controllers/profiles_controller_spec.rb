require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  let(:user) { create(:user) }

  describe "Visitors" do  
    describe "GET #show" do
      before do
        get :show, user_id: user.id
      end

      it "renders the show template" do
        expect(response).to render_template :show
      end

      it "sets up a profile variable for the user id specified" do
        expect(assigns(:profile)).to eq(user.profile)
      end
    end
  end

  describe "Signed in users" do
    before do
      sign_in(user)
    end

    describe "GET #edit" do
      before do
        get :edit
      end
      
      it "renders the edit template" do
        expect(response).to render_template :edit
      end

      it "sets up a profile variable for the current user's profile" do
        expect(assigns(:profile)).to eq(user.profile)
      end
    end
  end
  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #update" do
  #   it "returns http success" do
  #     get :update
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
