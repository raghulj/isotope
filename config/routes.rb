ActionController::Routing::Routes.draw do |map|
  map.resources :milestones

  map.resources :chirps

  map.resources :snippets, :collection => {:my_snippets => :get }

  map.resources :gtds

  map.resources :keys

  map.resources :repositories

  map.resources :comments

  map.resources :tickets

  map.resources :todos
  
  map.resources :source, :collection => {:get_repos => :post, :index => :post, :tree_items => :post, :view_file => :post }

  map.resources :projects, :collection => {:settings => :get, :add_user => :post, :delete_user => :post }
 
  map.resource :login, :controller => "user_session"
  map.resource :user_session
  map.resources :users
  map.resources :calendars


  map.resources :dashboard
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
      map.resources :projects, :has_many => [:tickets,  :todos, :repositories,:milestones] ,:collection => {:settings => :get }
      map.resources :projects do | project|
        project.resources :messages do | message|
          message.resource :comments
        end
      end
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"
    map.root :controller => "user_sessions", :action => "new"
  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
