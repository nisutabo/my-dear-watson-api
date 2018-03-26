Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :twitter_accounts
      resources :word_counts, only: [:index, :show]
      resources :consumption_preferences, only: [:index, :show]
      resources :values, only: [:index, :show]
      resources :needs, only: [:index, :show]
      resources :personalities, only: [:index, :show]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
