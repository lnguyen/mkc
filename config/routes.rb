Mkc::Application.routes.draw do                                                
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } 
  
  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy' 
  end  
  match '/auth/:service/callback' => 'services#create'
  
  resources :services, :only => [:index, :create, :destroy]
               
  resources :users    
  resources :comments
  resources :searches
  resources :communities 
  
  match 'join'    => 'communities#join_community', :via => :get
  match 'leave'   => 'communities#leave_community', :via => :get 

  # The priority is based upon order of creation:
  # first created -> highest priority.
  
  match 'about' => 'page#about'

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
  root :to => 'page#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id(.:format)))'
end
