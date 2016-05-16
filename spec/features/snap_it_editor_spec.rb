require 'rails_helper'


describe 'SnapIt Editor Features', :type => :feature do
  let(:javascript_language) do
    create(:snap_it_language)
  end
  let(:monokai_theme) do
    create(:snap_it_theme)
  end
  let(:ruby_language) do
    create(:snap_it_language, :name => 'Ruby', :editor_name => 'ruby')
  end
  let(:textmate_theme) do
    create(:snap_it_theme, :name => 'Textmate', :editor_name => 'textmate')
  end
  let(:user) { create(:user) }


  before do
    javascript_language
    ruby_language
    monokai_theme
    textmate_theme
    user
  end


  context 'always' do
    before do
      visit new_snap_it_path
    end


    it 'populates a dropdown with snap_it_languages' do
      expect(page).to have_select('language', :options => SnapItLanguage.all.pluck(:name).to_a)
    end


    it 'populates a dropdown with snap_it_themes' do
      expect(page).to have_select('theme', :options => SnapItTheme.all.pluck(:name).to_a)
    end


    it 'populates a dropdown with font_sizes' do
      expect(page).to have_select('font_size', :options => SnapItProxy::FONT_SIZES.map(&:to_s))
    end
  end


  context 'the user is signed in' do
    before do
      capy_sign_in(user)
      visit new_snap_it_path
    end


    it 'displays a create snap_it preview button' do
      expect(page).to have_text('Preview SnapIt!')
    end
  end


  context 'the user is signed out' do
    before do
      visit new_snap_it_path
    end


    it 'displays a sign up to preview snap_it button' do
      expect(page).to have_text('Sign Up to Preview!')
    end
  end
end





