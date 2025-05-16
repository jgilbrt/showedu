Rails.application.routes.draw do
  devise_for :users, skip: [:sessions]
  as :user do
    get    'sign_in',  to: 'devise/sessions#new',     as: :new_user_session
    post   'sign_in',  to: 'devise/sessions#create',  as: :user_session
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  get 'pages/home'
  get "up" => "rails/health#show", as: :rails_health_check

  root to: 'pages#home'

  resources :showus, only: [:index, :new, :create]

  resources :users, only: [:show], param: :username do
    collection do
      get :search
    end
    member do
      post :follow
      delete :unfollow
    end
  end
end
