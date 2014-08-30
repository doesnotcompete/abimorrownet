Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: "home#index"

  resources :profiles do
    resources :quotes
  end
  resources :committees
  resources :groups
  resources :teachers do
    resources :quotes
  end

  delete "users/:id" => "users#destroy", as: :user

  post "profiles/:profile_id/quotes/:quote_id/approve" => "quotes#approve", as: :approve_profile_quote
  post "teachers/:teacher_id/quotes/:quote_id/approve" => "quotes#approve", as: :approve_teacher_quote

  get "committees/:id/participate" => "committees#prepare_participation", as: :prepare_participation
  post "committees/:id/participate" => "committees#participate", as: :participate
  delete "committees/:id/participate" => "committees#departicipate", as: :departicipate

  delete "users/identity" => "users#remove_association", as: :remove_association
  get "users/invited" => "users#list_invited", as: :invited_users
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
