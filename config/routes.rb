WineCards::Application.routes.draw do

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :wines do
    resources :comments, shallow: true
  end
  # because there's no reason to show or update them. 

  root 'static_pages#home'
  match '/signup',        to: 'users#new',               via: 'get'
  match '/signin',        to: 'sessions#new',            via: 'get'
  match '/signout',       to: 'sessions#destroy',        via: 'delete'    
  match '/help',          to: 'static_pages#help',       via: 'get'
  match '/contact',       to: 'static_pages#contact',    via: 'get'
  match '/about',         to: 'static_pages#about',      via: 'get'
  match '/champagne',     to: 'wines#champagne',         via: 'get'
  match '/burgundywhite', to: 'wines#burgundywhite',     via: 'get'
  match '/burgundyred',   to: 'wines#burgundyred',       via: 'get'
  match '/bordeauxred',   to: 'wines#bordeauxred',       via: 'get'
  match '/propblends',    to: 'wines#propblends',        via: 'get'
  match '/spain',         to: 'wines#spain',             via: 'get'
  match '/pinotnoir',     to: 'wines#pinotnoir',         via: 'get'
  match '/cabsauv',       to: 'wines#cabsauv',           via: 'get'
  match '/merlot',        to: 'wines#merlot',            via: 'get'
  match '/syrah',         to: 'wines#syrah',             via: 'get'
  match '/zinfandel',     to: 'wines#zinfandel',         via: 'get'
  match '/rhone',         to: 'wines#rhone',             via: 'get'
  match '/loire',         to: 'wines#loire',             via: 'get'
  match '/chardonnay',    to: 'wines#chardonnay',        via: 'get'
  match '/sauvblanc',     to: 'wines#sauvblanc',         via: 'get'
  match '/intwhites',     to: 'wines#interestingwhites', via: 'get'
  match '/intreds',       to: 'wines#interestingreds',   via: 'get'
  match '/italywhite',    to: 'wines#italywhite',        via: 'get'
  match '/italyred',      to: 'wines#italyred',          via: 'get'
  match '/aus_nz_white',  to: 'wines#aus_nz_white',      via: 'get'
  match '/aus_nz_red',    to: 'wines#aus_nz_red',        via: 'get'
  match '/chile_arg',     to: 'wines#chile_arg',         via: 'get'
  match '/half_champ_sp', to: 'wines#half_champ_sp',     via: 'get'
  match '/half_white',    to: 'wines#half_white',        via: 'get'
  match '/half_red',      to: 'wines#half_red',          via: 'get'

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
