Rails.application.routes.draw do
devise_for :users, skip: [:sessions]
as :user do
  get    'sign_in',  to: 'devise/sessions#new',     as: :new_user_session
  post   'sign_in',  to: 'devise/sessions#create',  as: :user_session
  delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
end
  get 'pages/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root to: 'pages#home'
  resources :showus, only: [:index, :new, :create]

  resources :users, only: [:show], constraints: { id: /\d+/ } do
  collection do
    get :search
  end
end



end
