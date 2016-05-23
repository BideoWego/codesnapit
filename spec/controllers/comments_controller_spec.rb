require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:snap_it) { create(:snap_it) }
  let!(:comment) { create(:comment, author: user, parent: snap_it) }
  let!(:another_comment) { create(:comment) }
  let(:json) { JSON.parse( response.body ) }

  context "Visitors/signed out users" do
    describe "GET #index" do
      it "returns all the parent model's comments" do
        get :index, parent_type: "snap_it", parent_id: snap_it.id, format: :json

        expect(json[0]["id"]).to eq(comment.id)
      end

      it "returns 422 if the parent id is invalid" do
        get :index, parent_type: "snap_it", parent_id: 0, format: :json
      end

      it "returns 422 if the parent type is invalid" do
        get :index, parent_type: "foobar", parent_id: snap_it.id, format: :json
      end
    end

    describe "POST #create" do
      it "does not create a comment, returns 401 http status" do
        expect { 

          post :create, 
            parent_type: "snap_it", 
            parent_id: snap_it.id,
            body: "a",
            format: :json

        }.not_to change(Comment, :count)

        expect(response).to have_http_status(401)
      end
    end

    describe "DELETE #destroy" do
      it "does not delete the comment, returns 401 http status" do
        expect { 

          delete :destroy, 
            id: another_comment.id,
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
      it "creates a new comment authored by the user, returns that comment" do
        expect { 

          post :create, 
            parent_type: "snap_it", 
            parent_id: snap_it.id,
            body: "some cool observation",
            format: :json

        }.to change(Comment, :count).by(1)

        expect(json["body"]).to eq("some cool observation")
        expect(json["author"]["id"]).to eq(user.id)
      end

      it "returns 422 if the comment is invalid" do
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
      it "deletes the users comment, returns deleted comment" do
        expect { 

          delete :destroy, 
            id: comment.id,
            format: :json

        }.to change(Comment, :count).by(-1)

        expect(json["id"]).to eq(comment.id)        
      end

      it "does not allow deletion of another user's comment" do
        expect { 

          delete :destroy, 
            id: another_comment.id,
            format: :json

        }.not_to change(Comment, :count)

        expect(response).to have_http_status(422)            
      end
    end
  end  
end
