require 'rails_helper'


describe SnapItsController do
  let!(:snap_it_language) { create(:snap_it_language) }
  let!(:snap_it_theme) { create(:snap_it_theme) }
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:snap_it) do
    create(
      :snap_it,
      :user => user,
      :snap_it_language_id => snap_it_language.id,
      :snap_it_theme_id => snap_it_theme.id
    )
  end
  let(:another_user_snap_it) do
    create(
      :snap_it,
      :user => another_user,
      :snap_it_language_id => snap_it_language.id,
      :snap_it_theme_id => snap_it_theme.id
    )
  end
  let(:snap_it_proxy) do
    create(
      :snap_it_proxy,
      :user => user,
      :snap_it_language_id => snap_it_language.id,
      :snap_it_theme_id => snap_it_theme.id
    )
  end


  before do
    request.env['HTTP_REFERER'] = root_url
  end


  describe 'GET #show' do
    context 'the snap_it ID is valid' do
      before do
        get :show, :id => snap_it.id
      end

      it 'renders the snap_it show template' do
        expect(response).to render_template(:show)
      end


      it 'sets the snap_it with the given ID' do
        expect(assigns[:snap_it]).to eq(snap_it)
      end
    end


    context 'the snap_it ID is invalid' do
      before do
        get :show, :id => 0
      end

      it 'redirects to back' do
        expect(response).to redirect_to :back
      end

      it 'sets an error flash' do
        expect(flash_error).to_not be_nil
      end
    end
  end


  describe 'GET #new' do
    before do
      get :new
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end


    it 'sets a variable for font_sizes' do
      expect(assigns[:font_sizes]).to eq(SnapItProxy::FONT_SIZES)
    end


    it 'sets a variable for snap_it_languages' do
      expect(assigns[:snap_it_languages]).to eq(SnapItLanguage.all)
    end


    it 'sets a variable for snap_it_themes' do
      expect(assigns[:snap_it_themes]).to eq(SnapItTheme.all)
    end
  end


  describe 'POST #create' do
    let(:post_create_valid) do
      post :create, :snap_it => { :token => snap_it_proxy.token }
    end
    let(:post_create_invalid) do
      post :create, :snap_it => { :token => 'Not a token!' }
    end

    before do
      snap_it_proxy
    end

    context 'the user is signed in' do
      before do
        sign_in(user)
      end

      context 'the params are valid' do
        it 'creates the snap_it' do
          expect { post_create_valid }.to change(SnapIt, :count).by(1)
        end


        it 'sets a success flash' do
          post_create_valid
          expect(flash_success).to be_present
        end


        it 'redirects to the snap_it' do
          post_create_valid
          snap_it = SnapIt.last
          expect(response).to redirect_to snap_it
        end
      end


      context 'the params are invalid' do
        it 'does not create the snap_it' do
          expect { post_create_invalid }.to change(SnapIt, :count).by(0)
        end


        it 'redirects to the new snap_it form' do
          post_create_invalid
          expect(response).to redirect_to new_snap_it_url
        end


        it 'sets an error flash' do
          post_create_invalid
          expect(flash_error).to be_present
        end
      end
    end


    context 'the user is signed out' do
      it 'does not create the snap_it' do
        expect { post_create_valid }.to change(SnapIt, :count).by(0)
      end


      it 'redirects to sign_in' do
        post_create_valid
        expect(response).to redirect_to new_user_session_url
      end


      it 'sets an error flash' do
        post_create_valid
        expect(flash_error).to be_present
      end
    end
  end


  describe 'DELETE #destroy' do
    let(:delete_destroy_valid) do
      delete :destroy, :id => snap_it.id
    end
    let(:delete_destroy_invalid) do
      delete :destroy, :id => 0
    end
    let(:delete_destroy_hacker) do
      delete :destroy, :id => another_user_snap_it.id
    end


    before do
      snap_it
    end


    context 'the user is signed in' do
      before do
        sign_in(user)
      end


      context 'the ID is valid' do
        it 'deletes the snap_it' do
          expect { delete_destroy_valid }.to change(SnapIt, :count).by(-1)
        end


        it 'redirects to user profile' do
          delete_destroy_valid
          expect(response).to redirect_to user_profile_url(user)
        end


        it 'sets a success flash' do
          delete_destroy_valid
          expect(flash_success).to be_present
        end
      end


      context 'the ID is invalid' do
        it 'does not delete the snap_it' do
          expect { delete_destroy_invalid }.to change(SnapIt, :count).by(0)
        end


        it 'redirects to back' do
          delete_destroy_invalid
          expect(response).to redirect_to :back
        end


        it 'sets an error flash' do
          delete_destroy_invalid
          expect(flash_error).to be_present
        end
      end


      context 'the snap_it belongs to another user' do
        before do
          another_user_snap_it
        end


        it 'does not delete the snap_it' do
          expect { delete_destroy_hacker }.to change(SnapIt, :count).by(0)
        end


        it 'redirects to back' do
          delete_destroy_hacker
          expect(response).to redirect_to :back
        end


        it 'sets an error flash' do
          delete_destroy_hacker
          expect(flash_error).to be_present
        end
      end
    end


    context 'the user is signed out' do
      before do
        snap_it
      end

      it 'does not delete the snap_it' do
        expect { delete_destroy_valid }.to change(SnapIt, :count).by(0)
      end


      it 'redirects to sign_in' do
        delete_destroy_valid
        expect(response).to redirect_to new_user_session_url
      end


      it 'sets an error flash' do
        delete_destroy_valid
        expect(flash_error).to be_present
      end
    end
  end
end

















