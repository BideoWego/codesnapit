require 'rails_helper'


describe StaticPagesController do
  describe 'GET #index' do
    it 'works' do
      get :index
      expect(response.status).to eq(200)
    end
  end
end


