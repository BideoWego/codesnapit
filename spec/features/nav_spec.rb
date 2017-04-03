require 'rails_helper'


describe 'Site Navigation Features' do
  let(:user) { create(:user) }

  it 'clicking the brand button takes them to root path'
  it 'clicking the center button takes them to code editor'

  describe 'Visitors' do
    it 'clicking the sign up button takes them to sign up page'
    it 'clicking the login link takes them to the login page'
    it 'does not show the user avatar'
    it 'does not contain the member dropdown menu'
    it 'does not contain a logout link'
  end


  describe 'Members' do
    it 'clicking the logout link logs out the user'
    it 'clicking the user avatar displays a dropdown'
    it 'clicking the edit profile link takes the user to the edit profile page'
    it 'clicking the timeline link takes the user to their timeline'
    it 'clicking the account settings link takes the user to their account settings'
    it 'does not contain a login link'
    it 'does not show a sign up button'
  end
end






