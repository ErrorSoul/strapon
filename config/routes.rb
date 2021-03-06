Rails.application.routes.draw do
  get 'user_sessions/create'

  get 'user_sessions/destroy'


  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  root 'main_pages#intro'
  get '/index' => 'main_pages#index'
  get '/main_posts' => 'main_pages#posts'
 
  get '/admin' => 'admins#index'
  get "/auth/:provider/callback" => "user_sessions#create"
  get '/cart' => "main_pages#cart"
  get '/photos/:id/:post_id' => "photos#show"
  resources :posts
  resources :carts, only: [:show, :destroy]
  resources :sessions, only: [:create, :destroy]
  resources :line_items, only: [:create, :destroy]
  
  resources :authors, only: [:update, :show, :create] 
  resources :photos, only: [:create, :show]
  resources :comments, only: [:create, :show]
  get "robots.txt" => "main_pages#robots", defaults: {format: 'txt'}, as: :robots
  get "sitemap.xml" => "main_pages#sitemap",  defaults: {format: :xml}, as: :sitemap
  
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
