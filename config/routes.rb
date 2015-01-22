Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: "home#index"

  get "intro" => "home#intro", as: :intro

  resources :profiles do
    resources :quotes
  end
  resources :committees
  resources :groups
  resources :teachers do
    resources :quotes
  end

  resources :announcements

  resources :votings do
    resources :voting_options
    resources :votes
  end

  resources :contents

  get "votings/:voting_id/voting_options/:option_id/select" => "voting_options#select", as: :select_voting_option
  get "votings/:voting_id/voting_options/:option_id/deselect" => "voting_options#deselect", as: :deselect_voting_option
  get "votings/:voting_id/votes/:vote_id/lock" => "votes#lock", as: :lock_vote

  get "contents/new/thanks" => "contents#complete", as: :content_complete

  delete "users/:id" => "users#destroy", as: :user

  get "quotes/approve" => "quotes#show_pending", as: :pending_quotes

  get "eintragen" => "student_registration#new"
  post "eintragen" => "student_registration#create"
  get "eintragen/abgeschlossen" => "student_registration#finished", as: :finished_registration

  post "profiles/:profile_id/quotes/:quote_id/approve" => "quotes#approve", as: :approve_profile_quote
  post "teachers/:teacher_id/quotes/:quote_id/approve" => "quotes#approve", as: :approve_teacher_quote

  patch "profiles/:profile_id/quotes/:quote_id/edit" => "quotes#update", as: :update_profile_quote

  get "committees/:id/participate" => "committees#prepare_participation", as: :prepare_participation
  post "committees/:id/participate" => "committees#participate", as: :participate
  delete "committees/:id/participate" => "committees#departicipate", as: :departicipate

  post "users/identity/disassociate" => "users#remove_association", as: :remove_association
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
