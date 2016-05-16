require 'rails_helper'


describe SnapItThemesController do
  let(:snap_it_theme) { create(:snap_it_theme) }
  let(:snap_it_themes) { SnapItTheme.all }
  let(:response_json) { JSON.parse(response.body) }

  describe 'GET #index' do
    before do
      snap_it_theme
      get :index, :format => :json
    end


    it 'returns a status of 200' do
      expect(response.status).to eq(200)
    end


    it 'returns a list of all snap_it_themes' do
      expect(response.body).to eq(snap_it_themes.to_json)
    end
  end
end





