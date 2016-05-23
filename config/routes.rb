Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations' }
  resource :follow, only: [:create, :destroy]
  resource :profile, only: [:edit, :update]
  get 'users/:id', to: 'profiles#show', as: :user_profile
  get '/search', to: 'search#search'

  resources :snap_its, :except => [:index, :edit, :update]
  resource :snap_it_proxy, :only => [:show]
  resources :activities, :only => [:index]

  scope :api do
    scope :v1 do
      resources :snap_it_proxies, :only => [:create]
      resources :snap_it_languages, :only => [:index]
      resources :snap_it_themes, :only => [:index]
      resources :comments, :only => [:index, :create, :destroy]
      resources :likes, :only => [:index, :create, :destroy]
      resources :tags, :only => [:index]
    end
  end

  root 'static_pages#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
