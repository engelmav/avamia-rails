Rails.application.routes.draw do
  devise_for :users, skip: :all
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      devise_scope :user do
        post 'user/sign_in' => 'sessions#create'
        delete 'user/sign_out' => 'sessions#destroy'
        post 'user/sign_up' => 'users#create'
      end

      resources :companies, only: [:index] do
        collection do
          post "search", to: "companies/search"
        end
      end
    end
  end
end
