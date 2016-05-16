require 'rails_helper'


describe SnapItsController do
  let(:snap_it_language) { create(:snap_it_language) }
  let(:snap_it_theme) { create(:snap_it_theme) }
  let(:user) { create(:user) }
  let(:snap_it) { create(:snap_it, :user => user) }
  let(:snap_it_proxy) { create(:snap_it_proxy, :user => user) }


  before do
    snap_it_language
    snap_it_theme
    request.env['HTTP_REFERER'] = root_url
  end


  describe 'GET #show' do
  end


  describe 'GET #new' do
  end


  describe 'POST #create' do
  end


  describe 'DELETE #destroy' do
  end
end





