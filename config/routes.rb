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
    resources :awards do
      resources :nominations
    end
  end
  
  resources :content_problems

  resources :products
  resources :orders
  post "orders/shipping" => "orders#shipping", as: :order_shipping
  patch "orders/:id/paid" => "orders#paid", as: :mark_order_as_paid

  resources :contents

  get "votings/:voting_id/voting_options/:option_id/select" => "voting_options#select", as: :select_voting_option
  get "votings/:voting_id/voting_options/:option_id/deselect" => "voting_options#deselect", as: :deselect_voting_option
  get "votings/:voting_id/votes/:vote_id/lock" => "votes#lock", as: :lock_vote
  get "votings/:voting_id/votes/new/selective/:max_choices" => "votes#new_selection", as: :new_selective_votes
  get "votings/:voting_id/results" => "votings#results", as: :voting_results
  delete "votings/:voting_id/cleanup" => "voting_options#cleanup", as: :cleanup_voting

  get "votings/:voting_id/awards/:award_id/nominate" => "awards#nominate", as: :nominate_for_awards

  get "votings/:voting_id/awards/:award_id/nominations/:nomination_id/accept" => "nominations#accept", as: :accept_nomination
  get "votings/:voting_id/awards/:award_id/nominations/:nomination_id/dismiss" => "nominations#dismiss", as: :dismiss_nomination
  get "votings/:voting_id/awards/:award_id/nominations/:nomination_id/reset" => "nominations#reset", as: :reset_nomination

  get "notifications/:user_id/stop/:stop_key" => "users#stop_notifications", as: :stop_notifications

  get "votes/validate" => "votes#validate_vote", as: :vote_validation
  post "votes/validate" => "votes#validate", as: :validate_vote

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
  get "users/become" => "users#become", as: :become_user
  post "users/become" => "users#become_user", as: :sign_in_as_user
  
  get "validations/:token" => "validations#index", as: :main_validations
  get "validations/:token/comments" => "validations#comments", as: :validate_comments
  get "validations/:token/contents" => "validations#contents", as: :validate_contents
  get "validations/:token/questions" => "validations#questions", as: :validate_questions
  get "validations/:token/contents/:content_id/report" => "validations#report_content", as: :report_content
  post "validations/:token/contents/:content_id/report" => "validations#create_report", as: :create_content_problem
  
  post "validations/:token/quick_order" => "validations#quick_order", as: :create_quick_order
  
  get "validations/:token/final" => "validations#final", as: :validation_final
  
  post "content_problems/:id/accept" => "content_problems#accept", as: :accept_report
  get "content_problems/:id/reject" => "content_problems#prepare_rejection", as: :prepare_report_rejection
  post "content_problems/:id/reject" => "content_problems#reject", as: :reject_report
  
  patch "validations/:token/comments/:comment_id/lock" => "validations#lock_comment", as: :lock_comment
  get "tokens" => "validations#access_tokens", as: :own_access_tokens
  get "validations/:token/wrong_identity" => "validations#wrong_identity", as: :validation_wrong_identity
  get "validations/:token/error" => "validations#fatal_error", as: :validation_error
  get "validations/:token/invalid" => "validations#invalid", as: :invalid_token
  
  get "contents/:content_id/association/new" => "contents#new_association", as: :new_content_association
  post "contents/:content_id/association/new" => "contents#create_association", as: :create_content_association
  delete "contents/:content_id/association/:assoc_id" => "contents#destroy_association", as: :destroy_content_association
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
