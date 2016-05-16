require 'rails_helper'


describe SnapItLanguagesController do
  let(:snap_it_language) { create(:snap_it_language) }
  let(:snap_it_languages) { SnapItLanguage.all }
  let(:response_json) { JSON.parse(response.body) }

  describe 'GET #index' do
    before do
      snap_it_language
      get :index, :format => :json
    end


    it 'returns a status of 200' do
      expect(response.status).to eq(200)
    end


    it 'returns a list of all snap_it_languages' do
      expect(response.body).to eq(snap_it_languages.to_json)
    end
  end
end





