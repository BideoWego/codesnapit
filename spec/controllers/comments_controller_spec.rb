require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:snap_it) { create(:snap_it) }
  let!(:comment) { create(:comment, author: user, parent: snap_it) }
  let(:json) { JSON.parse( response.body ) }

  context "Visitors/signed out users" do
    describe "GET #index" do
      it "returns all the parent model's comments" do
        get :index, parent_type: "snap_it", parent_id: snap_it.id, format: :json

        expect(json[0]["id"]).to eq(comment.id)
      end
    end

    describe "POST #create" do
      it "returns 401 http status" do
        
      end
    end
  end

  context "Signed in users" do
    before do
      sign_in(user)
    end

    describe "POST #create" do
      it "creates a new comment authored by the user" do
        expect { 

          post :create, 
            parent_type: "snap_it", 
            parent_id: snap_it.id,
            body: "some cool observation",
            format: :json

        }.to change(Comment, :count).by(1)
      end
    end
  end  
end
