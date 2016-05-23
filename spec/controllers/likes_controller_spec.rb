require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:snap_it) { create(:snap_it) }
  let(:another_snap_it) { create(:snap_it) }
  let!(:like) { create(:like, creator: user, parent: snap_it) }
  let!(:another_like) { create(:like) }
  let(:json) { JSON.parse( response.body ) }

  context "Visitors/signed out users" do
    describe "GET #index" do
      it "returns all the parent model's likes" do
        get :index, parent_type: "snap_it", parent_id: snap_it.id, format: :json

        expect(json[0]["id"]).to eq(like.id)
      end

      it "returns 422 if the parent id is invalid" do
        get :index, parent_type: "snap_it", parent_id: 0, format: :json
      end

      it "returns 422 if the parent type is invalid" do
        get :index, parent_type: "foobar", parent_id: snap_it.id, format: :json
      end
    end

    describe "POST #create" do
      it "does not create a like, returns 401 http status" do
        expect { 

          post :create, 
            parent_type: "snap_it", 
            parent_id: snap_it.id,
            format: :json

        }.not_to change(Like, :count)

        expect(response).to have_http_status(401)
      end
    end

    describe "DELETE #destroy" do
      it "does not delete the like, returns 401 http status" do
        expect { 

          delete :destroy, 
            id: like.id,
            format: :json

        }.not_to change(Comment, :count)

        expect(response).to have_http_status(401)           
      end      
    end
  end

  context "Signed in users" do
    before do
      sign_in(user)
    end

    describe "POST #create" do
      it "creates a new like by the user, returns that like" do
        expect { 

          post :create, 
            parent_type: "snap_it", 
            parent_id: another_snap_it.id,
            format: :json

        }.to change(Like, :count).by(1)

        expect(json["user_id"]).to eq(user.id)
      end

      it "returns 422 if the like is invalid (already liked)" do
        expect { 

          post :create, 
            parent_type: "snap_it", 
            parent_id: snap_it.id,
            body: "a",
            format: :json

        }.not_to change(Comment, :count)

        expect(response).to have_http_status(422)    
      end
    end

    describe "DELETE #destroy" do
      it "deletes the user's like, returns deleted like" do
        expect { 

          delete :destroy, 
            id: like.id,
            format: :json

        }.to change(Like, :count).by(-1)

        expect(json["id"]).to eq(like.id)        
      end

      it "does not allow deletion of another user's like" do
        expect { 

          delete :destroy, 
            id: another_like.id,
            format: :json

        }.not_to change(Comment, :count)

        expect(response).to have_http_status(422)            
      end
    end
  end  
end
