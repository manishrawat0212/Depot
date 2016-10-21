Rails.application.routes.draw do

  constraints user_agent: /Chrome/ do
    get "/" => "store#index"
  end

  constraints(-> (req) { req.env["HTTP_USER_AGENT"] !~ /Chrome/ }) do
    resources :ratings

    get 'my-orders' => 'users#orders'
    get 'my-items' => 'users#line_items'

    namespace :admin do
      get 'categories/show'
      get 'categories' => 'categories#index'
      # get 'categories/:id/books', to: 'categories#show', constraints: { id: /\d+/ }
    end

    namespace :admin do
      post 'reports/show_orders'
      resources :reports
    end

    resources :subcategories

    get 'categories/all'
    resources :categories

    controller :sessions do
      get 'login' => :new
      post 'login' => :create
      delete 'logout' => :destroy
    end

    get 'sessions/new'

    get 'sessions/create'

    get 'sessions/destroy'

    get 'users/orders'
    get 'users/line_items'
    post 'users/show_line_items'
    resources :users

    resources :orders

    resources :line_items

    resources :carts

    get 'store/index'

    resources :books, controller: "products"
    resources :products do
      get :who_bought, on: :member
    end

    scope '(:locale)' do
      resources :orders
      resources :line_items
      resources :carts
      root 'store#index', as: 'store', via: :all
    end
  end
end

    # The priority is based upon order of creation: first created -> highest priority.
    # See how all your routes lay out with "rake routes".

    # You can have the root of your site routed with "root"
    # root 'store#index', as: 'store'
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
