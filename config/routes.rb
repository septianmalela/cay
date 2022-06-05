Rails.application.routes.draw do
  devise_for :users, controllers: {
         sessions: 'users/sessions',
    registrations: 'users/registrations',
      invitations: 'users/invitations',
        passwords: 'users/passwords'
  }
  resources :homes
  root 'homes#index'

  namespace :user do
    resources :follows, only: :index do
      collection do
        put :follow
        put :unfollow
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
