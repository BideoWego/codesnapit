require 'rails_helper'


describe SnapItProxiesController do
  let(:user) { create(:user) }
  let(:snap_it_proxy) { create(:snap_it_proxy, :user => user) }

  before do
    VCR.use_cassette 'screenshot_api/get_base64' do
      snap_it_proxy
    end
  end

  describe 'GET #show' do
    before do
      # sign_in(user)
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
end





