require 'rails_helper'

RSpec.describe FollowsController, type: :controller do
  let(:user_a) { create(:user) }
  let(:user_b) { create(:user) }

  context "Signed in users" do
    before do
      request.env["HTTP_REFERER"] = ""
      sign_in(user_a)
    end

    describe 'POST #create' do
      it "Creates a new follow" do
        post :create, following: user_b.id

        user_a.reload
        expect(user_a.followings).to include(user_b)
      end

      it "Gives an error if the follow already exists" do
        user_a.followings << user_b
        post :create, following: user_b.id

        expect(flash[:alert]).to be_present
      end

      # it "Gives an error if the user isn't found" do
      #   post :create, following: "0"

      #   expect(flash[:alert]).to be_present
      # end       
    end

    describe 'DELETE #destroy' do
      it "Removes the following relationship" do
        user_a.followings << user_b
        delete :destroy, following: user_b.id

        user_a.reload
        expect(user_a.followings).not_to include(user_b)
      end
    end     
  end

  context "Visitors" do
    describe 'POST #create' do
      it "redirects to sign in" do
        post :create, following: user_a.id

        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'DELETE #destroy' do
      it "redirects to sign in" do
        delete :destroy, following: user_a.id

        expect(response).to redirect_to new_user_session_path
      end
    end    
  end
end

# patch :update, profile: {avatar: photo_upload}

# user.profile.reload
# expect(user.profile.avatar_file_name).to eq("test.png")