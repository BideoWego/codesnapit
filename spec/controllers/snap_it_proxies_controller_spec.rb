require 'rails_helper'


describe SnapItProxiesController do
  let(:user) { create(:user) }
  let(:snap_it_proxy) do
    create(:snap_it_proxy, :user => user)
  end

  before do
    VCR.use_cassette 'screenshot_api/get_base64' do
      snap_it_proxy
    end
  end

  describe 'GET #show' do
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


    describe 'POST #create' do
      it 'needs tests'
    end
  end
end





