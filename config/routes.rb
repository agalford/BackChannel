Backchannel::Application.routes.draw do
  #get "/login", :to => "devise/sessions#new" # Add a custom sign in route for user sign in
  #get "/logout", :to => "devise/sessions#destroy" # Add a custom sing out route for user sign out
  #get "/register", :to => "devise/registrations#new" # Add a Custom Route for Registrations
  #get "/users/sign_out", :to => "devise/sessions#destroy"

  devise_for :users
  resources :administrators
  resources :reply_votes
  resources :replies
  resources :post_votes
  resources :posts
  resources :users

  devise_for :users do
    get "sign_in", :to => "devise/sessions#new"
    get "sign_out", :to => "devise/sessions#destroy"
  end

  match 'posts/vote/:id', :to => 'posts#vote'
  match 'search', :to => 'posts#search'

  resources :administrators do
    member do
      get 'change_admin'
    end
  end

  resources :replies do
    member do
      get 'add_reply'
    end
  end

  match ':controller(/:id(/:action))'
  match ':controller/:action/:id'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'posts#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
