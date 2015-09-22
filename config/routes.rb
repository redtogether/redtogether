Rails.application.routes.draw do
  get 'comment/create'

  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root "front_page#index"

  get "c/:name" => "channel#show", as: :channel
  post "c/:name/subscribe" => "channel#subscribe", as: :channel_subscribe
  post "c/:name/unsubscribe" => "channel#unsubscribe", as: :channel_unsubscribe
  get "c/:name/submit" => "post#new", as: :submit_post
  post "c/:name/submit" => "post#create", as: :posts

  get "p/:slug" => "post#show", as: :post
  post "p/:slug/submit" => "comment#create", as: :submit_comment

  get "x/:slug" => "comment#show", as: :comment
  post "x/:slug/submit" => "comment#reply", as: :comment_reply

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
