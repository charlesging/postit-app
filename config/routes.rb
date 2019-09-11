

PostitTemplate::Application.routes.draw do
  root to: 'posts#index' # posts controller index action

  get '/register', to: 'users#new' # 
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy' # rails assumes logout_path

  resources :posts, except: [:destroy] do
    member do # member routes pertain to individual instance of the post resource
      post 'vote'
    end

    collection do
      get 'archives'
    end

    resources :comments, only: [:create] do
      member do
        post 'vote'
      end
    end
  end
  resources :categories, only: [:new, :create, :show]

  resources :users, only: [:show, :create, :edit, :update]
end
