require 'rails_helper'


describe SnapItProxiesController do
  let(:snap_it_language) { create(:snap_it_language) }
  let(:snap_it_theme) { create(:snap_it_theme) }
  let(:user) { create(:user) }
  let(:snap_it_proxy) do
    create(:snap_it_proxy, :user => user)
  end

  before do
    request.env['HTTP_REFERER'] = new_user_session_url
  end

  describe 'GET #show' do
    before do
      VCR.use_cassette 'screenshot_api/get_base64' do
        snap_it_proxy
      end
    end


    context 'there is a valid token present' do
      before do
        get :show, :token => snap_it_proxy.token
      end


      it 'returns status of 200' do
        expect(response.status).to eq(200)
      end


      it 'renders the show template' do
        expect(response).to render_template(:show)
      end


      it 'assigns the snap_it_proxy' do
        expect(assigns[:snap_it_proxy]).to eq(snap_it_proxy)
      end
    end


    context 'there is no token present' do
      before do
        get :show
      end


      it 'returns a status of 404' do
        expect(response.status).to eq(404)
      end


      it 'renders the 404 page' do
        expect(response).to render_404
      end
    end


    context 'there is an invalid token present' do
      before do
        get :show, :token => 'Not a token!'
      end


      it 'returns a status of 404' do
        expect(response.status).to eq(404)
      end


      it 'renders the 404 page' do
        expect(response).to render_404
      end
    end
  end

  describe 'POST #create' do
    let(:response_json) { JSON.parse(response.body) }
    let(:post_create_valid) do
      post :create, :format => :json, :snap_it_proxy => attributes_for(
        :snap_it_proxy,
        :snap_it_language_id => snap_it_language.id,
        :snap_it_theme_id => snap_it_theme.id
      ).except(:image_data)
    end
    let(:post_create_without_title) do
      post :create, :format => :json, :snap_it_proxy => attributes_for(
        :snap_it_proxy,
        :title => nil,
        :snap_it_language_id => snap_it_language.id,
        :snap_it_theme_id => snap_it_theme.id
      ).except(:image_data)
    end


    context 'the user is signed in' do
      before do
        sign_in(user)
      end


      context 'the params are valid' do
        it 'creates the snap_it_proxy' do
          VCR.use_cassette 'screenshot_api/get_base64' do
            expect { post_create_valid }.to change(SnapItProxy, :count).by(1)
          end
        end


        it 'returns the snap_it_proxy as json' do
          VCR.use_cassette 'screenshot_api/get_base64' do
            post_create_valid
            snap_it_proxy = SnapItProxy.last
            expect(response_json['image_data']).to eq(snap_it_proxy.image_data)
          end
        end
      end


      context 'the params are invalid' do
        it 'does not create the snap_it_proxy' do
          VCR.use_cassette 'screenshot_api/get_base64' do
            expect { post_create_without_title }.to change(SnapItProxy, :count).by(0)
          end
        end


        it 'returns an object with an error message' do
          VCR.use_cassette 'screenshot_api/get_base64' do
            post_create_without_title
            expect(response_json['error']).to_not be_nil
          end
        end
      end
    end


    context 'the user is signed out' do
      it 'redirects to back' do
        post_create_valid
        expect(response.status).to eq(401)
      end
    end
  end
end




















