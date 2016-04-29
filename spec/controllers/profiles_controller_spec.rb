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

    describe "PATCH #update" do
      let(:photo_upload) do
        photo_path = "#{Rails.root}/spec/support/test.png"
        Rack::Test::UploadedFile.new(photo_path,'image/png')
      end

      it "updates the user's profile" do
        patch :update, profile: attributes_for(:profile, full_name: "Fizz Bar")

        user.reload
        expect(user.profile.full_name).to eq("Fizz Bar")
      end

      it "re-renders edit if the update fails" do
        patch :update, profile: attributes_for(:profile, website: "localhost")

        expect(response).to render_template(:edit)
      end

      it "uploads a user's avatar" do
        patch :update, profile: {avatar: photo_upload}

        user.profile.reload
        expect(user.profile.avatar_file_name).to eq("test.png")
      end

      it "changes profile to user gravatar if :use_gravatar param is present" do
        patch :update, profile: {ignored: "..."}, use_gravatar: "..."

        user.profile.reload
        expect(user.profile.gravatar).to be true
      end

      it "removes an uploaded avatar and disables gravatar if :remove_avatar param is present" do
        patch :update, profile: {ignored: "..."}, remove_avatar: "..."

        user.profile.reload
        expect(user.profile.gravatar).to be false
        expect(user.profile.avatar_file_name).to be nil
      end
    end
  end

  describe 'Visiors/signed out users' do
    describe "GET #edit" do
      it "should redirect to sign in" do
        get :edit

        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "PATCH #update" do
      it "should redirect to sign in" do
        patch :update, profile: attributes_for(:profile, full_name: "Fizz Bar")

        expect(response).to redirect_to new_user_session_path
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
